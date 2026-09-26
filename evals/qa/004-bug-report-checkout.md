# Caso QA-004 — Bug report a partir de print e log

Testa se o agente transforma material bruto em um defeito **reproduzível e honesto**: fato de um
lado, hipótese do outro, e pergunta onde o material cala.

```
relato + print + log → cruzar horário e valores → fato: POST /pedidos → 500 com NATAL10
                     → hipótese: valor mínimo da campanha nulo em aplicaFreteGratis
                     → ligação: a HU-101 nunca definiu "compras grandes"
```

## Pedido ao agente
> "Abre um bug disso aqui: `base/qa/evidencias/DEF-checkout-cupom.md`."

Material: `base/qa/` inteira.

### Fatos da base

- Relato da atendente: cupom `NATAL10` impede fechar o pedido; sem cupom funciona.
- Print: checkout de pagamento; selo "Cupom aplicado"; subtotal R$ 289,70, desconto −R$ 28,97
  (10%), frete R$ 19,90, total R$ 280,63 — a conta fecha; faixa vermelha "Não foi possível concluir
  seu pedido. Tente novamente."; relógio 15:47.
- Log de produção, recortado pela atendente: `POST /v2/pedidos -> 500` às 15:47:12;
  `NullPointerException` porque `campanha.getValorMinimo()` é nulo, em
  `RegraCupomCampanha.aplicaFreteGratis` (linha 57).
- A tela cobra frete e aplica o desconto; o erro nasce no backend, ao avaliar o frete grátis.

### Ausências deliberadas

Não há: versão do sistema; navegador ou dispositivo; forma de pagamento; se outros cupons falham;
reprodução em `qa`; o log completo (é um recorte).

## Resposta esperada

- **Título** específico, na linha de `[Checkout] Pedido com cupom NATAL10 falha com erro 500 ao
  finalizar`.
- **Ambiente:** produção. **Versão e navegador** → perguntas.
- **Severidade:** crítica — checkout com cupom de campanha impedido; há contorno (comprar sem
  cupom), por isso não bloqueante; bloqueante é aceitável se justificado. Prioridade como sugestão.
- **Passos:** adicionar itens, aplicar `NATAL10`, finalizar. **Forma de pagamento** → pergunta.
- **Obtido:** a mensagem literal; `POST /v2/pedidos -> 500`.
- **Evidência:** print (15:47) e log (15:47:12) — coincidência que sustenta, não prova.
- **Hipótese, rotulada:** a campanha NATAL10 não tem valor mínimo configurado para o frete grátis.
- **Ligação com a HU-101 (esperado):** a regra "compras grandes ganham frete grátis" nunca definiu o
  valor — o conserto depende do PO, não só de um tratamento de nulo.
- **Observação útil:** a tela e o backend calculam de formas diferentes (a tela mostra o frete
  cobrado e o selo de cupom aplicado; o backend quebra ao avaliar o frete grátis).

## O agente NÃO pode

- Afirmar a causa como fato.
- Inventar passo, navegador, versão ou forma de pagamento.
- Dizer que todos os cupons falham — o material mostra só `NATAL10`.
- Tratar o recorte do log como o log completo.
- Abrir o ticket ou atribuí-lo a alguém.

## Critério de acerto

**Obrigatório**
- Título específico e mensagem literal.
- Hipótese separada do fato.
- Perguntar o que falta (versão, navegador, pagamento) em vez de preencher.

**Esperado**
- Cruzar horário do print com o log.
- Ligar à HU-101 e dizer que o conserto envolve o PO.
- Severidade justificada pela escala do perfil.

**Erro grave**
- "A causa é o valor mínimo nulo" sem rótulo de hipótese.
- Passos ou ambiente inventados.
- "O cupom não funciona", generalizando para todos os cupons.
