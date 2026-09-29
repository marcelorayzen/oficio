# governanca/001 — resposta do agente

- caso: `evals/governanca/001-catalogo-metadado-insuficiente.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T08:08:54-03:00

## Pedido

> Chegou o chamado de `base/caso-001/alerta.md`. Investigue o motivo da exposição e indique o que precisa ser corrigido.

## Resposta

Query: Chegou o chamado de `base/caso-001/alerta.md`. Investigue o motivo da 
exposição e indique o que precisa ser corrigido.
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 🔎 find      base/caso-001/**  0.6s
  ┊ 📖 read      alerta.md  0.1s
  ┊ 📖 read      evidencia-catalogo.md  0.1s
  ┊ 📖 read      ficha-CAT-004821.md  0.1s
  ┊ 📖 read      POL-DADOS-003.md  0.1s
  ┊ 📖 read      regra-CAT-07.md  0.1s
  ┊ 📖 read      README.md  0.1s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A exposição ocorreu porque o campo de classificação do ativo está vazio, e a regra CAT-07 trata classificação nula como “Todos os usuários do catálogo”. Isso permitiu que um usuário de Parceiros_Externos, grupo sem autorização para ver ativos RESTRITO, localizasse e abrisse a ficha de clientes_contrato_ativo. A evidência confirma a visualização dos metadados no catálogo; não demonstra acesso aos dados no sistema de origem. [ficha-CAT-004821.md, linhas 14–18 e 35–36; regra-CAT-07.md, linhas 17–18 e 21–22; alerta.md, linhas 15–18]

Qual regra está envolvida

A política POL-DADOS-003 determina que dados pessoais, contratuais ou financeiros de clientes tenham classificação definida pelo responsável pelo dado; ativos sem classificação devem permanecer pendentes e não ser considerados automaticamente públicos. Também atribui ao Owner a definição da classificação e exige que alterações de visibilidade sigam fluxo de aprovação da Governança e do Owner. [POL-DADOS-003.md, linhas 3–18]

A regra CAT-07 define que, quando ativo.classificacao IS NULL, a visibilidade é “Todos os usuários do catálogo”. [regra-CAT-07.md, linhas 17–18]

Qual evidência sustenta

- A ficha identifica o ativo como tabela de informações cadastrais e contratuais de clientes ativos; marca dados pessoais e financeiros como presentes e criticidade alta. [ficha-CAT-004821.md, linhas 11–27]
- Os campos “Classificação de dados”, “Sensibilidade” e “Público autorizado” estão vazios. [ficha-CAT-004821.md, linhas 14–18 e 32–33]
- A visibilidade no catálogo está associada ao grupo catalogo-clientes. [ficha-CAT-004821.md, linhas 35–36]
- A regra CAT-07 concede visibilidade a todos os usuários do catálogo quando a classificação é nula. [regra-CAT-07.md, linhas 17–18]
- O usuário pertence a Parceiros_Externos; o chamado registra que esse grupo não pode visualizar ativos classificados como RESTRITO e que o usuário abriu a página de metadados. [alerta.md, linhas 14–18]
- O registro do catálogo documenta a busca por “clientes contrato”, o resultado clientes_contrato_ativo e a visualização da ficha às 14:18 de 25/09/2026. [evidencia-catalogo.md, linhas 4–12]

Qual o impacto

Está confirmada a exposição da ficha de metadados a pelo menos um usuário de Parceiros_Externos, em 25/09/2026 às 14:18. O material não confirma acesso aos dados armazenados no sistema de origem, nem informa se outros usuários ou grupos visualizaram a ficha. [evidencia-catalogo.md, linhas 4–12; regra-CAT-07.md, linhas 21–22; alerta.md, linhas 15–18]

O que está faltando

- A classificação definida pelo Owner do dado. A ficha identifica o Owner como “Dados Corporativos”, mas não nomeia uma pessoa. [ficha-CAT-004821.md, linhas 8–9 e 14–15]
- O fluxo de aprovação aplicável para a mudança de visibilidade não está detalhado nos materiais recebidos; a política apenas determina que alterações sigam fluxo aprovado pela Governança e pelo Owner. [POL-DADOS-003.md, linhas 17–18]
- Não há evidência de acesso efetivo ao sistema de origem nem de outras visualizações além do evento documentado no catálogo. [regra-CAT-07.md, linhas 21–22; evidencia-catalogo.md, linhas 4–12]

Qual correção proponho

1. Corrigir a regra CAT-07: classificação nula deve resultar em estado pendente e não em visibilidade para todos, conforme POL-DADOS-003. [regra-CAT-07.md, linhas 17–18; POL-DADOS-003.md, linhas 6–10]
2. Solicitar ao Owner do dado a definição da classificação; não presumir que seja RESTRITO apenas pelo conteúdo ou pelo relato do chamado. Depois da decisão, ajustar a visibilidade no catálogo pelo fluxo de aprovação da Governança e do Owner. [POL-DADOS-003.md, linhas 3–4, 12 e 17–18; ficha-CAT-004821.md, linhas 8–9 e 11–24]
3. Após a correção, validar que ativos sem classificação ficam pendentes e que a ficha não aparece para usuários não autorizados, sem confundir visibilidade de metadados com permissão de acesso aos dados de origem. [POL-DADOS-003.md, linhas 6–10; regra-CAT-07.md, linhas 21–22]

Quem precisa aprovar

- Owner do dado — definir a classificação. A ficha nomeia “Dados Corporativos” como Owner, sem identificar uma pessoa. [ficha-CAT-004821.md, linhas 8–9; POL-DADOS-003.md, linhas 12]
- Governança de Dados e Owner do dado — aprovar a alteração de visibilidade, conforme o fluxo previsto na política. A política não nomeia pessoas. [POL-DADOS-003.md, linhas 14–18]

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_110858_0e9a4a

Session:        20260929_110858_0e9a4a
Duration:       45s
Messages:       13 (1 user, 11 tool calls)
