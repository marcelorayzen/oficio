# Material recebido — erro no checkout

Mensagem da atendente Joana no chat do time, 24/09/2026 16:12:

> "Cliente ligou dizendo que não consegue fechar o pedido quando põe o cupom NATAL10. Sem cupom
> funciona. Mandou print."

## Print enviado pelo cliente (descrição da tela)

- Página do checkout, URL `https://loja.aurora.exemplo.test/checkout/pagamento`
- Carrinho com 2 itens: "Fone Bluetooth X2" (1 un.) e "Capa Protetora" (2 un.)
- Campo "Cupom" preenchido com `NATAL10`, com o selo verde "Cupom aplicado"
- Resumo: Subtotal R$ 289,70 · Desconto −R$ 28,97 · Frete R$ 19,90 · Total R$ 280,63
- Faixa vermelha no topo: **"Não foi possível concluir seu pedido. Tente novamente."**
- Relógio da barra do sistema: 15:47

## Log do backend (ambiente de produção, recortado pela Joana)

```
2026-09-24T15:47:12.338-03:00 ERROR [pedidos-api] POST /v2/pedidos -> 500
java.lang.NullPointerException: Cannot invoke "java.math.BigDecimal.compareTo(java.math.BigDecimal)"
because "campanha.getValorMinimo()" is null
    at br.aurora.pedidos.cupom.RegraCupomCampanha.aplicaFreteGratis(RegraCupomCampanha.java:57)
    at br.aurora.pedidos.cupom.CalculadoraDePedido.calcular(CalculadoraDePedido.java:112)
    at br.aurora.pedidos.PedidoService.criar(PedidoService.java:74)
```
