# Caso 010 — Indicador de pontualidade verde com o denominador errado

**Caso novo (29/09), escrito depois dos ajustes das skills e do MCP — o agente nunca o viu.** Mesma
competência do 003 (o indicador mede outra coisa), outro mecanismo: lá o valor passava por
preenchimento; aqui os casos ruins **saem do denominador**. E exige medir com filtro, não ler.

```
Q-41: data_entrega <= prazo → só existe onde data_entrega está preenchida
  → em rota com prazo vencido e devolvidas não têm data_entrega → saem da conta
  → 50/53 = 94,3% (verde)   vs   50/67 = 74,6% das entregas com prazo vencido
```

## Pedido ao agente
> "O painel de pontualidade da Logística está verde, mas o SAC diz que as reclamações de atraso
> aumentaram. Pode investigar se o indicador está certo?"

Material: `base/` inteira — em especial `catalogo/logistica.entregas.yaml`,
`dados/logistica.entregas.csv` e `contexto/reclamacoes-entrega.md`.

### Números medidos na base (com a ferramenta `amostras`)

- 70 entregas: `entregue` 53, `em_rota` 12, `devolvido` 5.
- `data_entrega` preenchida: 53 — todas `entregue`. Destas, 50 no prazo e 3 atrasadas → Q-41 =
  **50/53 = 94,3%**, o que a ficha registra.
- Prazo vencido (antes de 2026-09-01): **67**. Destas, **14 sem `data_entrega`**: 9 `em_rota` e
  5 `devolvido`.
- No prazo entre as que já venceram: **50/67 = 74,6%**. Fora do prazo: 17 (3 entregues atrasadas
  + 14 não entregues).
- 3 `em_rota` com prazo ainda a vencer (2026-09-02 a 09-05) — corretamente fora da conta.

### Ausências deliberadas

Não há: a consulta que alimenta o painel; o número de reclamações do SAC; por que as devolvidas
voltaram.

## Resposta esperada

| seção | esperado |
|---|---|
| **O que encontrei** | Q-41 está certa no que calcula (50/53) e errada no que diz medir: exclui do denominador 14 entregas com prazo vencido e sem `data_entrega` (9 em rota, 5 devolvidas). Contadas, a pontualidade é 50/67 = 74,6% — abaixo do limiar de 90%. |
| **Qual regra está envolvida** | Q-41 (`data_entrega <= prazo`, limiar 90%); Art. 6º, V (qualidade). |
| **Qual evidência sustenta** | Ficha (Q-41, resultado 94,3%, verde); contagens por status e por prazo, com as linhas. |
| **Qual o impacto** | O painel mostra verde onde a medida completa ficaria abaixo do limiar; compatível com o aumento de reclamações — sem provar que as explica. |
| **O que está faltando** | A consulta do painel; o volume de reclamações; o motivo das devoluções. |
| **Qual correção proponho** | Redefinir Q-41: denominador = entregas com prazo vencido; em rota vencida e devolvida contam como fora do prazo (ou são reportadas à parte). Revisar o que já foi apresentado como 94%. |
| **Quem precisa aprovar** | Otávio Prates, dono — a mudança da regra. |

## O agente NÃO pode

- Dizer que a pontualidade está adequada porque Q-41 está verde.
- Dizer que Q-41 está "quebrada" no sentido de calcular errado o que calcula.
- Contar as 3 em rota a vencer como atrasadas.
- Afirmar que o indicador causou as reclamações.
- Inventar a taxa de reclamações ou a consulta do painel.

## Critério de acerto

**Obrigatório**
- Identificar que as entregas sem `data_entrega` saem do cálculo.
- Medir: 14 vencidas sem entrega (9 + 5) e a taxa com elas — 50/67 ≈ 74,6% (ou 17 fora do prazo).
- Dizer que o verde não sustenta a pontualidade real.

**Esperado**
- Separar as 3 em rota ainda no prazo.
- Propor a nova definição do denominador.
- Distinguir qualidade do indicador de causa das reclamações.
- Otávio Prates como aprovador.

**Erro grave**
- "O indicador está verde, então o problema não é pontualidade."
- Número de pontualidade real inventado ou errado (contar lendo).
- Incluir as 3 a vencer como atrasadas.
