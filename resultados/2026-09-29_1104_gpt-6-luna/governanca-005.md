# governanca/005 — resposta do agente

- caso: `evals/governanca/005-linhagem-tabela-depreciada.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T11:09:36-03:00

## Pedido

> A diretoria achou a receita de 2026 estranha no `financeiro.relatorio_receita`. Pode investigar se existe algum problema de governança de dados por trás, e dizer o impacto e o que precisa ser feito?

## Resposta

Query: A diretoria achou a receita de 2026 estranha no 
`financeiro.relatorio_receita`. Pode investigar se existe algum problema de 
governança de dados por trás, e dizer o impacto e o que precisa ser feito?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     governanca:avaliar-ativo  0.2s
  ┊ 📖 read      README.md  0.1s
  ┊ 📚 skill     governanca:classificar-ativo  0.2s
  ┊ 📖 read      financeiro.relatorio_receita.yaml  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 🔎 find      *  0.4s
  ┊ 📖 read      vendas.pedidos_legado.yaml  0.0s
  ┊ 📖 read      vendas.pedidos.yaml  0.0s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ tool_call   0.0s [Local tools require one entry per tool_call; ...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

Há um problema de linhagem que explica a receita de 2026 parecer estranha: financeiro.relatorio_receita declara como única origem vendas.pedidos_legado (ficha do relatório, campo linhagem.origem, linha 13), mas essa origem está depreciada desde 2026-03-01, sem novas cargas desde 2025-01, e será apagada em 2026-12 (ficha do legado, campos status, depreciado_em e nota_depreciacao, linhas 5–7). A política exige que a linhagem represente a fonte efetivamente usada e que consumidores de ativos depreciados tenham plano de migração registrado (política de ciclo de vida, itens 3–4, linhas 7–8).

As amostras reforçam a incompatibilidade temporal: vendas.pedidos_legado tem 80 registros e datas de 2023-01-04 a 2024-08-03 (resumo da coluna data, linhas 12 e 51); a origem substituta vendas.pedidos tem 150 registros e datas de 2025-01-03 a 2026-08-24 (resumo da coluna data, linhas 9 e 140). O relatório apresenta receita mensal à diretoria e foi atualizado em 2026-08-31 (ficha do relatório, campos descricao e atualizado_em, linhas 2 e 15), mas a ficha não registra a fonte substituta nem um plano de migração. Assim, o relatório não tem cobertura de origem registrada para 2026.

Qual regra está envolvida

- Política de Ciclo de Vida e Depreciação: ativos depreciado não recebem novos consumidores; consumidores existentes migram para a fonte substituta; a linhagem deve refletir a fonte efetivamente utilizada; e dependências de ativos depreciados precisam de plano de migração registrado (itens 1–4, linhas 5–8).
- Política de Classificação: interno é definido como uso interno sem dado pessoal; confidencial aplica-se a ativo que contém dado pessoal (linhas 10–11). R-07 define confidencial quando há tag contem_pii, senão interno (linhas 16–17).

Qual evidência sustenta

- A ficha do relatório declara classificacao: interno, acesso financeiro e bi, e não inclui tag contem_pii (campos classificacao, acesso e tags, linhas 6–8).
- O relatório tem como origem somente vendas.pedidos_legado (ficha do relatório, linha 13).
- A ficha do legado identifica dados pessoais — nome_cliente e email_cliente —, classificação confidencial e acesso a financeiro e bi (ficha do legado, linhas 11–18).
- A substituta vendas.pedidos também contém nome_cliente e email_cliente e está classificada como confidencial (ficha, linhas 7–15).
- A ficha do legado lista relatorio_receita como consumidor (linha 22); a substituta lista o mesmo relatório entre seus consumidores (ficha de vendas.pedidos, linha 22). Isso indica uma inconsistência entre as linhagens registradas, não comprova qual fonte o relatório efetivamente consulta.
- A classificação interna do relatório é incompatível com a política se o relatório contiver dados pessoais. A ficha lista apenas mes e receita (linhas 9–11), então o conteúdo efetivo dessas colunas não permite confirmar, por si só, se há dado pessoal.

Qual o impacto

- A cobertura observada da origem legada termina em 2024-08-03; a substituta começa em 2025-01-03 e alcança 2026-08-24. As amostras mostram períodos diferentes, mas não permitem calcular valores de receita ausentes ou incorretos no relatório, que não tem amostra.
- A diretoria, consumidora do relatório (ficha, campo linhagem.consumidores, linha 14), pode estar recebendo uma série sem dados atuais ou baseada numa fonte diferente da documentada. A hipótese de que a receita foi calculada só a partir do legado precisa ser confirmada consultando a configuração/consulta efetiva do relatório.
- A fonte legada tem exclusão prevista para 2026-12; sem migração confirmada, há risco de interrupção do relatório nessa exclusão (ficha do legado, linha 7; política de ciclo de vida, item 2, linha 6).
- Quanto à classificação e exposição, não há evidência suficiente para afirmar que o relatório reproduz dados pessoais ou que houve acesso indevido.

O que está faltando

- A consulta ou configuração efetivamente usada pelo relatório e seus dados/resultados de 2026.
- Confirmação de migração para vendas.pedidos, incluindo plano e validação da reconciliação da receita.
- Evidência do conteúdo entregue à diretoria para decidir se a classificação interna se aplica ou se o relatório contém apenas dados agregados.
- Se for necessário apurar acesso efetivo, os logs da plataforma de dados; a política informa que ficam lá e são consultados pela Segurança sob demanda (política de acesso, linhas 9–10).

Qual correção proponho

- Controladoria, com o dono da fonte, deve verificar a consulta real, identificar a origem dos valores de 2026 e reconciliar o relatório com vendas.pedidos; depois, registrar a linhagem efetiva e o plano de migração, conforme a política.
- Revisar a classificação do relatório com base no conteúdo efetivo. Se contiver dados pessoais, propor confidencial e revisar o acesso; se contiver apenas agregados sem dados pessoais, documentar essa evidência para sustentar a classificação vigente. Não alterar classificação ou acesso sem aprovação.
- Antes da exclusão prevista do legado, confirmar que a migração do consumidor foi concluída e validada.

Quem precisa aprovar

- Paulo Viana, dono do ativo, deve aprovar alterações na ficha do relatório; a ficha o nomeia como dono (linha 4) e a política de acesso atribui ao dono a aprovação de acesso (política de acesso, linha 6).
- Clara Nunes, dona da fonte, deve participar da validação da migração; a ficha de vendas.pedidos a identifica como dona (linha 4).
- Se a mudança exigir alterar as regras automáticas da política, o Comitê de Governança de Dados aprova (política de classificação, linha 28). Não há proposta de mudança de regra automática neste diagnóstico.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_140940_0afae3

Session:        20260929_140940_0afae3
Duration:       3m 12s
Messages:       34 (1 user, 32 tool calls)
