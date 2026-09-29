# governanca/008 — resposta do agente

- caso: `evals/governanca/008-anonimizado-que-nao-e.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T11:16:58-03:00

## Pedido

> O RH quer publicar `rh.pesquisa_clima` para todos, já que está anonimizada. Está ok?

## Resposta

Query: O RH quer publicar `rh.pesquisa_clima` para todos, já que está 
anonimizada. Está ok?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 🔎 find      *  0.5s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      rh.pesquisa_clima.yaml  0.1s
  ┊ 🔎 grep      RH|anonim|públic|public|acesso|classifica  0.4s
  ┊ 🔎 grep      rh.pesquisa_clima|pesquisa_clima  0.4s
  ┊ 📚 skills    list governanca  0.1s
  ┊ 📚 skill     classificar-ativo  0.5s
  ┊ 📚 skill     mapear-dados-pessoais  0.5s
  ┊ 📚 skill     base-legal-e-finalidade  0.5s
  ┊ 📚 skill     revisar-acesso  0.4s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 🔎 grep      anonim|pesquisa|setor|sexo|matricula_hash  0.4s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ tool_call   0.0s [Local tools require one entry per tool_call; ...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.1s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

Não recomendo publicar rh.pesquisa_clima para qualquer pessoa com as evidências atuais. A ficha diz que matricula_hash é sha256(matricula) e que as matrículas são numéricas e sequenciais, o que não demonstra anonimização efetiva. Além disso, na amostra, 58 de 58 registros têm uma combinação de setor, faixa etária e sexo; 5 dessas combinações aparecem uma única vez. Isso cria risco de reidentificação por combinação de atributos. A ficha já concede acesso a todos-colaboradores, mas isso não equivale a aprovação para divulgação externa.

Qual regra está envolvida

- A política de classificação define “público” como aprovado para divulgação externa; “interno” é para uso interno sem dado pessoal; e dado pessoal fica como confidencial. Dado de RH individual é restrito (base/politicas/classificacao.md, linhas 9–12).
- A regra R-11 permite classificar como interno ativos marcados anonimizado: true; ela não declara que essa marcação, por si só, autoriza publicação externa (base/politicas/classificacao.md, linha 19).
- A política atribui ao Comitê de Governança a aprovação de mudanças na política e nas regras automáticas (base/politicas/classificacao.md, linha 28).

Qual evidência sustenta

- A ficha descreve as respostas como anonimizadas, informa sha256(matricula), registra que as matrículas são sequenciais e lista as colunas matricula_hash, setor, faixa_etaria e sexo (base/catalogo/rh.pesquisa_clima.yaml, linhas 2 e 6–15, 18).
- A ficha identifica Beatriz Leal, Gerência de RH, como dona do dado e diz que a finalidade é medir clima organizacional por setor (base/catalogo/rh.pesquisa_clima.yaml, linhas 4–5).
- A ferramenta de amostras confirmou 58 registros (base/dados/rh.pesquisa_clima.csv, linhas 2–59; resultado de amostra_colunas).
- A contagem agrupada por setor, faixa etária e sexo retornou 58 registros distribuídos em 21 combinações; 5 combinações têm apenas um registro (resultado de amostra_contar; linhas do arquivo 2–59). Isso sustenta risco de singularidade na amostra, mas não prova, por si só, que alguém consiga identificar titulares.
- A política prevê acesso a todos-colaboradores para ativos internos, mas define público como divulgação externa (base/politicas/classificacao.md, linhas 9–10). A ficha lista todos-colaboradores como acesso atual (base/catalogo/rh.pesquisa_clima.yaml, linhas 9–10).

Qual o impacto

O material mostra exposição prevista aos colaboradores, não acesso efetivo nem divulgação externa já realizada. Não há log de acesso no material; a política diz que logs ficam na plataforma e são consultados pela Segurança sob demanda (base/politicas/acesso.md, linhas 9–10). A quantidade de pessoas externas ou titulares que poderiam ser afetadas por uma publicação não está determinada.

O que está faltando

- Evidência de que o hash não pode ser associado às matrículas, considerando que a ficha informa que elas são sequenciais.
- Avaliação de reidentificação das combinações e confirmação de se os dados correspondem a RH individual.
- Critérios e aprovação formal para divulgação externa; não constam na ficha consultada.

Qual correção proponho

Antes de qualquer publicação, submeter a avaliação de anonimização e reidentificação ao dono do dado e ao encarregado. Se a avaliação não demonstrar anonimização efetiva, manter a classificação compatível com dado pessoal/RH individual e não tratar a marcação anonimizado: true como autorização para divulgação externa. Se a intenção for mudar a regra que associa anonimização à classificação, a proposta deve passar pelo Comitê de Governança.

Quem precisa aprovar

- Beatriz Leal, dona do dado: avaliação do ativo e da proposta de divulgação (base/catalogo/rh.pesquisa_clima.yaml, linha 4).
- Marta Siqueira, encarregada: aprovação aplicável a tratamentos novos de dado pessoal e a acesso restrito (base/politicas/classificacao.md, linhas 26–27).
- Comitê de Governança: somente se houver proposta de alteração da política ou das regras automáticas (base/politicas/classificacao.md, linha 28).

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_141702_a168b3

Session:        20260929_141702_a168b3
Duration:       1m 2s
Messages:       32 (1 user, 30 tool calls)
