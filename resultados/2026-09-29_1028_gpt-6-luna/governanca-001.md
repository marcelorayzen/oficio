# governanca/001 — resposta do agente

- caso: `evals/governanca/001-catalogo-metadado-insuficiente.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T10:28:52-03:00

## Pedido

> Chegou o chamado de `base/caso-001/alerta.md`. Investigue o motivo da exposição e indique o que precisa ser corrigido.

## Resposta

Query: Chegou o chamado de `base/caso-001/alerta.md`. Investigue o motivo da 
exposição e indique o que precisa ser corrigido.
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 🔎 find      *  0.4s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      alerta.md  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      evidencia-catalogo.md  0.1s
  ┊ 📖 read      ficha-CAT-004821.md  0.1s
  ┊ 📖 read      POL-DADOS-003.md  0.1s
  ┊ 📖 read      regra-CAT-07.md  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Loading relevant skills**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 📚 skill     classificar-ativo  0.2s
  ┊ 📚 skill     revisar-acesso  0.3s
  ┊ 📚 skill     mapear-dados-pessoais  0.3s
  ┊ 📚 skill     base-legal-e-finalidade  0.3s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Identifying CAT-07 cause**
└──────────────────────────────────────────────────────────────────────────────┘

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A exposição ocorreu porque a regra CAT-07 trata classificação ausente como acesso amplo: quando ativo.classificacao IS NULL, define a visibilidade como “Todos os usuários do catálogo” (base/caso-001/regra-CAT-07.md, linhas 17–18). A classificação do ativo está vazia (base/caso-001/ficha-CAT-004821.md, linhas 14–18), e um usuário de Parceiros_Externos conseguiu localizar e abrir sua ficha no catálogo (base/caso-001/alerta.md, linhas 15–18).

O ativo contém informações cadastrais e contratuais de clientes, e a ficha declara que contém dados pessoais e financeiros (base/caso-001/ficha-CAT-004821.md, linhas 11–12 e 20–24). A evidência confirma exposição dos metadados no catálogo; não demonstra acesso aos dados armazenados no sistema de origem nem permite afirmar que houve vazamento.

Qual regra está envolvida

- A regra CAT-07 estabelece que classificação nula dá visibilidade a “Todos os usuários do catálogo” (base/caso-001/regra-CAT-07.md, linhas 17–18).
- A política POL-DADOS-003 determina que dados pessoais, contratuais ou financeiros de clientes tenham classificação definida pelo responsável; ativos sem classificação devem ficar pendentes, e não ser considerados públicos automaticamente (base/caso-001/POL-DADOS-003.md, linhas 3–10).
- A política atribui ao Owner do dado a definição da classificação e exige que alterações de visibilidade sigam aprovação da Governança e do Owner (base/caso-001/POL-DADOS-003.md, linhas 12–18).

Qual evidência sustenta

- base/caso-001/ficha-CAT-004821.md, linhas 4–9: ativo clientes_contrato_ativo, ID CAT-004821; Owner “Dados Corporativos”; Steward não definido.
- base/caso-001/ficha-CAT-004821.md, linhas 11–24: descrição cadastral e contratual; classificação e sensibilidade vazias; presença declarada de dados pessoais e financeiros.
- base/caso-001/regra-CAT-07.md, linhas 17–18: classificação nula resulta em visibilidade para todos os usuários do catálogo.
- base/caso-001/alerta.md, linhas 15–18: o usuário pertence a Parceiros_Externos, não autorizado a visualizar ativos restritos, e conseguiu abrir a página de metadados.
- base/caso-001/evidencia-catalogo.md, linhas 4–12: registro de 25/09/2026 às 14:18 mostra busca pelo ativo e visualização da ficha.

Qual o impacto

A ficha ficou visível a um usuário de Parceiros_Externos em 25/09/2026 às 14:18 (base/caso-001/evidencia-catalogo.md, linhas 4–12). A exposição comprovada é da página de metadados do catálogo. O material não comprova que o usuário acessou os dados no sistema de origem (base/caso-001/regra-CAT-07.md, linhas 21–22), nem informa se outros usuários externos visualizaram a ficha.

O que está faltando

- O nível de classificação que o Owner considera aplicável ao ativo; a ficha deixa classificação e sensibilidade vazias (base/caso-001/ficha-CAT-004821.md, linhas 14–18).
- Registros de acesso aos dados no sistema de origem e um histórico mais amplo de visualizações do catálogo, para determinar se houve outros acessos além do evento registrado.

Qual correção proponho

- Corrigir a causa: alterar a CAT-07 para que classificação ausente deixe o ativo pendente e não amplie sua visibilidade. A regra deve falhar de modo seguro, sem tratar NULL como “Todos os usuários do catálogo”.
- Corrigir o cadastro: solicitar ao Owner, “Dados Corporativos”, a definição da classificação e da sensibilidade do ativo, conforme POL-DADOS-003.
- Após a classificação, propor o ajuste da visibilidade do catálogo conforme o nível definido e o fluxo de aprovação previsto na política. O ajuste deve abranger o ativo enquanto a classificação estiver pendente, sem presumir qual nível final cabe a ele.
- Verificar os logs do sistema de origem e do catálogo para delimitar o alcance da exposição; o material atual só comprova a visualização registrada da ficha.

Quem precisa aprovar

- Owner “Dados Corporativos”: definição da classificação do ativo (base/caso-001/ficha-CAT-004821.md, linha 8; base/caso-001/POL-DADOS-003.md, linha 12).
- Governança de Dados e Owner “Dados Corporativos”: aprovação das alterações de visibilidade (base/caso-001/POL-DADOS-003.md, linhas 14–18). A política não nomeia pessoas específicas.
- A política não identifica quem aprova a alteração da regra CAT-07; esse aprovador não está determinado no material disponível.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_132856_6a95b1

Session:        20260929_132856_6a95b1
Duration:       44s
Messages:       19 (1 user, 17 tool calls)
