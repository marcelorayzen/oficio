# governanca/006 — resposta do agente

- caso: `evals/governanca/006-catalogo-metadado-insuficiente-sintetico.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T10:36:17-03:00

## Pedido

> Recebemos um aviso de que `atendimento.chamados` pode ter informação que não deveria estar aberta a todos. Pode investigar o ativo, explicar o que encontrou, avaliar o impacto e indicar as correções necessárias?

## Resposta

Query: Recebemos um aviso de que `atendimento.chamados` pode ter informação que 
não deveria estar aberta a todos. Pode investigar o ativo, explicar o que 
encontrou, avaliar o impacto e indicar as correções necessárias?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 🔎 find      *  0.4s
  ┊ 📖 read      README.md  0.0s
  ┊ 📚 skill     mapear-dados-pessoais  0.2s
  ┊ 📚 skill     classificar-ativo  0.2s
  ┊ 📚 skill     base-legal-e-finalidade  0.2s
  ┊ 📚 skill     revisar-acesso  0.2s
  ┊ 📖 read      atendimento.chamados.yaml  0.0s
  ┊ 🔎 find      *  0.1s
  ┊ 📖 read      classificacao.md  0.0s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      campanha-pos-venda.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 🔎 find      chamados  0.1s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ tool_call   0.0s [Local tools require one entry per tool_call; ...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Locating linked norm file**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 🔎 grep      Art. 11|Art. 5|Art. 6  0.2s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A amostra de atendimento.chamados contém CPF em 3 de 40 registros (7,5%) no campo de texto livre descricao; também contém uma menção a gravidez e recomendação médica em 1 de 40 (2,5%). O catálogo classifica o ativo como interno, mas a política define restrito para dado pessoal sensível. O acesso está configurado para todos-colaboradores, grupo descrito no mapa como aproximadamente 1.200 pessoas. Isso configura exposição potencial incompatível com a classificação indicada pelo conteúdo. Não há evidência de que essas pessoas tenham efetivamente acessado os registros.

Qual regra está envolvida

- Política de Classificação da Informação da Aurora, linhas 10–12: interno é para uso interno sem dado pessoal; confidencial abrange dado pessoal; restrito abrange dado pessoal sensível.
- Política de Classificação, linhas 16–21: a regra R-07 classifica como confidencial quando existe a tag contem_pii e, caso contrário, como interno; as tags são preenchidas pelo dono.
- Política de Acesso, linhas 5–7: o dono aprova acessos; ativos restritos também precisam de aprovação do encarregado; acessos têm prazo máximo de 12 meses e revisão semestral.
- LGPD, Art. 5º, incisos I e II, conforme descrito na skill de mapeamento: CPF é dado pessoal; saúde está entre os dados pessoais sensíveis. A amostra identificou relato de gravidez e recomendação médica, evidência de informação relacionada à saúde. Isso sustenta a necessidade de tratar o conteúdo sob o piso restrito previsto pela política; não é uma conclusão jurídica sobre o caso.

Qual evidência sustenta

- base/catalogo/atendimento.chamados.yaml, linhas 8–9: classificação interno atribuída por R-07 e acesso a todos-colaboradores.
- base/catalogo/atendimento.chamados.yaml, linhas 13–14: descricao é texto livre, descrito como relato do atendente; linhas 17–19 indicam origem sistema-sac e consumidor painel_sac_bi.
- base/README.md, linhas 27–28: todos-colaboradores tem aproximadamente 1.200 pessoas.
- Ferramenta amostra_colunas para atendimento.chamados: arquivo base/dados/atendimento.chamados.csv, 40 registros e campos id_chamado, aberto_em, assunto, descricao, status.
- Ferramenta amostra_contar, filtro de CPF em descricao: 3 de 40 registros, 7,5%, linhas 8, 20 e 34 do arquivo. A ferramenta amostra_linhas confirmou esses casos; os valores foram omitidos aqui.
- Ferramenta amostra_contar, filtro de termos relacionados à saúde em descricao: 1 de 40, 2,5%, linha 31. amostra_linhas confirmou relato de gravidez e recomendação médica; o trecho identificador do chamado foi omitido.
- base/politicas/classificacao.md, linhas 16–21: sem a tag de dado pessoal, a R-07 classifica como interno; a ficha do ativo tem apenas as tags sac e operacional (base/catalogo/atendimento.chamados.yaml, linha 7).
- base/politicas/acesso.md, linhas 9–10: logs ficam na plataforma e são consultados pela Segurança sob demanda; não estão replicados no catálogo.

Qual o impacto

O que está comprovado é que a política de acesso permite visibilidade ao grupo de aproximadamente 1.200 colaboradores, enquanto a amostra contém dados pessoais e um relato de saúde. O ativo foi criado em 2024-06-10 (base/catalogo/atendimento.chamados.yaml, linha 20); a política de classificação citada está vigente desde 2025-02-01 (base/politicas/classificacao.md, linha 3). O material não permite determinar desde quando a configuração de acesso esteve efetiva nem quem consultou os registros. Portanto, não concluo que houve acesso indevido ou vazamento.

A conclusão quantitativa vale para a amostra de 40 registros, não necessariamente para todo o ativo ou cargas futuras.

O que está faltando

- Logs de acesso da plataforma, necessários para identificar consultas efetivas, pessoas/grupos e período. A política informa que Segurança pode consultá-los sob demanda (base/politicas/acesso.md, linhas 9–10).
- Histórico de mudanças da classificação, tags e permissões, para determinar quando a exposição potencial começou.
- Confirmação do escopo real do dado de saúde e dos consumidores do ativo; a ficha lista painel_sac_bi, mas não descreve seus campos expostos nem o público autorizado (base/catalogo/atendimento.chamados.yaml, linhas 17–19).

Qual correção proponho

1. Recomendo ao dono que avalie restringir o acesso amplo enquanto a revisão é feita e definir acesso por necessidade de conhecer; não estou alterando permissões. Se o conteúdo sensível for confirmado no ativo, aplicar o nível restrito e o fluxo de aprovação correspondente.
2. Corrigir a causa sistêmica da R-07: ausência de tag não deve rebaixar automaticamente o ativo a interno. Proponho um padrão seguro que sinalize classificação pendente para revisão, sem conceder acesso amplo até a classificação ser confirmada.
3. Revisar descricao: evitar registrar CPF e dados de saúde em texto livre; avaliar remoção ou mascaramento dos dados já existentes, preservando somente o necessário à finalidade declarada. A política de acesso também determina preferir uma visão sem colunas pessoais quando ela atender à finalidade (base/politicas/acesso.md, linha 8).
4. Solicitar à Segurança consulta dos logs para apurar acessos efetivos e avaliar, com os responsáveis competentes, os encaminhamentos cabíveis.

Quem precisa aprovar

- Renato Lobo, dono do dado segundo a ficha: decisão sobre acesso ao ativo e tratamento das correções no conteúdo (base/catalogo/atendimento.chamados.yaml, linha 4; base/politicas/classificacao.md, linha 25).
- Marta Siqueira, encarregada: aprovação do acesso se o ativo for tratado como restrito e de tratamento novo de dado pessoal (base/politicas/classificacao.md, linhas 26–27).
- Comitê de Governança de Dados: mudança na regra automática R-07 (base/politicas/classificacao.md, linhas 3 e 28).
- Segurança: consulta dos logs conforme demanda; o material não nomeia uma pessoa aprovadora para essa consulta (base/politicas/acesso.md, linhas 9–10).

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_133621_75faa5

Session:        20260929_133621_75faa5
Duration:       2m 51s
Messages:       51 (1 user, 49 tool calls)
