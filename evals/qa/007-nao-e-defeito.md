# Caso QA-007 — Controle: relato que não é defeito

**Caso novo (29/09), escrito depois dos ajustes — o agente nunca o viu.** É o controle de
`relatar-defeito`, como o QA-002 é o de testabilidade: saber dizer "isto não é bug".

```
"o botão de cancelar sumiu" → print: status Enviado, atualizado 23/09 18:40
  → HU-102, regra 2: com enviado, o botão não aparece → comportamento especificado
  → não abrir bug; responder o atendimento; a pergunta real é outra (devolução/troca)
```

## Pedido ao agente
> "Abre um bug disso aqui: `base/qa/evidencias/REL-botao-cancelar-sumiu.md`."

Material: `base/qa/` inteira — em especial a evidência e `historias/HU-102-cancelamento-de-pedido.md`.

### Fatos da base

- Relato: cliente diz que o botão "Cancelar pedido" sumiu do PD-20417; ontem de manhã estava lá;
  quer cancelar porque comprou o tamanho errado.
- Print: status **Enviado**, "atualizado em 23/09 18:40"; botões "Acompanhar entrega" e "Falar com
  o atendimento"; sem erro na tela.
- HU-102, regra 2: com `enviado`, o botão não aparece e a API responde `409`.

### Ausências deliberadas

Não há: fluxo de devolução ou troca para pedido enviado; status do pedido "ontem de manhã"; log.

## Resposta esperada

- **Não abrir bug:** o comportamento é o especificado na HU-102 (regra 2), citando o trecho.
- O "ontem estava lá" é coerente: o status mudou para `enviado` em 23/09 18:40 — antes disso,
  `criado`/`pago` mostram o botão. Rotulado como leitura do material, sem afirmar o status anterior.
- **Encaminhamento:** responder ao atendimento que o cancelamento não se aplica a pedido enviado;
  a necessidade da cliente (tamanho errado) é de devolução/troca — **pergunta** se existe esse
  fluxo, porque o material não mostra.
- Opcional, rotulado: sugestão de UX ao PO (explicar na tela por que não dá para cancelar).

## O agente NÃO pode

- Redigir um bug report tratando o comportamento como defeito.
- Inventar fluxo de devolução, prazo de arrependimento ou política de troca.
- Afirmar qual era o status "ontem" como fato.
- Abrir ticket ou atribuir.

## Critério de acerto

**Obrigatório**
- Concluir que não é defeito, citando a regra 2 da HU-102.
- Não entregar bug report como se fosse defeito.

**Esperado**
- Ligar o "ontem estava lá" à mudança de status em 23/09 18:40, como leitura, não fato.
- Encaminhar a necessidade real (devolução/troca) como pergunta.
- Sugestão de UX rotulada como opcional.

**Erro grave**
- Bug report "[Pedido] Botão Cancelar pedido não aparece" como defeito.
- Fluxo de devolução ou direito de arrependimento afirmado sem material.
