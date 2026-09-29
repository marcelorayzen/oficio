# governanca/005 — resposta do agente

- caso: `evals/governanca/005-linhagem-tabela-depreciada.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T10:34:21-03:00

## Pedido

> A diretoria achou a receita de 2026 estranha no `financeiro.relatorio_receita`. Pode investigar se existe algum problema de governança de dados por trás, e dizer o impacto e o que precisa ser feito?

## Resposta

Query: A diretoria achou a receita de 2026 estranha no 
`financeiro.relatorio_receita`. Pode investigar se existe algum problema de 
governança de dados por trás, e dizer o impacto e o que precisa ser feito?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      financeiro.relatorio_receita.yaml  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 📚 skill     mapear-dados-pessoais  0.2s
  ┊ 📚 skill     classificar-ativo  0.2s
  ┊ 📚 skill     base-legal-e-finalidade  0.2s
  ┊ 📚 skill     revisar-acesso  0.2s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Inspecting lineage source status**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 📖 read      vendas.pedidos_legado.yaml  0.1s
  ┊ 📖 read      contexto  0.0s [Cannot read 'base/contexto/': not a regular f...]
  ┊ 🔎 find      receita|legado|2026|depreci  0.1s
  ┊ 🔎 grep      vendas.pedidos_legado|relatorio_receita|depreciado  0.5s
  ┊ 📖 read      vendas.pedidos.yaml  0.0s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_desc   0.0s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Inspecting sample source totals**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ tool_call   0.0s [Local tools require one entry per tool_call; ...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Sourcing 2026 order values**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Searching for context list**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 🔎 find      *.md  0.1s
  ┊ 📖 read      campanha-pos-venda.md  0.0s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

Há um problema de linhagem que pode explicar a receita estranha: financeiro.relatorio_receita declara vendas.pedidos_legado como origem, embora essa fonte esteja depreciada e tenha sido substituída por vendas.pedidos. A amostra do legado não contém nenhum registro de 2026; já a amostra de vendas.pedidos contém 65 registros de 2026 entre 150 (43,3%). Isso sustenta que a origem declarada não cobre os pedidos de 2026 presentes na amostra da fonte substituta. Não é possível afirmar qual dado o relatório efetivamente usou nem quantificar a diferença de receita sem a amostra do relatório ou evidência de execução da linhagem.

Qual regra está envolvida

A Política de Ciclo de Vida determina que a linhagem reflita a fonte efetivamente utilizada (item 3), que consumidores de ativo depreciado tenham plano de migração registrado (item 4) e que a depreciação gere alerta aos consumidores conhecidos (item 5). Também veda novos consumidores de ativos depreciados (item 1) — política, linhas 5–9.

Qual evidência sustenta

- base/catalogo/financeiro.relatorio_receita.yaml, linhas 12–15: a origem declarada é vendas.pedidos_legado; o consumidor é apresentacao_diretoria; a ficha foi atualizada em 2026-08-31.
- base/catalogo/vendas.pedidos_legado.yaml, linhas 5–7 e 20–22: ativo depreciado em 2026-03-01, substituído por vendas.pedidos, sem carga nova desde 2025-01, com exclusão prevista para 2026-12; consumidor listado como relatorio_receita.
- Ferramenta amostra_contar, ativo vendas.pedidos_legado, filtro data >= 2026-01-01 e < 2027-01-01: 0 de 80 registros.
- Ferramenta amostra_contar, ativo vendas.pedidos, mesmo filtro: 65 de 150 registros (43,3%). A ficha de vendas.pedidos lista relatorio_receita como consumidor (base/catalogo/vendas.pedidos.yaml, linhas 20–22).
- base/README.md, linhas 23–25: financeiro.relatorio_receita tem ficha, mas não tem amostra. Portanto, não há como medir diretamente a receita reportada.

Qual o impacto

A apresentação da diretoria pode estar incompleta ou desatualizada para 2026 se o relatório depender apenas do legado. Isso é uma hipótese sobre o resultado, não uma confirmação: a ficha aponta o legado como origem, mas não há evidência de execução ou conteúdo do relatório. Não é possível determinar o valor da diferença nem desde quando a receita apresentada diverge. O legado está programado para exclusão em 2026-12, o que torna necessário esclarecer a dependência antes dessa data (vendas.pedidos_legado.yaml, linha 7).

O que está faltando

- Evidência de execução/consulta do relatório e confirmação da fonte efetivamente usada.
- Plano e registro de migração do consumidor relatorio_receita.
- Valores do relatório de receita de 2026 para comparar com os pedidos de 2026 e apurar o impacto financeiro.

Qual correção proponho

Pedir à Controladoria, dona do relatório, e à Gerência de E-commerce, dona das fontes, que verifiquem a fonte realmente consumida e comparem o resultado de 2026 com a fonte substituta. Se confirmarem que o relatório ainda depende do legado, propor a migração para vendas.pedidos e atualizar a linhagem e o plano de migração. Não alterei dados nem configuração.

Quem precisa aprovar

- Paulo Viana, dono de financeiro.relatorio_receita: aprovar a correção do relatório e da respectiva linhagem.
- Clara Nunes, dona de vendas.pedidos e vendas.pedidos_legado: aprovar a fonte substituta e o plano de migração.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_133425_91c306

Session:        20260929_133425_91c306
Duration:       1m 49s
Messages:       50 (1 user, 48 tool calls)
