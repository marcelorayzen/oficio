# governanca/001 — resposta do agente

- caso: `evals/governanca/001-catalogo-metadado-insuficiente.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-28T21:51:36-03:00

## Pedido

> Chegou o chamado de `base/caso-001/alerta.md`. Investigue o motivo da exposição e indique o que precisa ser corrigido.

## Resposta

Query: Chegou o chamado de `base/caso-001/alerta.md`. Investigue o motivo da 
exposição e indique o que precisa ser corrigido.
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skills    list governanca  0.0s
  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 🔎 find      alerta.md  0.3s
  ┊ 🔎 find      *caso-001*  0.2s
  ┊ 📖 read      alerta.md  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Busco arquivos companion em base/caso001.**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 🔎 find      *  0.1s
  ┊ 📖 read      evidencia-catalogo.md  0.1s
  ┊ 📖 read      ficha-CAT-004821.md  0.1s
  ┊ 📖 read      POL-DADOS-003.md  0.1s
  ┊ 📖 read      regra-CAT-07.md  0.1s
  ┊ 📖 read      README.md  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Defino a classe e o responsável**
└──────────────────────────────────────────────────────────────────────────────┘

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A exposição da ficha no catálogo é explicada pela regra CAT-07: quando a classificação está vazia, a regra define a visibilidade como “Todos os usuários do catálogo”. A ficha de clientes_contrato_ativo está sem classificação e sem sensibilidade preenchidas; assim, o catálogo a tornou visível ao grupo Parceiros_Externos. Isso confirma exposição de metadados, não acesso aos dados armazenados no sistema de origem.

Qual regra está envolvida

- A POL-DADOS-003 determina que ativos com informações pessoais, contratuais ou financeiras tenham classificação definida pelo responsável pelo dado; ativos sem classificação devem permanecer pendentes, e não ser tratados como públicos (POL-DADOS-003.md, linhas 3–10). O Owner responde por definir a classificação (linhas 12–15).
- A CAT-07 determina que, se ativo.classificacao IS NULL, a visibilidade seja “Todos os usuários do catálogo” (regra-CAT-07.md, linhas 17–18). A regra também esclarece que controla a visibilidade no catálogo, não o acesso aos dados na origem (linhas 21–22).

Qual evidência sustenta

- A classificação e a sensibilidade da ficha estão vazias; a ficha declara que há dados pessoais e financeiros e que a criticidade é alta (ficha-CAT-004821.md, linhas 14–27).
- O Owner da ficha é Dados Corporativos; o Steward não está definido; o grupo de visibilidade cadastrado é catalogo-clientes (ficha-CAT-004821.md, linhas 8–9 e 32–36).
- O registro mostra que um usuário de Parceiros_Externos pesquisou pelo ativo e visualizou a ficha no catálogo (evidencia-catalogo.md, linhas 4–12). O chamado confirma que esse grupo não deveria visualizar ativos classificados como restritos e que o usuário abriu a página de metadados (alerta.md, linhas 14–18).
- A própria regra CAT-07 explica por que a ficha ficou visível apesar dos campos vazios (regra-CAT-07.md, linhas 17–18). O material não demonstra que o usuário acessou os dados no sistema de origem.

Qual o impacto

Está comprovada a visualização da página de metadados por um usuário do grupo Parceiros_Externos (alerta.md, linhas 15–18; evidencia-catalogo.md, linhas 4–12). Não é possível determinar, com o material disponível, se houve acesso aos dados na origem ou se outros usuários visualizaram a ficha. Também não há evidência de que a classificação correta do ativo seja RESTRITO; o chamado só informa que esse grupo não pode visualizar ativos que tenham essa classificação (alerta.md, linhas 5–8 e 14–18).

O que está faltando

- A classificação definida pelo Owner para este ativo.
- O critério pelo qual a regra CAT-07 deve tratar ativos ainda pendentes de classificação.
- A configuração efetiva e o escopo do grupo catalogo-clientes, além da relação dessa configuração com a CAT-07.
- Logs que indiquem se houve acesso ao sistema de origem ou visualizações adicionais da ficha.

Qual correção proponho

- Corrigir a causa: revisar a CAT-07 para que uma classificação nula ou pendente não conceda visibilidade geral. A regra precisa manter o ativo restrito enquanto aguarda a decisão do Owner, conforme a POL-DADOS-003 (POL-DADOS-003.md, linhas 6–10; regra-CAT-07.md, linhas 17–18). O fluxo e a configuração final devem ser definidos e aprovados pelos responsáveis.
- Corrigir o cadastro: o Owner Dados Corporativos deve definir a classificação do ativo; Governança deve validar a aplicação da política (ficha-CAT-004821.md, linhas 8–9; POL-DADOS-003.md, linhas 12–15).
- Depois das aprovações, revisar a visibilidade da ficha e verificar, por logs, se houve acesso aos dados na origem. A CAT-07 não controla esse acesso (regra-CAT-07.md, linhas 21–22).

Quem precisa aprovar

- Dados Corporativos, como Owner: definição da classificação do ativo (ficha-CAT-004821.md, linhas 8–9; POL-DADOS-003.md, linha 12).
- Governança de Dados: validação da política e acompanhamento da correção (POL-DADOS-003.md, linhas 14–18).
- Responsável pelo catálogo e responsáveis pela configuração da CAT-07: revisão e aplicação da regra de visibilidade, conforme o fluxo de aprovação previsto na política (POL-DADOS-003.md, linhas 17–18). O material não identifica nominalmente quem administra a configuração.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_005140_7b1dc9

Session:        20260929_005140_7b1dc9
Duration:       57s
Messages:       19 (1 user, 17 tool calls)
