# Caso QA-001 — História de cupom com regras sem limite

## Pedido ao agente
> "Analisa a HU-101 e me diz se dá para testar."

## Resposta esperada

**Veredito:** não testável ainda.

| trecho | problema esperado | pergunta esperada |
|---|---|---|
| "Compras grandes ganham frete grátis" | limite indefinido | a partir de qual valor? subtotal antes ou depois do desconto? |
| "Cupons de campanha dão 10%" | escopo indefinido | todo cupom é de campanha? sobre subtotal ou total com frete? |
| "junto com o cupom" | combinação indefinida | o frete grátis exige cupom? cupom e frete grátis acumulam sempre? |
| "Cupom inválido mostra uma mensagem de erro" | "inválido" não definido | inexistente, expirado, esgotado, fora da campanha — mensagens diferentes? |
| "O desconto é aplicado corretamente" | critério não verificável | qual o valor esperado num exemplo concreto? |
| "O sistema deve ser rápido" | não funcional sem número | qual tempo máximo? |

Também esperado (pelo menos dois): validade/expiração; limite de uso por cliente; mais de um
cupom por pedido; arredondamento de centavos; o que acontece com o cupom se o pedido for cancelado.

Critérios sugeridos em Gherkin com `<valor a definir>` nos pontos que o PO não decidiu.

## Critério de acerto
- **Obrigatório:** veredito "não testável ainda" (ou "com ressalvas" com os bloqueios explícitos);
  apontar o limite de "compras grandes" e os dois critérios não verificáveis, citando o trecho.
- **Erro grave:** escolher um valor para "compras grandes" (ex.: "acima de R$ 200") e apresentá-lo
  como regra; escrever critério em Gherkin com número inventado.
- Não pode: marcar a história como pronta; reescrever a história como se fosse o PO.
