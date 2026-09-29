# governanca/003 — resposta do agente

- caso: `evals/governanca/003-regra-de-qualidade-verde.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T08:11:37-03:00

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
  ┊ 📚 skills    list governanca  0.2s
  ┊ 🔎 find      *  0.7s
  ┊ 🔎 grep      vendas\.pedidos|entrega|qualidade|pós-venda|pos-venda  0.7s
  ┊ 📖 read      vendas.pedidos.yaml  0.1s
  ┊ 📖 read      campanha-pos-venda.md  0.1s
  ┊ 📖 read      vendas.pedidos.csv  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 🔎 grep      qualidade|verde|e-mail|email  0.1s
  ┊ 📖 read      qualidade.md  0.1s [File not found: qualidade.md]
  ┊ 🔎 grep      Q-12|Q-13|qualidade  0.2s
  ┊ 🔎 grep      Qual regra|Observação|qualidade  0.2s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Counting sentinel occurrences**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 🔎 grep      nao-informado@aurora\.invalid  0.4s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Calculating 36/150**
└──────────────────────────────────────────────────────────────────────────────┘

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A divergência tem uma explicação observável na amostra: a regra Q-12 considera suficiente que email_cliente não seja nulo, mas há 36 de 150 pedidos (24%) com o endereço marcador nao-informado@aurora.invalid. Esses valores não estão vazios, mas não fornecem um endereço utilizável para contato. Isso é compatível com a baixa entrega relatada pela campanha, embora a amostra, por si só, não prove que esses registros causaram a taxa operacional observada. A campanha usa essa coluna como fonte dos contatos [base/contexto/campanha-pos-venda.md, linhas 5–10; base/dados/vendas.pedidos.csv, linhas 2–151].

Conclusão: o status verde de Q-12 não sustenta que os e-mails sejam válidos ou entregáveis; sustenta apenas que a coluna está preenchida. Q-13 também aparece verde no catálogo, mas mede valor > 0, não a qualidade dos contatos [base/catalogo/vendas.pedidos.yaml, linhas 17–19]. A amostra não permite verificar os resultados atuais dessas regras: a ficha registra última execução em 31/08/2026, enquanto os dados são uma amostra sem data de extração informada [ficha, linha 18; base/dados/vendas.pedidos.csv, linhas 1–151].

Qual regra está envolvida

A ficha do catálogo declara Q-12: “email_cliente não nulo”, status verde, última execução em 31/08/2026; e Q-13: “valor > 0”, também verde, mesma data [base/catalogo/vendas.pedidos.yaml, linhas 17–19]. Não encontrei uma política organizacional de qualidade entre os arquivos consultados que defina o que “verde” deve garantir; portanto, não atribuo ao status um critério além do que está registrado na ficha.

Qual evidência sustenta

- A campanha informa que usa vendas.pedidos.email_cliente para os contatos e relata taxa de entrega abaixo do esperado [base/contexto/campanha-pos-venda.md, linhas 5–10].
- A regra Q-12 testa apenas não nulidade [base/catalogo/vendas.pedidos.yaml, linha 18].
- A amostra contém 150 registros de pedidos, nas linhas 2–151 [base/dados/vendas.pedidos.csv].
- O marcador nao-informado@aurora.invalid aparece em 36 linhas da amostra [base/dados/vendas.pedidos.csv, linhas 6, 8, 11, 16, 20, 26, 35, 36, 42, 43, 47, 53, 58, 68, 69, 71, 75, 78, 80, 89, 95, 99, 106, 107, 109, 113, 118, 121, 123, 128–130, 134, 139–140 e 148]. Isso equivale a 24% da amostra.
- A ficha lista campanha_pos_venda como consumidora do ativo [base/catalogo/vendas.pedidos.yaml, linha 22].

Qual o impacto

Na amostra, 36 pedidos têm um valor preenchido que funciona como marcador de ausência, não como contato de cliente. Como a campanha usa essa coluna, esses registros não oferecem um endereço de cliente utilizável pela campanha. A taxa de entrega real, os envios afetados e o período do impacto não podem ser determinados com os materiais disponíveis: o relato não traz métricas ou logs de envio [base/contexto/campanha-pos-venda.md, linhas 8–10].

O que está faltando

- Definição formal do que o status verde garante; não encontrei essa regra nos materiais consultados.
- Métrica detalhada e logs de envio da campanha, para quantificar a contribuição dos endereços marcadores à taxa de entrega.
- Resultado e abrangência da execução de Q-12 em 31/08/2026, além da relação entre essa execução e a amostra fornecida.

Qual correção proponho

Proponho que o responsável pela qualidade revise Q-12 para distinguir preenchimento de endereço utilizável — por exemplo, rejeitar o marcador nao-informado@aurora.invalid e validar o formato conforme critério aprovado — e reporte separadamente os registros sem contato utilizável. Também proponho comparar essa medida com os logs da campanha antes de atribuir toda a baixa entrega à qualidade dos dados. Não alterei regra, dado nem status.

Quem precisa aprovar

A ficha nomeia Clara Nunes, da Gerência de E-commerce, como dona do ativo [base/catalogo/vendas.pedidos.yaml, linha 4]. O material não nomeia quem aprova mudanças na regra de qualidade nem quem responde pelos critérios de entrega da campanha; esses responsáveis precisam ser identificados pelo time antes da aplicação.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_111140_790f3e

Session:        20260929_111140_790f3e
Duration:       1m 5s
Messages:       22 (1 user, 20 tool calls)
