# Caso QA-003 — Casos de API com contrato incompleto

## Pedido ao agente
> "Gera os casos de teste e a automação para `POST /pedidos` e `GET /pedidos/{id}` da API de
> pedidos."

## Resposta esperada

**Casos que precisam estar presentes:**

| endpoint | caso | esperado |
|---|---|---|
| POST | pedido válido | 201, schema `Pedido`, `total = subtotal − desconto + frete` |
| POST | sem token / token inválido | 401 |
| POST | `itens` vazio; 31 itens | 400 (limites 1–30 do contrato) |
| POST | `quantidade` 0 e 11 | 400 (limites 1–10) |
| POST | `sku` fora do padrão; `cep_entrega` fora do padrão | 400 |
| POST | `cupom` com 21 caracteres | 400 (maxLength 20) |
| GET | pedido próprio | 200 |
| GET | **pedido de outro cliente com meu token (IDOR)** | não pode devolver o pedido; ver abaixo |
| GET | id no formato e inexistente; id fora do padrão | 404; 400 ou 404 `[PREMISSA]` |

**Lacunas do contrato que precisam virar premissa ou pergunta, não fato:**
- **IDOR em `GET /pedidos/{id}`:** o contrato não documenta 403. A HU-102 define `404` para
  pedido de outro cliente no cancelamento — citar como convenção provável, marcada `[PREMISSA]`.
- **Cupom inválido/expirado em `POST /pedidos`:** comportamento não documentado.
- **Idempotência do `POST /pedidos`:** não há chave de idempotência; duplo clique no checkout pode
  criar dois pedidos. É risco crítico (checkout = "o que custa mais caro") e vira pergunta.

**Código:** perfil é Java/Spring com time manual e Postman → coleção Postman/Newman **e**
RestAssured + JUnit 5 como próximo passo, ou justificativa clara para um só. Base URL e token de
variável de ambiente. Asserções de status **e** corpo. Massa sintética (`SKU-0001`, CEP válido).

## Critério de acerto
- **Obrigatório:** IDOR presente; limites do contrato testados nos dois lados; a lacuna do IDOR e
  do cupom marcada como premissa/pergunta; token fora do código.
- **Esperado:** apontar a falta de idempotência no POST como risco.
- **Erro grave:** afirmar `403` (ou qualquer status) para o IDOR como se o contrato dissesse;
  token literal no código; teste que só verifica status.
