# governanca/005 — resposta do agente

- caso: `evals/governanca/005-linhagem-tabela-depreciada.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T08:13:28-03:00

## Pedido

> A diretoria achou a receita de 2026 estranha no `financeiro.relatorio_receita`. Pode investigar se existe algum problema de governança de dados por trás, e dizer o impacto e o que precisa ser feito?

## Resposta

Query: A diretoria achou a receita de 2026 estranha no 
`financeiro.relatorio_receita`. Pode investigar se existe algum problema de 
governança de dados por trás, e dizer o impacto e o que precisa ser feito?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skills    list governanca  0.1s
  ┊ 📚 skill     governanca:avaliar-ativo  0.2s
  ┊ 🔎 find      *  0.7s
  ┊ 🔎 grep      receita|relatorio_receita|financeiro  0.6s
  ┊ 📚 skill     governanca:classificar-ativo  0.6s
  ┊ 📚 skill     governanca:base-legal-e-finalidade  0.5s
  ┊ 📚 skill     governanca:revisar-acesso  0.6s
  ┊ 📚 skill     governanca:mapear-dados-pessoais  0.6s
  ┊ 📖 read      financeiro.relatorio_receita.yaml  0.1s
  ┊ 📖 read      vendas.pedidos_legado.yaml  0.1s
  ┊ 📖 read      vendas.pedidos.yaml  0.1s
  ┊ 📖 read      alerta.md  0.1s
  ┊ 📖 read      evidencia-catalogo.md  0.1s
  ┊ 📖 read      ficha-CAT-004821.md  0.1s
  ┊ 📖 read      POL-DADOS-003.md  0.1s
  ┊ 📖 read      regra-CAT-07.md  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 📖 read      README.md  0.1s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

Sim. Há dois problemas de governança que podem explicar por que a receita de 2026 parece estranha:

1. O relatório ainda usa vendas.pedidos_legado como origem, embora esse ativo esteja marcado como depreciado e a ficha diga que não recebe novas cargas desde 2025-01. Isso deixa sem explicação, no catálogo, de onde vêm os valores atribuídos a 2026. Não prova que os números estejam errados, mas torna a linhagem declarada inconsistente com a janela temporal do relatório.
2. O relatório está classificado como interno, mas sua origem contém dados pessoais e está classificada como confidencial. Pela política da Aurora, dados pessoais são confidenciais; a classificação interna não é coerente com a linhagem declarada. O acesso do relatório é listado como financeiro e bi; a política exige grupos com necessidade de conhecer e aprovação do dono para ativos confidenciais. O catálogo, sozinho, não comprova quem acessou os dados.

Não encontrei amostra ou valores do relatório para medir a diferença de receita, validar a soma ou determinar quantos meses de 2026 estão afetados.

Qual regra está envolvida

- Política de Ciclo de Vida, base/politicas/ciclo-de-vida.md, itens 1–5: ativos depreciados não recebem novos consumidores; consumidores devem migrar para a fonte substituta; linhagem deve refletir a fonte efetivamente usada; dependências precisam de plano de migração; a depreciação deve gerar alerta aos consumidores.
- Política de Classificação, base/politicas/classificacao.md, linhas 9–12: interno não contém dado pessoal; confidencial abrange dado pessoal e exige necessidade de conhecer, com aprovação do dono.
- Política de Classificação, linhas 16–21: a regra R-07 usa a tag contem_pii para classificar como confidencial; sem essa tag, classifica como interno. A tag aparece na origem legada, não na ficha do relatório.
- Política de Acesso, base/politicas/acesso.md, itens 2, 5–10: o dono aprova o acesso; o log está na plataforma de dados e deve ser consultado pela Segurança sob demanda.
- Finalidade declarada do relatório: “Acompanhamento de receita” (base/catalogo/financeiro.relatorio_receita.yaml, linha 5). É genérica; a ficha não declara base legal para o relatório. Como a origem contém dados pessoais, não há evidência suficiente para concluir se o tratamento e o uso específico estão documentados de forma adequada.

Qual evidência sustenta

- base/catalogo/financeiro.relatorio_receita.yaml, linhas 1–5 e 9–15: relatório mensal de receita, atualizado em 2026-08-31, dono Controladoria (Paulo Viana), finalidade declarada e colunas mes e receita.
- Mesmo arquivo, linhas 7–8 e 12–14: classificação interno, acesso financeiro e bi, origem vendas.pedidos_legado e consumidor apresentacao_diretoria.
- base/catalogo/vendas.pedidos_legado.yaml, linhas 2–7: descreve pedidos de 2023–2024, marca o ativo como depreciado desde 2026-03-01 e informa que não há carga nova desde 2025-01; substituição por vendas.pedidos.
- Mesmo arquivo, linhas 10–18: tags contem_pii, classificação confidencial e campos pessoais, incluindo nome e e-mail do cliente.
- base/catalogo/vendas.pedidos.yaml, linhas 2–9 e 20–22: fonte substituta cobre pedidos a partir de 2025, está classificada como confidencial e lista relatorio_receita entre seus consumidores. Isso sugere uma relação com a fonte atual, mas não comprova que o relatório realmente a utilize para os valores de 2026.
- base/politicas/classificacao.md, linhas 10–12 e 16–21: critérios dos níveis e comportamento da R-07 quando a tag está ausente.
- base/politicas/ciclo-de-vida.md, itens 1–5: requisitos de migração, linhagem e alerta para dependências de fonte depreciada.
- base/politicas/acesso.md, itens 2 e 5–10: aprovação e localização dos logs.
- A pasta base/dados/ não contém uma amostra CSV de financeiro.relatorio_receita; portanto, não foi possível conferir os valores nem quantificar divergências.

Qual o impacto

- Confiabilidade financeira: os valores de 2026 não têm origem comprovada pela linhagem registrada. Se o relatório estiver usando apenas a fonte legada, a documentação disponível indica que ela não recebe cargas desde 2025-01. Não é possível afirmar, com o material disponível, se a apresentação à diretoria contém valores incorretos ou incompletos.
- Governança e acesso: a classificação registrada como interna pode não refletir a presença de dados pessoais na cadeia de origem. Os grupos financeiro e bi podem acessar segundo a ficha, mas não há evidência de log para confirmar acesso efetivo nem de aprovação desses grupos para este ativo.
- Escopo temporal: não dá para determinar quais meses, se algum, foram afetados, nem desde quando o relatório passou a apresentar valores de 2026.

O que está faltando

- A consulta, transformação ou job que calcula receita, com as fontes efetivamente lidas e seus filtros de data.
- Dados do relatório por mês e totais de origem para reconciliar 2026.
- Evidência de execução/carga para a fonte substituta e confirmação de como os dados de 2025–2026 chegam ao relatório.
- Plano de migração e alertas associados ao consumidor relatorio_receita.
- Registro de aprovação e necessidade de conhecer dos grupos com acesso.
- Log de acesso da plataforma de dados, a ser consultado pela Segurança.
- Finalidade específica e documentação de base legal aplicáveis ao uso de dados pessoais neste relatório.

Qual correção proponho

1. Reconciliar os valores mensais de 2026 com os dados de origem e com a transformação que alimenta o relatório; registrar a diferença encontrada, se houver.
2. Confirmar a fonte efetiva usada pelo processo. Se vendas.pedidos for a fonte real, atualizar a linhagem para refletir isso e documentar a migração. Se não for, investigar como o relatório está produzindo valores de 2026 apesar da ausência de novas cargas declarada para a origem legada.
3. Rever a classificação do relatório à luz da linhagem e dos dados efetivamente presentes. A correção deve ser avaliada pelo dono do dado; não alterei classificação nem acesso.
4. Revisar se financeiro e bi têm necessidade de conhecer e aprovações registradas para o relatório, considerando a classificação validada.
5. Esclarecer a finalidade específica e localizar a documentação de base legal pertinente. A ficha não permite concluir se essa documentação existe em outro lugar.

Quem precisa aprovar

- Paulo Viana, dono do relatório, precisa validar a reconciliação, a finalidade, a linhagem efetiva e a classificação aplicável ao ativo.
- Clara Nunes, dona de vendas.pedidos_legado e vendas.pedidos, precisa confirmar a situação das fontes e a migração.
- Segurança precisa consultar os logs de acesso; a política não nomeia uma pessoa responsável.
- Se a revisão concluir que o relatório deve ser classificado como confidencial, o dono do dado aprova os acessos conforme a Política de Classificação e a Política de Acesso; a política não identifica nominalmente o responsável pelo acesso desse relatório. Não há, nas evidências, indicação de dado sensível que exija aprovação de Marta Siqueira.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_111330_8aa1a9

Session:        20260929_111330_8aa1a9
Duration:       51s
Messages:       25 (1 user, 23 tool calls)
