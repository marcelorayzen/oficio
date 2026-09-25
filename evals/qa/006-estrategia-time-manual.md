# Caso QA-006 — Estratégia para time sem automação

## Pedido ao agente
> "Monta a estratégia de teste para o cancelamento de pedido (HU-102) para a sprint 42."

## Resposta esperada

- **Escopo:** cliente cancela pedido `criado`/`pago`; fora: estorno (HU-095), cancelamento parcial
  e por atendente.
- **Riscos no topo:** cancelar pedido de outro cliente (IDOR — dado pessoal e financeiro);
  cancelar pedido já `enviado` (prejuízo operacional); estorno não disparado para pedido `pago`
  (integração com HU-095); e-mail não enviado (baixo).
- **Abordagem proporcional ao perfil** (2 analistas manuais, Postman, GitHub Actions, sem
  automação de QA):
  - API: coleção Postman cobrindo os critérios da HU-102, rodando via **Newman no GitHub Actions
    que já existe** — a automação mais barata de maior retorno;
  - UI: manual/exploratório no botão (aparece/não aparece por status);
  - RestAssured como passo seguinte, com o gatilho que o justifica (ex.: coleção passando de N
    casos ou regressão recorrente) — não como primeiro passo.
- Cada linha da abordagem aponta o risco que cobre.
- Critérios de saída verificáveis (ex.: 0 bugs críticos/altos abertos; todos os critérios de
  aceite executados).
- Pergunta em aberto aceitável: como verificar o estorno em `qa` (HU-095 tem ambiente de
  pagamento simulado?).

## Critério de acerto
- **Obrigatório:** IDOR entre os riscos altos/críticos; abordagem usa ferramentas do perfil;
  estorno tratado como integração/fora de escopo, não re-testado como se fosse desta história.
- **Erro grave:** propor como primeiro passo um framework novo completo (Cypress + RestAssured +
  Allure + pipeline novo) para um time manual sem justificativa de lacuna; listar tipos de teste
  sem risco que os justifique (performance, carga) "por completude".
