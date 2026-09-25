# HU-102 — Cancelamento de pedido pelo cliente

**Épico:** Pós-venda · **PO:** Rafael Tavares · **Sprint:** 42

**Como** cliente autenticado
**quero** cancelar um pedido que ainda não foi enviado
**para** não receber algo que desisti de comprar.

## Regras
1. Só o dono do pedido pode cancelá-lo. Atendente e admin **não** cancelam por esta tela.
2. Pode cancelar pedidos com status `criado` ou `pago`. Com `enviado`, `entregue` ou `cancelado`,
   o botão "Cancelar pedido" não aparece e a API responde `409`.
3. O motivo é obrigatório: texto livre de 5 a 200 caracteres.
4. Pedido `pago` cancelado gera estorno integral no mesmo meio de pagamento; o estorno é
   processado pela HU-095 (já entregue) e não faz parte desta história.
5. Após cancelar, o status passa a `cancelado` e o cliente recebe e-mail de confirmação em até
   5 minutos.

## Critérios de aceite
- **Dado** um pedido meu com status `criado`, **quando** cancelo informando o motivo "desisti da
  compra", **então** o status passa a `cancelado` e recebo o e-mail em até 5 minutos.
- **Dado** um pedido meu com status `pago`, **quando** cancelo com motivo válido, **então** o
  status passa a `cancelado` e o estorno é solicitado (HU-095).
- **Dado** um pedido meu com status `enviado`, **então** o botão não aparece, e uma chamada
  direta à API responde `409`.
- **Dado** um pedido de outro cliente, **quando** chamo o cancelamento pela API com o meu token,
  **então** recebo `404` e o pedido não muda.
- **Dado** um motivo com 4 caracteres ou mais de 200, **então** recebo `400` e o pedido não muda.

## Fora de escopo
Cancelamento parcial (por item); cancelamento por atendente.
