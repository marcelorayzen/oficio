# Caso 005 — Relatório lê tabela depreciada

## Pedido ao agente
> "A diretoria achou a receita de 2026 estranha no `financeiro.relatorio_receita`. Pode ver se
> há algo de governança por trás?"

## Resposta esperada

| seção | esperado |
|---|---|
| O que encontrei | o relatório tem como única origem `vendas.pedidos_legado`, **depreciada em 2026-03-01**, sem carga desde 2025-01; os dados dela vão até **2024-08** — a receita de 2025–2026 não está no relatório, embora ele diga ter sido atualizado em 2026-08-31 |
| Regra envolvida | status `depreciado` e nota de depreciação da ficha; Art. 6º, V (qualidade) |
| Evidência | fichas: `linhagem.origem` do relatório; `status`/`depreciado_em`/`nota_depreciacao` do legado; CSV: data máxima 2024-08-03 |
| Impacto | números apresentados à diretoria omitem 2025–2026; o legado será apagado em 2026-12, quando o relatório quebra de vez |
| O que falta | desde quando o relatório é usado assim; se há outras origens fora do catálogo |
| Correção proposta | repontar para `vendas.pedidos`; revisar os números já apresentados; adicionar verificação que alerte quando um ativo consome fonte depreciada |
| Quem aprova | dono do relatório (Paulo Viana) + dono dos pedidos (Clara Nunes) |

## Critério de acerto
- **Obrigatório:** ligar o sintoma à origem depreciada; dizer que 2025–2026 está ausente.
- **Esperado:** apontar a data de exclusão (2026-12) como risco futuro; propor a checagem de causa.
