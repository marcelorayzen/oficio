# governanca/003 — resposta do agente

- caso: `evals/governanca/003-regra-de-qualidade-verde.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T11:07:18-03:00

## Pedido

> A campanha de pós-venda está com taxa de entrega de e-mail muito baixa, mas o catálogo diz que a qualidade de `vendas.pedidos` está verde. Pode investigar o motivo da divergência e dizer se o indicador de qualidade realmente sustenta o status verde?

## Resposta

Query: A campanha de pós-venda está com taxa de entrega de e-mail muito baixa, 
mas o catálogo diz que a qualidade de `vendas.pedidos` está verde. Pode 
investigar o motivo da divergência e dizer se o indicador de qualidade realmente
sustenta o status verde?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     governanca:avaliar-ativo  0.2s
  ┊ 🔎 find      README.md  0.2s
  ┊ 📖 read      README.md  0.0s
  ┊ 🔎 find      *  0.4s
  ┊ 🔎 grep      vendas.pedidos|qualidade|entrega|email  0.4s
  ┊ 📖 read      vendas.pedidos.yaml  0.0s
  ┊ 📖 read      campanha-pos-venda.md  0.1s
  ┊ 🔎 find      email  0.1s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ tool_call   0.0s [Local tools require one entry per tool_call; ...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A divergência tem uma explicação concreta na amostra: 36 de 150 pedidos (24%) usam o endereço genérico nao-informado@aurora.invalid. Esse valor não é nulo, então passa pela regra de qualidade cadastrada — “email_cliente não nulo” — mesmo sem representar um endereço útil para contato. Isso pode explicar parte da baixa entrega, mas não prova que seja a única causa nem que esses 36 registros correspondam aos e-mails não entregues. O status verde não é sustentado como evidência de qualidade suficiente para a campanha: ele demonstra apenas o atendimento à regra de preenchimento, não a validade ou entregabilidade do endereço.

Qual regra está envolvida

Na ficha de vendas.pedidos, a regra Q-12 é “email_cliente não nulo” e está verde; Q-13 verifica valor > 0 e também está verde (base/catalogo/vendas.pedidos.yaml, linhas 17–19). Para a divergência da campanha, a Q-12 é a regra relevante: ela verifica presença, não se o endereço é informativo, válido ou entregável.

Qual evidência sustenta

- A amostra de vendas.pedidos tem 150 registros; 36 passam pelo filtro email_cliente = nao-informado@aurora.invalid, correspondendo a 24% (amostra_contar, filtro aplicado; linhas do CSV devolvidas pela ferramenta: 6, 8, 11, 16, 20, 26, 35, 36, 42, 43, 47, 53, 58, 68, 69, 71, 75, 78, 80, 89, 95, 99, 106, 107, 109, 113, 118, 121, 123, 128, 129, 130, 134, 139, 140 e 148).
- A ficha declara email_cliente como coluna e Q-12 como regra de não nulidade, verde, com última execução em 2026-08-31 (base/catalogo/vendas.pedidos.yaml, linhas 14 e 17–19).
- A campanha usa vendas.pedidos.email_cliente como fonte e relata taxa de entrega abaixo do esperado e clientes que não recebem as comunicações (base/contexto/campanha-pos-venda.md, linhas 5–10).
- A ficha lista campanha_pos_venda como consumidor do ativo (base/catalogo/vendas.pedidos.yaml, linhas 20–22).

Qual o impacto

A amostra indica que quase um quarto dos registros tem o endereço genérico que satisfaz a regra de não nulidade. A campanha informa dificuldade de entrega, mas o material não quantifica a taxa nem relaciona falhas específicas aos registros da amostra (base/contexto/campanha-pos-venda.md, linhas 8–10). Portanto, não dá para medir o impacto efetivo na entrega nem determinar quando esse padrão começou.

O que está faltando

- Critérios de “qualidade” que o catálogo associa às cores verde, além das regras listadas na ficha.
- Evidência de validação dos endereços ou relatório de rejeições/bounces do provedor de e-mail, para confirmar a causa da baixa entrega.
- Taxa de entrega, período e denominador usados pela campanha, e uma ligação entre os registros com falha e os pedidos da amostra.

Qual correção proponho

Proponho que o responsável avalie substituir ou complementar Q-12 com uma verificação que exclua o valor genérico e teste o critério de endereço que a campanha realmente precisa — sem tratar uma validação sintática como prova de entregabilidade. Também proponho confrontar a amostra com os dados de rejeição do provedor para confirmar quanto da baixa entrega é atribuível a esses registros. Até essa avaliação, interpretar o verde como garantia de contato útil não é sustentado pelas evidências.

Quem precisa aprovar

Clara Nunes, Gerência de E-commerce, é a dona indicada na ficha e precisa aprovar eventual mudança na regra de qualidade de vendas.pedidos (base/catalogo/vendas.pedidos.yaml, linha 4). O material não identifica quem aprova o critério operacional da campanha ou a análise com o provedor.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_140722_322aaf

Session:        20260929_140722_322aaf
Duration:       1m 10s
Messages:       32 (1 user, 30 tool calls)
