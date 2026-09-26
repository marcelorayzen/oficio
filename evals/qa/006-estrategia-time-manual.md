# Caso QA-006 — Estratégia para time sem automação

Testa se a estratégia **sai dos riscos e cabe no time** — e não de um catálogo de tipos de teste
com o framework da moda por cima.

```
HU-102 → riscos (IDOR, estado proibido, estorno, e-mail)
       → cada linha da abordagem aponta o risco que cobre
       → automação mais barata de maior retorno: Postman + Newman no CI que já existe
       → framework completo só com gatilho
```

## Pedido ao agente
> "Monta a estratégia de teste para o cancelamento de pedido (HU-102) para a sprint 42."

Material: `base/qa/` inteira — em especial a HU-102, o contrato e `perfil-empresa.md`.

### Fatos da base

- Perfil: 2 analistas manuais; Postman com coleções soltas; GitHub Actions já existe; nenhuma
  automação de QA; Gherkin; Jira + Xray; ambientes `dev`, `qa`, `homolog`.
- HU-102: fora de escopo — estorno (HU-095, já entregue), cancelamento parcial e por atendente.
- Contrato do cancelamento: `200`, `400`, `401`, `404`, `409`.

### Ausências deliberadas

Não há: como verificar o estorno em `qa` (há pagamento simulado?); como observar o e-mail em `qa`.

## Resposta esperada

- **Escopo:** cliente cancela pedido `criado`/`pago`; fora: estorno, parcial, atendente.
- **Riscos no topo:** cancelar pedido de outro cliente (IDOR — dado pessoal e financeiro);
  cancelar pedido já `enviado`; estorno não disparado para pedido `pago` (integração com HU-095);
  e-mail não enviado (baixo).
- **Abordagem proporcional ao perfil:**
  - API: coleção Postman com os critérios da HU-102, rodando via **Newman no GitHub Actions**;
  - UI: manual/exploratório no botão (aparece ou não por status);
  - RestAssured como passo seguinte, com gatilho explícito (coleção crescendo, regressão
    recorrente).
- Cada linha da abordagem aponta o risco que cobre.
- Critérios de saída verificáveis (0 bugs críticos/altos abertos; critérios de aceite executados).
- Perguntas em aberto: estorno e e-mail em `qa`.

## O agente NÃO pode

- Propor como primeiro passo um framework completo novo (Cypress + RestAssured + Allure + pipeline
  novo) sem lacuna que o justifique.
- Listar tipos de teste sem risco que os justifique (performance, carga) "por completude".
- Re-testar o estorno como se fosse desta história.

## Critério de acerto

**Obrigatório**
- IDOR entre os riscos altos ou críticos.
- Abordagem com as ferramentas do perfil.
- Estorno tratado como integração ou fora de escopo.

**Esperado**
- Newman no CI existente como primeira automação.
- Gatilho explícito para o framework completo.
- Riscos ligados à abordagem, linha a linha.

**Erro grave**
- Framework novo completo como primeiro passo para um time manual, sem justificativa.
- Estratégia que é lista de tipos de teste sem riscos.
