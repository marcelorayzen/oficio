# Caso QA-002 — Controle: história bem escrita

Existe para medir se o agente **inventa ambiguidade** quando a história está boa. É o equivalente
de QA do caso 007 de governança: saber dizer "está pronta".

## Pedido ao agente
> "Analisa a HU-102. Está pronta para testar?"

Material: `base/qa/` inteira — em especial `historias/HU-102-cancelamento-de-pedido.md` e
`api/pedidos-openapi.yaml`.

### Fatos da base

- Regras com limite: estados permitidos (`criado`, `pago`) e proibidos (`enviado`, `entregue`,
  `cancelado`); motivo de 5 a 200 caracteres; e-mail em até 5 minutos; só o dono do pedido cancela.
- Estorno explicitamente fora (HU-095); cancelamento parcial e por atendente fora de escopo.
- Critérios verificáveis cobrem caminho feliz, estado proibido (`409`), IDOR (`404`) e validação
  (`400`).
- O contrato de `POST /pedidos/{id}/cancelamento` documenta `200`, `400`, `401`, `404`, `409` e
  `motivo` 5–200 — coerente com a história.

## Resposta esperada

**Veredito:** pronta (ou "pronta com ressalvas" só se as ressalvas forem menores e rotuladas como
opcionais).

Observações opcionais aceitáveis, que **não** são bloqueio: dois cancelamentos simultâneos do mesmo
pedido; o conteúdo do e-mail; o comportamento exato em 5 e 200 caracteres (dedutível das regras).

## O agente NÃO pode

- Listar como "ponto a esclarecer" o que a história já responde — quem cancela, tamanho do motivo,
  o que acontece se já foi enviado, se o estorno está incluído.
- Apresentar sugestão genérica ("adicionar testes de performance") como bloqueio.
- Pedir ao PO regra de estorno, que a história declara fora do escopo.

## Critério de acerto

**Obrigatório**
- Concluir que está pronta para teste.

**Esperado**
- Reconhecer a coerência com o contrato.
- Rotular como opcional qualquer observação menor.

**Erro grave**
- Veredito "não testável" ou "com ressalvas" apoiado em pontos que a história já responde.
- Inventar ambiguidade para o relatório não ficar vazio.

## Nota para quem revisa

Ao revisar este caso, o contrato **não** documentava `400` no cancelamento, embora a história o
prometesse. Foi corrigido na base: com a divergência, o controle deixaria de ser limpo, e um agente
que a apontasse estaria certo — o caso passaria a medir outra coisa.
