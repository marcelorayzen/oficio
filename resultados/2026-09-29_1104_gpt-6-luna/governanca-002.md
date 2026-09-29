# governanca/002 — resposta do agente

- caso: `evals/governanca/002-leads-antes-do-catalogo.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T11:05:16-03:00

## Pedido

> O time de Marketing quer usar o dataset `marketing.leads_2026` numa campanha de fim de ano e pediu a inclusão dele no catálogo corporativo. Antes de disponibilizá-lo para o grupo `marketing`, precisamos saber se ele está apto a entrar. Pode analisar o material e dizer: se o dataset pode ser catalogado agora; quais problemas ou pendências encontrou; quais informações precisam ser regularizadas; e quem precisa aprovar a entrada?

## Resposta

Query: O time de Marketing quer usar o dataset `marketing.leads_2026` numa 
campanha de fim de ano e pediu a inclusão dele no catálogo corporativo. Antes de
disponibilizá-lo para o grupo `marketing`, precisamos saber se ele está apto a 
entrar. Pode analisar o material e dizer: se o dataset pode ser catalogado 
agora; quais problemas ou pendências encontrou; quais informações precisam ser 
regularizadas; e quem precisa aprovar a entrada?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     governanca:avaliar-ativo  0.2s
  ┊ 🔎 find      README.md  0.2s
  ┊ 📖 read      README.md  0.0s
  ┊ 📚 skill     governanca:mapear-dados-pessoais  0.2s
  ┊ 📚 skill     governanca:classificar-ativo  0.2s
  ┊ 📚 skill     governanca:base-legal-e-finalidade  0.2s
  ┊ 📚 skill     governanca:revisar-acesso  0.2s
  ┊ 🔎 find      *marketing*  0.1s
  ┊ 📖 read      marketing.leads_2026.yaml  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 🔎 find      *  0.1s
  ┊ ⚡ tool_sear   0.1s
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ tool_call   0.0s [Local tools require one entry per tool_call; ...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking list_comprada source**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 📖 read      campanha-pos-venda.md  0.0s
  ┊ 📖 read      reclamacoes-entrega.md  0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

O dataset não está apto para entrada no catálogo agora. A ficha está com status pendente_entrada e deixa sem preenchimento dono, finalidade, base legal e classificação; além disso, não declara tags nem regras de qualidade (catálogo, campos status, dono, finalidade, base_legal, tags, classificacao e qualidade, linhas 4–9 e 20). A amostra confirma dados pessoais diretos e contém 4 registros de pessoas menores de 18 anos na data de referência de 29/09/2026: linhas 6, 23, 39 e 52 do arquivo de dados, contadas pela ferramenta de amostra. Pela política, isso exige classificação restrito; portanto, a classificação e o acesso precisam ser avaliados antes da entrada e do uso pelo grupo marketing.

Há ainda uma pendência relevante na origem: 17 dos 60 registros da amostra estão marcados como lista_comprada (ferramenta de amostra, linhas do arquivo 2–61). O material não explica a procedência, a autorização ou as condições de uso dessa lista. Isso não prova irregularidade, mas impede concluir se a finalidade de campanha está adequadamente fundamentada. A amostra não tem valores vazios nas colunas email e telefone (0/60 em cada, ferramentas de amostra); isso não resolve as demais pendências de governança.

Qual regra está envolvida

- A Política de Classificação da Informação define restrito para ativos com dado pessoal sensível, dado de menores ou dado individual de RH; acesso restrito é limitado a pessoas nomeadas e depende de aprovação do dono e do encarregado ( base/politicas/classificacao.md, linhas 7–12).
- A regra automática R-07 classifica como confidencial quando existe a tag contem_pii e, caso contrário, como interno; R-08 classifica como restrito quando existe contem_sensivel (base/politicas/classificacao.md, linhas 14–21). A ficha está sem tags e sem classificação (base/catalogo/marketing.leads_2026.yaml, linhas 8–9). Aplicada literalmente, R-07 pode rebaixar a classificação quando a tag está ausente, embora a amostra contenha dados pessoais e registros de menores.
- A Política de Acesso exige finalidade no pedido, aprovação do dono e, para ativo restrito, também do encarregado; pede prazo máximo de 12 meses e revisão semestral. Quando uma visão sem colunas pessoais atende à finalidade, ela deve ser preferida (base/politicas/acesso.md, linhas 5–10).
- A ficha não informa base legal nem finalidade específica (base/catalogo/marketing.leads_2026.yaml, linhas 5–7). Para tratamento de dados pessoais, a LGPD exige finalidade legítima, específica e explícita (Art. 6º, I); o material não permite verificar a base legal aplicável nem concluir sobre a legitimidade do tratamento.

Qual evidência sustenta

- A ficha identifica colunas nome, cpf, email, telefone e data_nascimento (base/catalogo/marketing.leads_2026.yaml, linhas 11–19). A amostra tem 60 registros e as mesmas colunas (amostra_colunas, arquivo base/dados/marketing.leads_2026.csv).
- A ferramenta amostra_contar encontrou 4 registros com data_nascimento posterior a 29/09/2008, critério correspondente a menores de 18 na data de referência. As linhas devolvidas foram 6, 23, 39 e 52 do CSV. A ferramenta amostra_resumo informa 60 valores preenchidos e distintos nessa coluna.
- A ferramenta amostra_contar, agrupada por origem, encontrou 24 registros site, 19 evento e 17 lista_comprada, em 60 no total. A ficha declara essas três origens (base/catalogo/marketing.leads_2026.yaml, linha 19).
- A ficha registra como origem formulario-site, planilha-eventos e fornecedor-externo, mas não relaciona cada origem aos registros nem descreve o fornecedor ou a obtenção dos dados (base/catalogo/marketing.leads_2026.yaml, linhas 21–22).
- O pedido identifica apenas “Equipe de Marketing” e o motivo “para campanha de fim de ano”; não nomeia dono, não descreve finalidade específica nem informa prazo (base/catalogo/marketing.leads_2026.yaml, linhas 5–7 e 24).
- A amostra não tem campos vazios de email nem de telefone: 0/60 para cada coluna, conforme contagens da ferramenta de amostra. A ficha, porém, declara a lista de qualidade vazia (base/catalogo/marketing.leads_2026.yaml, linha 20).

Qual o impacto

Se o dataset for classificado conforme o conteúdo observado, ele é restrito, e a política não permite tratar o acesso como uma liberação genérica ao grupo marketing: exige pessoas nomeadas e aprovação do dono e do encarregado (base/politicas/classificacao.md, linhas 7–12). A ficha lista marketing no campo de acesso, mas não documenta aprovações nem pessoas nomeadas (base/catalogo/marketing.leads_2026.yaml, linha 10). Isso mostra o acesso pretendido, não prova que alguém já acessou; não há logs de acesso no material, e a política informa que eles ficam na plataforma de dados (base/politicas/acesso.md, linhas 9–10).

O que está faltando

- Identidade do dono do dado e confirmação da finalidade específica da campanha, incluindo quais dados são necessários.
- Base legal declarada e documentação que permita avaliá-la para essa finalidade.
- Procedência e condições de uso dos registros lista_comprada, além do vínculo entre cada origem declarada e os registros.
- Decisão de classificação coerente com os dados e validação das regras automáticas, considerando a ausência de tags e a presença de registros de menores.
- Definição do escopo de acesso restrito — pessoas nomeadas, justificativa, prazo e aprovações — antes de disponibilizar o ativo.
- Regras de qualidade aplicáveis e evidência de como serão verificadas. A ficha declara qualidade: []; não há uma política citada que torne a ausência dessa lista, por si só, uma violação.

Qual correção proponho

Regularizar a ficha com dono, finalidade específica, base legal e classificação avaliada; documentar a procedência e as condições de uso de cada origem, em especial da lista comprada; e revisar R-07 para que a ausência de tag não resulte automaticamente em classificação interna quando o conteúdo ainda não foi validado. Antes de disponibilizar o dataset, definir e submeter o acesso restrito às aprovações requeridas pela política. Também propor regras de qualidade pertinentes ao uso, sem presumir que campos preenchidos garantam validade.

Quem precisa aprovar

- O dono do dado, que não está identificado na ficha, precisa ser nomeado e aprovar o acesso (base/politicas/acesso.md, linhas 5–7).
- Marta Siqueira, encarregada (DPO), precisa aprovar o acesso ao ativo restrito e tratamentos novos de dados pessoais (base/politicas/classificacao.md, linhas 25–27).
- O Comitê de Governança de Dados precisa aprovar alteração nas regras automáticas de classificação, caso a correção proposta a R-07 implique mudança de política (base/politicas/classificacao.md, linhas 23–28).

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_140520_aa80ff

Session:        20260929_140520_aa80ff
Duration:       1m 56s
Messages:       42 (1 user, 40 tool calls)
