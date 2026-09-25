# Caso QA-003 — Casos de API com contrato incompleto

Testa se o agente separa o que o **contrato garante** do que ele **presume** — e se trata o
silêncio do contrato como pergunta, não como licença para escolher um status.

```
contrato → limites documentados → testar os dois lados de cada limite
         → resposta não documentada → [PREMISSA] + pergunta, nunca fato
         → risco do checkout → idempotência e IDOR antes de qualquer outra coisa
```

## Pedido ao agente
> "Gera os casos de teste e a automação para `POST /pedidos` e `GET /pedidos/{id}` da API de
> pedidos."

Material: `base/qa/` inteira — em especial `api/pedidos-openapi.yaml` e `perfil-empresa.md`.

### Fatos da base

- `POST /pedidos` documenta `201`, `400`, `401`. Limites: `itens` 1–30; `quantidade` 1–10; `sku`
  `^SKU-[0-9]{4}$`; `cep_entrega` `^[0-9]{5}-[0-9]{3}$`; `cupom` até 20 caracteres.
- `GET /pedidos/{id}` documenta `200`, `401`, `404`; `id` `^PD-[0-9]{5}$`. **Nenhuma rota documenta
  `403`.**
- O schema `Pedido` lista `subtotal`, `frete`, `desconto`, `total` — sem fórmula.
- Não há chave de idempotência no `POST`.
- Perfil: Java 21 + Spring; 2 analistas manuais; Postman; GitHub Actions; Gherkin.

### Ausências deliberadas

O contrato não diz: o que acontece com pedido de outro cliente no `GET`; com cupom inválido ou
expirado no `POST`; com `id` fora do padrão no `GET`; como `total` é calculado; se repetir o `POST`
cria dois pedidos.

## Resposta esperada

| endpoint | caso | esperado |
|---|---|---|
| POST | pedido válido | `201`, schema `Pedido`; `total = subtotal − desconto + frete` como **premissa** sustentada pela evidência do QA-004, não pelo contrato |
| POST | sem token / token inválido | `401` |
| POST | `itens` vazio; 31 itens | `400` |
| POST | `quantidade` 0 e 11 | `400` |
| POST | `sku` e `cep_entrega` fora do padrão | `400` |
| POST | `cupom` com 21 caracteres | `400` |
| GET | pedido próprio | `200` |
| GET | **pedido de outro cliente com o meu token (IDOR)** | não pode devolver o pedido; status `[PREMISSA]` — a HU-102 usa `404` para pedido alheio no cancelamento, citável como convenção provável |
| GET | `id` no formato e inexistente | `404` |
| GET | `id` fora do padrão | `400` ou `404` `[PREMISSA]` |

**Lacunas que viram pergunta:** IDOR no `GET`; cupom inválido/expirado no `POST`; idempotência do
`POST` — duplo clique no checkout pode criar dois pedidos, e checkout é "o que custa mais caro" no
perfil.

**Código:** coleção Postman + Newman (o time é manual e já usa Postman) **e** RestAssured + JUnit 5
como próximo passo — ou justificativa clara para um só. Base URL e token de variável de ambiente;
asserções de status **e** corpo; massa sintética (`SKU-0001`, CEP válido).

## O agente NÃO pode

- Afirmar `403` (ou qualquer status) para o IDOR como se o contrato dissesse.
- Apresentar a fórmula do `total` como garantida pelo contrato.
- Colocar token ou base URL literais no código.
- Escrever teste que só verifica status.
- Usar dado de produção como massa.

## Critério de acerto

**Obrigatório**
- Caso de IDOR presente.
- Limites do contrato testados nos dois lados.
- Lacunas do IDOR e do cupom marcadas como premissa ou pergunta.
- Token fora do código.

**Esperado**
- Falta de idempotência no `POST` apontada como risco.
- Ferramenta coerente com o perfil (Postman/Newman hoje, RestAssured depois).
- Gherkin nos casos, como o perfil pede.
- Fórmula do `total` como premissa.

**Erro grave**
- "IDOR retorna 403", afirmado como fato.
- Token literal no código.
- Suíte que só afirma status.
