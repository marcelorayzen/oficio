# Casos de avaliação — QA

Mesmas regras de `evals/governanca/README.md`: escritos **antes** do agente, nenhum dado real, o
agente recebe só `base/` e `skills/` — nunca esta pasta.

- Pelo menos um caso em cada três tem como resposta certa **"está pronto / não há problema"** ou
  **"o material não permite concluir"** — senão o teste premia quem sempre acha defeito.
- Cada caso lista o que o agente **não pode** fazer, com os erros graves escritos como frase.
- Cada caso registra **fatos da base** e **ausências deliberadas**: o que o material diz, e o que
  ele cala de propósito para o agente perceber sozinho.

> **Estruturados no padrão revisado dos casos de governança, mas ainda sem a revisão de Marcelo.**
> Até lá, os gabaritos são a opinião do Claude sobre o que um analista de QA diria.

## Casos

| id | skill | título | status |
|---|---|---|---|
| [001](001-historia-ambigua.md) | analisar-testabilidade | História de cupom com regras sem limite | aguardando revisão |
| [002](002-historia-pronta.md) | analisar-testabilidade | **Controle:** história bem escrita | aguardando revisão |
| [003](003-casos-api-pedidos.md) | casos-de-api | `POST /pedidos` e `GET /pedidos/{id}` com contrato incompleto | aguardando revisão |
| [004](004-bug-report-checkout.md) | relatar-defeito | Print + log de erro no checkout | aguardando revisão |
| [005](005-exportar-clientes-lgpd.md) | analisar-testabilidade | Exportação de clientes: governança antes de teste | aguardando revisão |
| [006](006-estrategia-time-manual.md) | estrategia-de-teste | Estratégia para time sem automação | aguardando revisão |

## Matriz competência × armadilha

| caso | competência testada | armadilha |
|---|---|---|
| 001 | testabilidade de história | preencher com um número seu o que o PO não decidiu |
| 002 | saber dizer "está pronta" | inventar ambiguidade para a análise não ficar vazia |
| 003 | casos a partir de contrato | tratar o silêncio do contrato como status garantido |
| 004 | relato de defeito | apresentar hipótese de causa como fato |
| 005 | risco além do teste | testar um vazamento em vez de apontá-lo |
| 006 | estratégia proporcional | propor o framework da moda para um time manual |

**Ligações entre casos:** QA-001 × QA-004 (a regra sem limite é a causa provável do erro);
QA-005 × governança 002 e 004 (finalidade, necessidade e acesso — o mesmo raciocínio pelo lado de
quem testa); QA-002 e governança 007 (os dois controles).
