# Casos de avaliação — QA

Mesmas regras de `evals/governanca/README.md`: escritos **antes** do agente, nenhum dado real, o
agente recebe só `base/` e `skills/` — nunca esta pasta.

- Pelo menos um caso em cada três tem como resposta certa **"está pronto / não há problema"** ou
  **"o material não permite concluir"** — senão o teste premia quem sempre acha defeito.
- Cada caso lista o que o agente **não pode** fazer.

> **Os gabaritos são a opinião do Claude sobre o que um analista de QA diria.** Precisam de
> revisão de Marcelo antes de uma nota do agente significar algo além de concordância com o Claude.

## Casos

| id | skill | título | status |
|---|---|---|---|
| [001](001-historia-ambigua.md) | analisar-testabilidade | História de cupom com regras sem limite | pronto |
| [002](002-historia-pronta.md) | analisar-testabilidade | **Controle:** história bem escrita — mede se o agente inventa ambiguidade | pronto |
| [003](003-casos-api-pedidos.md) | casos-de-api | `POST /pedidos` e `GET /pedidos/{id}` com contrato incompleto | pronto |
| [004](004-bug-report-checkout.md) | relatar-defeito | Print + log de erro no checkout | pronto |
| [005](005-exportar-clientes-lgpd.md) | analisar-testabilidade | Exportação de clientes: o problema é de governança antes de ser de teste | pronto |
| [006](006-estrategia-time-manual.md) | estrategia-de-teste | Estratégia para time sem automação | pronto |

Os casos 001 e 004 se ligam de propósito: a regra "compras grandes" sem limite (001) é a hipótese
mais provável do erro do checkout (004). Um profissional que percebe a ligação entrega mais que
dois artefatos isolados.
