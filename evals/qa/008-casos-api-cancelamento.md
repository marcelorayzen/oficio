# Caso QA-008 — Casos de API do cancelamento, com contrato quase completo

**Caso novo (29/09), escrito depois dos ajustes — o agente nunca o viu.** O inverso do QA-003: lá
o contrato calava e o certo era marcar premissa; aqui contrato **e** história dizem quase tudo, e o
certo é **não** marcar premissa no que está escrito.

```
contrato: 200 / 400 / 401 / 404 / 409; motivo 5–200; id ^PD-[0-9]{5}$
HU-102:   estados que cancelam e que dão 409; pedido alheio → 404
  → quase todo esperado é FATO, com fonte
  → [PREMISSA] só no que ninguém diz: id fora do padrão, efeito do estorno, observação do e-mail
```

## Pedido ao agente
> "Gera os casos de teste e a automação para `POST /pedidos/{id}/cancelamento`."

Material: `base/qa/` inteira — em especial `api/pedidos-openapi.yaml`,
`historias/HU-102-cancelamento-de-pedido.md` e `perfil-empresa.md`.

### Fatos da base

- Contrato: `200` (corpo `Pedido`), `400` (motivo ausente ou fora do tamanho), `401`, `404`,
  `409` (estado que não permite); `motivo` obrigatório, 5–200; `id` `^PD-[0-9]{5}$`.
- HU-102: cancela `criado` e `pago`; `enviado`, `entregue`, `cancelado` → `409`; pedido de outro
  cliente → `404` e o pedido não muda; motivo de 4 ou mais de 200 → `400`.
- Perfil: Postman manual, GitHub Actions, Java 21, Gherkin, IDs `PED-NNN`.

### Ausências deliberadas

Não dizem: resposta para `id` fora do padrão; como observar o estorno solicitado; como observar o
e-mail em `qa`.

## Resposta esperada

| caso | esperado | fonte |
|---|---|---|
| cancelar `criado` / `pago` com motivo válido | `200`, `status = cancelado` no corpo | contrato + HU regra 2 e 5 |
| cancelar `enviado` / `entregue` / `cancelado` | `409`, pedido não muda | contrato + HU regra 2 |
| motivo com 5 e com 200 | `200` | contrato (minLength/maxLength) |
| motivo com 4, com 201, ausente | `400`, pedido não muda | contrato + HU |
| sem token / token inválido | `401` | contrato |
| `id` no formato, inexistente | `404` | contrato |
| pedido de outro cliente (IDOR) | `404`, pedido não muda | **HU-102, critério 4** — fato, não premissa |
| `id` fora do padrão | `[PREMISSA]` `400` ou `404` + pergunta | nenhum |
| cancelar duas vezes | segunda → `409` (já `cancelado`) | dedutível da regra 2 |
| `pago` cancelado | estorno solicitado — como observar é pergunta; processar é HU-095 | HU regra 4 |

**Código:** Postman + Newman no GitHub Actions para hoje, RestAssured + JUnit 5 como próximo passo;
token e base URL de variável de ambiente; asserção de status **e** corpo (`status`); massa sintética
por estado.

## O agente NÃO pode

- Marcar como `[PREMISSA]` o `409`, o `400`, o `404` do IDOR ou os limites 5–200 — estão escritos.
- Afirmar `403` para o IDOR.
- Testar o processamento do estorno como se fosse desta API.
- Token ou base URL literais no código; teste que só olha status.

## Critério de acerto

**Obrigatório**
- IDOR com `404`, citando a HU-102 como fonte.
- `409` para os três estados que não cancelam.
- Limites do motivo dos dois lados (4/5 e 200/201) e ausente.
- Token fora do código.

**Esperado**
- `[PREMISSA]` só onde nada responde (id fora do padrão; observação de estorno e e-mail).
- Cancelar duas vezes → `409`.
- Postman + Newman no CI existente; RestAssured como passo seguinte.
- Asserção de corpo, Gherkin, IDs `PED-NNN`.

**Erro grave**
- "IDOR retorna 403."
- Status documentado tratado como premissa em bloco ("confirmar com o PO" para `409`/`400`).
- Suíte que só afirma status.
