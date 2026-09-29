"""MCP de leitura das amostras (Fase 2): conta, filtra e resume os CSVs de `base/dados/`.

Por que existe: na rodada de 2026-09-29, mandado medir, o agente passou a dar números — e 4 de 14
respostas traziam contagem ou atributo errado (40 → 39, 50 → 49, 17 → 18, "M" → "F"). Contar lendo
o arquivo não é confiável no modelo; contar aqui é.

Só leitura: abre os CSVs de um diretório fixo, montado somente-leitura, e nada mais. O nome do
ativo é conferido contra a listagem do diretório — não entra caminho vindo do modelo.

Números de linha são os do arquivo (o cabeçalho é a linha 1), para o agente citar como evidência.
"""

from __future__ import annotations

import csv
import os
import re
from pathlib import Path
from typing import Any

from mcp.server.mcpserver import MCPServer

DADOS = Path(os.environ.get("AMOSTRAS_DIR", "/opt/oficio/base/dados"))
LIMITE_LINHAS = 200

OPERADORES = ("=", "!=", "<", "<=", ">", ">=", "contem", "regex", "vazio", "nao_vazio")

servidor = MCPServer(
    "amostras",
    instructions=(
        "Conta, filtra e resume as amostras CSV de base/dados. Use para TODO número que for "
        "para o relatório (quantas linhas, quantas com X, menor/maior valor, tamanho de grupos): "
        "contar lendo o arquivo erra. Datas ISO (AAAA-MM-DD) comparam certo com < e >."
    ),
)


def _ativos() -> dict[str, Path]:
    return {p.stem: p for p in sorted(DADOS.glob("*.csv"))}


def _ler(ativo: str) -> tuple[list[str], list[tuple[int, dict[str, str]]]]:
    arquivos = _ativos()
    if ativo not in arquivos:
        raise ValueError(f"ativo {ativo!r} não tem amostra. Disponíveis: {', '.join(arquivos)}")
    with arquivos[ativo].open(encoding="utf-8", newline="") as f:
        leitor = csv.DictReader(f)
        colunas = list(leitor.fieldnames or [])
        # linha do arquivo: cabeçalho = 1, primeiro registro = 2
        return colunas, [(i, linha) for i, linha in enumerate(leitor, start=2)]


def _numero(valor: str) -> float | None:
    try:
        return float(valor.replace(",", "."))
    except ValueError:
        return None


def _compara(valor: str, op: str, alvo: str) -> bool:
    if op == "vazio":
        return valor.strip() == ""
    if op == "nao_vazio":
        return valor.strip() != ""
    if op == "=":
        return valor == alvo
    if op == "!=":
        return valor != alvo
    if op == "contem":
        return alvo.lower() in valor.lower()
    if op == "regex":
        return re.search(alvo, valor) is not None
    # < <= > >=: número quando os dois lados são número; senão texto (serve para data ISO)
    a, b = _numero(valor), _numero(alvo)
    x, y = (a, b) if a is not None and b is not None else (valor, alvo)
    return {"<": x < y, "<=": x <= y, ">": x > y, ">=": x >= y}[op]


def _filtra(colunas: list[str], linhas, filtros: list[dict[str, str]] | None):
    for filtro in filtros or []:
        coluna, op = filtro.get("coluna", ""), filtro.get("op", "=")
        if coluna not in colunas:
            raise ValueError(f"coluna {coluna!r} não existe. Colunas: {', '.join(colunas)}")
        if op not in OPERADORES:
            raise ValueError(f"operador {op!r} inválido. Use: {', '.join(OPERADORES)}")
        alvo = str(filtro.get("valor", ""))
        linhas = [(n, l) for n, l in linhas if _compara(l.get(coluna) or "", op, alvo)]
    return linhas


@servidor.tool()
def amostra_colunas(ativo: str) -> dict[str, Any]:
    """Colunas e total de registros da amostra de um ativo (ex.: "vendas.pedidos").
    Sem argumento válido, a mensagem de erro lista os ativos com amostra."""
    colunas, linhas = _ler(ativo)
    return {"ativo": ativo, "arquivo": f"base/dados/{ativo}.csv", "colunas": colunas,
            "registros": len(linhas)}


