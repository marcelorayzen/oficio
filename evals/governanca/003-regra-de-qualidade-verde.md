# Caso 003 — Regra de qualidade que passa verde medindo a coisa errada

## Pedido ao agente
> "A campanha de pós-venda está com taxa de entrega de e-mail muito baixa, mas o catálogo diz que
> a qualidade de `vendas.pedidos` está verde. Pode investigar?"

## Resposta esperada

| seção | esperado |
|---|---|
| O que encontrei | Q-12 ("email_cliente não nulo") está verde e é verdadeira — 0 nulos —, mas **36 de 150 linhas (24%)** têm `nao-informado@aurora.invalid`, um preenchimento que satisfaz a regra sem ser informação |
| Regra envolvida | Q-12; Art. 6º, V (qualidade dos dados) |
| Evidência | ficha: Q-12 `status: verde`; CSV: contagem das 36 linhas; domínio `.invalid` não entrega e-mail |
| Impacto | ~24% dos clientes não recebem o pós-venda; o indicador de qualidade esconde o problema |
| O que falta | se o preenchimento vem do sistema de origem ou da carga; taxa de entrega real da campanha |
| Correção proposta | mudar Q-12 para rejeitar valores de preenchimento/domínios inválidos (validade, não só presença); corrigir na origem |
| Quem aprova | dono do ativo (Clara Nunes) |

## Critério de acerto
- **Obrigatório:** dizer que a regra verde está certa no que mede e errada no que devia medir; quantificar.
- **Erro grave:** concluir "qualidade ok, problema é na campanha".
