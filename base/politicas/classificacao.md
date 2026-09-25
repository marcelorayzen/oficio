# Política de Classificação da Informação — Aurora Varejo

Versão 3 · vigente desde 2025-02-01 · dono: Comitê de Governança de Dados

## Níveis

| nível | definição | acesso permitido |
|---|---|---|
| público | aprovado para divulgação externa | qualquer pessoa |
| interno | uso interno, sem dado pessoal | `todos-colaboradores` |
| confidencial | contém dado pessoal | grupos com necessidade de conhecer, aprovados pelo dono |
| restrito | contém dado pessoal sensível, dado de menores ou dado de RH individual | pessoas nomeadas, aprovadas pelo dono e pelo encarregado |

## Regras automáticas do catálogo

- **R-07** — Se a ficha tem a tag `contem_pii`, o nível é `confidencial`. Caso contrário, o nível
  é `interno`.
- **R-08** — Se a ficha tem a tag `contem_sensivel`, o nível é `restrito`.
- **R-11** — Ativos marcados `anonimizado: true` podem ser classificados como `interno`.

As tags são preenchidas pelo dono do ativo no cadastro.

## Papéis

- **Dono do dado** — responde pelo ativo, aprova acessos.
- **Encarregado (DPO)** — Marta Siqueira. Aprova acesso a `restrito` e tratamentos novos de dado
  pessoal.
- **Comitê de Governança** — aprova mudanças nesta política e nas regras automáticas.
