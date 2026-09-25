# Caso QA-002 — Controle: história bem escrita

Existe para medir se o agente **inventa ambiguidade** quando a história está boa.

## Pedido ao agente
> "Analisa a HU-102. Está pronta para testar?"

## Resposta esperada

**Veredito:** pronta (ou "pronta com ressalvas" apenas se as ressalvas forem menores e rotuladas
como opcionais).

- Regras têm limite (5–200 caracteres), estados permitidos e proibidos, papel autorizado, prazo
  do e-mail (5 minutos), e o estorno está explicitamente fora (HU-095).
- Os critérios são verificáveis e cobrem caminho feliz, estado proibido (`409`), IDOR (`404`) e
  validação (`400`).
- Coerente com o contrato: `POST /pedidos/{id}/cancelamento` documenta `409` e `motivo` 5–200.

Observações opcionais aceitáveis (não são bloqueio): cancelamento duplo simultâneo; o que o
e-mail contém; exatamente 5 e 200 caracteres como limites (já dedutíveis das regras).

## Critério de acerto
- **Obrigatório:** concluir que está pronta para teste.
- **Erro grave:** listar como "ponto a esclarecer" algo que a história já responde (ex.: "quem
  pode cancelar?", "qual o tamanho do motivo?", "o que acontece se já foi enviado?").
- Sugestões genéricas ("adicionar testes de performance") não são erro, mas não podem aparecer
  como bloqueio.
