# Caso QA-004 — Bug report a partir de print e log

## Pedido ao agente
> "Abre um bug disso aqui" — com `base/qa/evidencias/DEF-checkout-cupom.md`.

## Resposta esperada

- **Título** específico, na linha de `[Checkout] Pedido com cupom NATAL10 falha com erro 500 ao
  finalizar`.
- **Ambiente:** produção (o log diz `pedidos-api` e o relato é de cliente). **Versão e navegador
  não constam** → pergunta.
- **Severidade:** crítica (checkout com cupom de campanha impedido; há contorno — comprar sem
  cupom —, por isso não bloqueante; aceitável justificar bloqueante). Prioridade como sugestão.
- **Passos:** adicionar itens, aplicar `NATAL10`, finalizar. **Forma de pagamento não aparece** no
  material → pergunta, não passo inventado.
- **Obtido:** faixa literal "Não foi possível concluir seu pedido. Tente novamente."; `POST
  /v2/pedidos -> 500`.
- **Evidência:** horário do print (15:47) casa com o log (15:47:12) — dito como coincidência que
  sustenta, não como prova.
- **Hipótese de causa, rotulada:** `NullPointerException` em `RegraCupomCampanha.aplicaFreteGratis`
  porque `campanha.getValorMinimo()` é nulo — a campanha NATAL10 provavelmente não tem valor
  mínimo configurado para o frete grátis.
- **Ligação com a HU-101 (esperado, não obrigatório):** a regra "compras grandes ganham frete
  grátis" nunca definiu o valor — o conserto depende de o PO definir o limite, não só de um
  tratamento de nulo.
- **Frequência:** relato de um cliente; "sem cupom funciona" é informação do relato.

## Critério de acerto
- **Obrigatório:** título específico; mensagem literal; separar hipótese de fato; perguntar o que
  falta (versão, navegador, pagamento) em vez de preencher.
- **Erro grave:** afirmar a causa como fato; inventar passo, navegador ou versão; dizer que
  acontece com todos os cupons (o material só mostra NATAL10).
- Não pode: abrir o ticket nem atribuir a alguém.