@servidor.tool()
def amostra_contar(ativo: str, filtros: list[dict[str, str]] | None = None,
                   agrupar_por: list[str] | None = None) -> dict[str, Any]:
    """Conta os registros que passam em TODOS os filtros; com agrupar_por, conta por combinação.

    filtros: lista de {"coluna", "op", "valor"}; op em = != < <= > >= contem regex vazio nao_vazio.
    Ex.: [{"coluna": "email_cliente", "op": "=", "valor": "nao-informado@aurora.invalid"}]
         [{"coluna": "data_nascimento", "op": ">", "valor": "2008-09-29"}]
         [{"coluna": "descricao", "op": "regex", "valor": "\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}"}]
    Devolve total da amostra, quantos passam, percentual e as linhas do arquivo que passam."""
    colunas, todas = _ler(ativo)
    linhas = _filtra(colunas, todas, filtros)
    saida: dict[str, Any] = {
        "ativo": ativo, "registros_na_amostra": len(todas), "passam_no_filtro": len(linhas),
        "percentual": round(100 * len(linhas) / len(todas), 1) if todas else 0.0,
        "linhas_do_arquivo": [n for n, _ in linhas],
    }
    if agrupar_por:
        for c in agrupar_por:
            if c not in colunas:
                raise ValueError(f"coluna {c!r} não existe. Colunas: {', '.join(colunas)}")
        grupos: dict[tuple[str, ...], int] = {}
        for _, l in linhas:
            chave = tuple(l.get(c) or "" for c in agrupar_por)
            grupos[chave] = grupos.get(chave, 0) + 1
        saida["grupos"] = [dict(zip(agrupar_por, k), registros=v)
                           for k, v in sorted(grupos.items(), key=lambda kv: (kv[1], kv[0]))]
    return saida


@servidor.tool()
def amostra_resumo(ativo: str, coluna: str,
                   filtros: list[dict[str, str]] | None = None) -> dict[str, Any]:
    """Resumo de uma coluna nos registros que passam nos filtros: vazios, distintos, menor e maior
    (numérico quando todos os preenchidos são número; senão ordem de texto, que serve para data ISO),
    e a linha do arquivo do menor e do maior."""
    colunas, todas = _ler(ativo)
    if coluna not in colunas:
        raise ValueError(f"coluna {coluna!r} não existe. Colunas: {', '.join(colunas)}")
    linhas = _filtra(colunas, todas, filtros)
    preenchidas = [(n, l[coluna]) for n, l in linhas if (l.get(coluna) or "").strip()]
    numericas = all(_numero(v) is not None for _, v in preenchidas)
    chave = (lambda nv: _numero(nv[1])) if numericas else (lambda nv: nv[1])
    menor = min(preenchidas, key=chave) if preenchidas else None
    maior = max(preenchidas, key=chave) if preenchidas else None
    return {
        "ativo": ativo, "coluna": coluna, "registros": len(linhas),
        "vazios": len(linhas) - len(preenchidas),
        "distintos": len({v for _, v in preenchidas}),
        "comparacao": "numérica" if numericas else "texto",
        "menor": menor and {"valor": menor[1], "linha": menor[0]},
        "maior": maior and {"valor": maior[1], "linha": maior[0]},
    }


@servidor.tool()
def amostra_linhas(ativo: str, filtros: list[dict[str, str]] | None = None,
                   colunas: list[str] | None = None, limite: int = 50) -> dict[str, Any]:
    """Os registros que passam nos filtros, com a linha do arquivo, só com as colunas pedidas.
    Até 200. Para citar evidência; nunca copie CPF ou dado de saúde inteiro para o relatório."""
    todas_colunas, todas = _ler(ativo)
    for c in colunas or []:
        if c not in todas_colunas:
            raise ValueError(f"coluna {c!r} não existe. Colunas: {', '.join(todas_colunas)}")
    linhas = _filtra(todas_colunas, todas, filtros)
    limite = max(1, min(limite, LIMITE_LINHAS))
    escolhidas = colunas or todas_colunas
    return {
        "ativo": ativo, "passam_no_filtro": len(linhas), "mostrando": min(limite, len(linhas)),
        "registros": [{"linha": n, **{c: l.get(c, "") for c in escolhidas}} for n, l in linhas[:limite]],
    }


if __name__ == "__main__":
    servidor.run()
