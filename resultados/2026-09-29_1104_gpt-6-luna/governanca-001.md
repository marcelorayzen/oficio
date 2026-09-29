# governanca/001 — resposta do agente

- caso: `evals/governanca/001-catalogo-metadado-insuficiente.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T11:04:24-03:00

## Pedido

> Chegou o chamado de `base/caso-001/alerta.md`. Investigue o motivo da exposição e indique o que precisa ser corrigido.

## Resposta

Query: Chegou o chamado de `base/caso-001/alerta.md`. Investigue o motivo da 
exposição e indique o que precisa ser corrigido.
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      alerta.md  0.0s
  ┊ 🔎 find      *  0.2s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      evidencia-catalogo.md  0.1s
  ┊ 📖 read      ficha-CAT-004821.md  0.1s
  ┊ 📖 read      POL-DADOS-003.md  0.1s
  ┊ 📖 read      regra-CAT-07.md  0.1s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A causa da exposição no catálogo é a combinação de uma classificação vazia na ficha do ativo com uma regra de visibilidade que trata classificação nula como acesso para “Todos os usuários do catálogo”. Isso permitiu que um usuário de Parceiros_Externos localizasse e abrisse os metadados de clientes_contrato_ativo. A evidência confirma exposição da ficha no catálogo; não demonstra acesso aos dados armazenados no sistema de origem.

Qual regra está envolvida

- A regra CAT-07 define que, quando ativo.classificacao IS NULL, a visibilidade é “Todos os usuários do catálogo” (base/caso-001/regra-CAT-07.md, linhas 17–18).
- A política POL-DADOS-003 determina que dados pessoais, contratuais ou financeiros de clientes devem ter classificação definida pelo responsável; sem classificação, o ativo fica pendente e não deve ser considerado automaticamente público (base/caso-001/POL-DADOS-003.md, linhas 3–10).
- A política atribui ao Owner a definição da classificação e à Governança a validação da política e o acompanhamento dos desvios (base/caso-001/POL-DADOS-003.md, linhas 12–15). Alterações de visibilidade devem seguir aprovação da Governança e do Owner (linhas 17–18).

Qual evidência sustenta

- A ficha registra classificação e sensibilidade vazias, mas informa que o ativo contém dados pessoais e financeiros, tem criticidade alta e está em produção (base/caso-001/ficha-CAT-004821.md, linhas 14–30).
- O Owner está identificado como “Dados Corporativos”; o público autorizado está vazio; o grupo de visibilidade registrado é catalogo-clientes (base/caso-001/ficha-CAT-004821.md, linhas 8–9 e 32–36).
- O registro de uso mostra que, em 25/09/2026 às 14:18, um usuário de Parceiros_Externos pesquisou pelo ativo e visualizou sua ficha no catálogo (base/caso-001/evidencia-catalogo.md, linhas 4–12).
- O chamado informa que o grupo não está autorizado a visualizar ativos classificados como RESTRITO e confirma que o usuário abriu a página de metadados (base/caso-001/alerta.md, linhas 14–18).
- A regra CAT-07 controla visibilidade no catálogo, mas não representa autorização de acesso aos dados no sistema de origem (base/caso-001/regra-CAT-07.md, linhas 21–22).

Qual o impacto

A exposição confirmada é dos metadados do ativo para um usuário de Parceiros_Externos, em 25/09/2026 às 14:18 (base/caso-001/evidencia-catalogo.md, linhas 4–12). Como a ficha descreve dados cadastrais e contratuais de clientes e indica dados pessoais e financeiros (base/caso-001/ficha-CAT-004821.md, linhas 11–24), a visibilidade ampla da ficha é incompatível com a pendência de classificação prevista na política. Não é possível determinar, com o material disponível, se houve acesso aos dados de origem ou quem mais visualizou os metadados.

O que está faltando

- A classificação aplicável, que deve ser definida pelo Owner (base/caso-001/POL-DADOS-003.md, linhas 9–12).
- O público autorizado para a ficha, atualmente vazio (base/caso-001/ficha-CAT-004821.md, linhas 32–33).
- Evidência de autorização ou de acesso efetivo ao sistema de origem; o registro fornecido trata apenas da visualização no catálogo (base/caso-001/regra-CAT-07.md, linhas 21–22).

Qual correção proponho

1. Ajustar a CAT-07 para que classificação nula não resulte em visibilidade para todos; manter o ativo pendente de classificação e sem exposição ampla enquanto o Owner define o nível aplicável, conforme a POL-DADOS-003.
2. Solicitar ao Owner Dados Corporativos que defina e registre a classificação e o público autorizado do ativo.
3. Após a definição, revisar a visibilidade do catálogo conforme a classificação e o público autorizado, seguindo o fluxo de aprovação da Governança e do Owner.
4. Separadamente, verificar os registros de autorização e acesso do sistema de origem. A evidência atual confirma somente exposição dos metadados, não acesso aos dados.

Quem precisa aprovar

- Owner “Dados Corporativos”: classificação do ativo e público autorizado, conforme a política e a ficha (base/caso-001/POL-DADOS-003.md, linhas 12 e 17–18; base/caso-001/ficha-CAT-004821.md, linha 8).
- Governança de Dados: validação da aplicação da política e aprovação da alteração de visibilidade, conforme base/caso-001/POL-DADOS-003.md, linhas 14–18.
- A política não identifica nominalmente as pessoas que compõem o Owner ou a Governança.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_140428_801dfc

Session:        20260929_140428_801dfc
Duration:       45s
Messages:       16 (1 user, 14 tool calls)
