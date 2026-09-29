# governanca/003 — resposta do agente

- caso: `evals/governanca/003-regra-de-qualidade-verde.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T10:32:08-03:00

## Pedido

> A campanha de pós-venda está com taxa de entrega de e-mail muito baixa, mas o catálogo diz que a qualidade de `vendas.pedidos` está verde. Pode investigar o motivo da divergência e dizer se o indicador de qualidade realmente sustenta o status verde?

## Resposta

Query: A campanha de pós-venda está com taxa de entrega de e-mail muito baixa, 
mas o catálogo diz que a qualidade de `vendas.pedidos` está verde. Pode 
investigar o motivo da divergência e dizer se o indicador de qualidade realmente
sustenta o status verde?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     governanca/avaliar-ativo  0.2s
  ┊ 🔎 find      README.md  0.2s
  ┊ 📖 read      README.md  0.0s
  ┊ 📚 skill     governanca/mapear-dados-pessoais  0.6s
  ┊ 📚 skill     governanca/classificar-ativo  0.6s
  ┊ 📚 skill     governanca/base-legal-e-finalidade  0.6s
  ┊ 📚 skill     governanca/revisar-acesso  0.6s
  ┊ 🔎 find      *  0.5s
  ┊ 📖 read      vendas.pedidos.yaml  0.1s
  ┊ 📖 read      campanha-pos-venda.md  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ tool_call   0.0s [Local tools require one entry per tool_call; ...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ 📖 read      vendas.pedidos.csv L1-6  0.1s
  ┊ ⚡ mcp__amos   0.0s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A divergência é explicada por uma limitação do indicador: a regra Q-12 verifica apenas se email_cliente não está vazio, não se contém um endereço de e-mail utilizável. Na amostra, nenhum dos 150 valores está vazio, mas 36 (24%) são o marcador nao-informado@aurora.invalid. Assim, esses registros passam no critério de preenchimento sem fornecer um contato útil. Isso é compatível com a baixa entrega relatada pela campanha, embora o material não prove que esses 36 registros causaram as falhas de entrega. Portanto, o verde de Q-12 não sustenta, por si só, a conclusão de que os e-mails são entregáveis.

Qual regra está envolvida

A ficha de vendas.pedidos declara Q-12 como “email_cliente não nulo”, com status verde e última execução em 2026-08-31 (catálogo, linha 18). A Q-13 verifica valor > 0, também verde (linha 19), mas não mede a qualidade dos contatos usados pela campanha.

Qual evidência sustenta

- A campanha usa vendas.pedidos.email_cliente como fonte e relata taxa de entrega abaixo do esperado e clientes sem receber comunicações (contexto, linhas 5–10).
- A ficha lista campanha_pos_venda como consumidora de vendas.pedidos (catálogo, linha 22).
- A amostra contém 150 registros; a contagem de valores vazios em email_cliente foi 0/150 (ferramentas de amostra; arquivo base/dados/vendas.pedidos.csv).
- A contagem do valor nao-informado@aurora.invalid foi 36/150 (24%). Exemplos mascarados desse marcador aparecem, por exemplo, na linha 6 do CSV; os demais números de linha foram devolvidos pela ferramenta de amostra.
- Um teste de formato sintático simples reconheceu 150/150 valores como e-mail. Isso não demonstra que os endereços existam ou recebam mensagens: o próprio marcador reservado passa nesse teste.

Qual o impacto

A evidência mostra 36 registros da amostra sem um contato individual utilizável, apesar de passarem na regra de não nulo. A amostra não informa quantas tentativas de envio falharam, nem se esses registros foram incluídos na campanha de setembro. Não é possível determinar o impacto real sobre entregas ou clientes com o material disponível.

O que está faltando

- A definição do que significa “entregável” para a campanha e os resultados detalhados de envio, associados aos registros sem reproduzir e-mails pessoais.
- Confirmação de que os dados usados no disparo de setembro correspondem à mesma população e versão da amostra analisada.

Qual correção proponho

Proponho revisar Q-12 para que não se limite a “não nulo”: medir e sinalizar separadamente os marcadores de ausência conhecidos, além de validar formato e, se aplicável ao processo, acompanhar confirmação de entrega por meio dos resultados da campanha. O verde atual não deve ser interpretado como garantia de entregabilidade.

Quem precisa aprovar

Clara Nunes, Gerência de E-commerce, como dona do ativo, para a proposta de alteração da regra de qualidade (catálogo, linha 4). A ficha não nomeia aprovador específico para essa regra.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_133212_33e1a0

Session:        20260929_133212_33e1a0
Duration:       1m 10s
Messages:       40 (1 user, 38 tool calls)
