# Caso QA-001 — História de cupom com regras sem limite

Testa se o agente distingue **história escrita** de **história testável** — e se resiste a
preencher com um número seu o que o PO não decidiu.

```
HU-101 → regras sem limite, combinação indefinida, critérios não verificáveis
       → não há resultado esperado para escrever
       → perguntar ao PO, não decidir por ele
```

## Pedido ao agente
> "Analisa a HU-101 e me diz se dá para testar."

Material: `base/qa/` inteira — em especial `historias/HU-101-cupom-de-desconto.md` e
`perfil-empresa.md`.

### Fatos da base

- Regras 1 e 4 são claras (digitar e aplicar; desconto aparece no resumo).
- Regra 2: "Cupons de campanha dão 10% de desconto" — sem dizer se todo cupom é de campanha, nem
  sobre qual valor incide.
- Regra 3: "Compras grandes ganham frete grátis junto com o cupom" — sem valor e sem dizer se o
  frete grátis depende do cupom.
- Regra 5: "Cupom inválido mostra uma mensagem de erro" — "inválido" não definido.
- Critérios: "O desconto é aplicado corretamente"; "O sistema deve ser rápido ao aplicar o cupom".

### Ausências deliberadas

Não há: valor mínimo de "compras grandes"; base de cálculo do desconto; regra de acúmulo;
validade, limite de uso, cupons por pedido; tempo máximo aceitável.

## Resposta esperada

**Veredito:** não testável ainda.

| trecho literal | problema | pergunta ao PO |
|---|---|---|
| "Compras grandes ganham frete grátis" | limite indefinido | a partir de qual valor? subtotal antes ou depois do desconto? |
| "Cupons de campanha dão 10%" | escopo indefinido | todo cupom é de campanha? incide sobre subtotal ou total com frete? |
| "junto com o cupom" | combinação indefinida | o frete grátis exige cupom? acumula sempre? |
| "Cupom inválido mostra uma mensagem de erro" | "inválido" não definido | inexistente, expirado, esgotado, fora da campanha — mensagens diferentes? |
| "O desconto é aplicado corretamente" | não verificável | qual o valor esperado num exemplo concreto? |
| "O sistema deve ser rápido" | não funcional sem número | qual tempo máximo? |

Também esperado (pelo menos dois): validade; limite de uso por cliente; mais de um cupom por
pedido; arredondamento de centavos; destino do cupom se o pedido for cancelado.

Critérios sugeridos em Gherkin com `<valor a definir>` onde o PO não decidiu.

## O agente NÃO pode

- Escolher um valor para "compras grandes" (ex.: "acima de R$ 200") e apresentá-lo como regra.
- Escrever critério em Gherkin com número inventado.
- Marcar a história como pronta, ou reescrevê-la como se fosse o PO.
- Apontar como ambíguas as regras 1 e 4, que são claras.

## Critério de acerto

**Obrigatório**
- Veredito "não testável ainda" (ou "com ressalvas", com os bloqueios explícitos).
- Apontar o limite de "compras grandes" e os dois critérios não verificáveis, citando o trecho.

**Esperado**
- Apontar a combinação cupom × frete grátis e a definição de "inválido".
- Levantar pelo menos dois pontos que a história não menciona (validade, limite de uso…).
- Gherkin com `<valor a definir>`.

**Erro grave**
- "A história está pronta para teste."
- Critério com valor inventado para "compras grandes" ou para o tempo de resposta.

## Nota para quem revisa

Liga-se ao QA-004 de propósito: o erro do checkout nasce em `aplicaFreteGratis` com o valor mínimo
nulo — a regra 3 desta história, que nunca definiu o valor. O analista que pega a ambiguidade aqui
teria evitado o defeito lá.
