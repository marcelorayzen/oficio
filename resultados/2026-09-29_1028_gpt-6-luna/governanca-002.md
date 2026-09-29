# governanca/002 — resposta do agente

- caso: `evals/governanca/002-leads-antes-do-catalogo.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T10:29:42-03:00

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
  ┊ 📚 skills    list governanca  0.1s
  ┊ 📚 skill     governanca:mapear-dados-pessoais  0.6s
  ┊ 📚 skill     governanca:classificar-ativo  0.5s
  ┊ 📚 skill     governanca:base-legal-e-finalidade  0.5s
  ┊ 📚 skill     governanca:revisar-acesso  0.6s
  ┊ 📖 read      marketing.leads_2026.yaml  0.1s
  ┊ 🔎 find      *.md  0.4s
  ┊ 🔎 find      amostra_colunas  0.1s
  ┊ ⚡ tool_sear   0.1s
  ┊ ⚡ tool_sear   0.0s
  ┊ ⚡ tool_desc   0.0s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 📖 read      campanha-pos-venda.md  0.1s
  ┊ 📖 read      normas-lgpd.md  0.1s [File not found: normas-lgpd.md]
  ┊ ⚡ tool_call   0.0s [Local tools require one entry per tool_call; ...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ 📖 read      README.md  0.0s
  ┊ 🔎 find      normas*  0.1s
  ┊ ⚡ mcp__amos   0.0s [Error executing tool amostra_linhas: coluna '...]
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ 📖 read      vendas.pedidos.yaml  0.1s
  ┊ 📖 read      PA-031.md  0.1s
  ┊ 📖 read      HU-103-exportar-clientes-para-campanha.md  0.1s
  ┊ 🔎 grep      marketing.leads_2026|lista_comprada|campanha|Marta|Ana|dono  0.4s
  ┊ 📖 read      classificacao.md  0.0s
  ┊ ⚡ mcp__amos   0.0s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

Não recomendo catalogar marketing.leads_2026 agora nem disponibilizá-lo ao grupo marketing. A ficha está marcada pendente_entrada e deixa sem preenchimento dono, finalidade, base legal, tags e classificação (catalogo/marketing.leads_2026.yaml, linhas 4–10). A amostra tem 60 registros; 17 têm origem lista_comprada e 4 têm data de nascimento posterior a 29/09/2008, ou seja, são menores de 18 anos nessa data de referência. Três desses quatro estão na origem lista_comprada (base/dados/marketing.leads_2026.csv, linhas 6, 23 e 52, conforme amostra_contar). A ficha declara colunas de CPF, e-mail, telefone e data de nascimento (catalogo/marketing.leads_2026.yaml, linhas 12–19); na amostra, CPF e e-mail não estão vazios em nenhum dos 60 registros (amostra_resumo, campos vazios).

A origem comprada merece atenção especial: a ficha registra fornecedor-externo entre as origens, e a amostra identifica 17 linhas como lista_comprada (catalogo/marketing.leads_2026.yaml, linha 22; amostra_contar, grupo origem). Não encontrei evidência de finalidade/base legal para esse tratamento nem de que a origem e o uso proposto estejam cobertos por informação aos titulares. Não concluo que a compra seja irregular; concluo que o material disponível não sustenta a entrada e o uso pretendido.

Qual regra está envolvida

- A Política de Classificação da Aurora define como restrito ativos com dados pessoais de menores; o acesso a esse nível é limitado a pessoas nomeadas e requer aprovação do dono e da encarregada (base/politicas/classificacao.md, linhas 7–12).
- A regra automática R-07 classifica como interno quando falta a tag contem_pii; a R-08 usa contem_sensivel para restrito (base/politicas/classificacao.md, linhas 14–21). Como a ficha tem tags: [] e contém CPF e outros identificadores pessoais, a regra R-07 cria risco de classificação abaixo do conteúdo (catalogo/marketing.leads_2026.yaml, linhas 8 e 12–17).
- A política exige finalidade específica, prazo e gestor em pedidos de acesso; o dono aprova, e ativos restritos também precisam da encarregada. Também determina preferir uma visão sem colunas pessoais quando ela atende à finalidade (base/politicas/acesso.md, linhas 5–10).
- A política identifica Marta Siqueira como encarregada, responsável por aprovar tratamentos novos de dados pessoais e acessos a ativos restritos (base/politicas/classificacao.md, linhas 25–28).

Qual evidência sustenta

- A ficha está incompleta: dono, finalidade, base legal e classificação estão vazios; não há tags nem regras de qualidade declaradas (catalogo/marketing.leads_2026.yaml, linhas 5–10 e 20).
- A ficha declara CPF, e-mail, telefone e data de nascimento, além de cidade, nome e identificador do lead (catalogo/marketing.leads_2026.yaml, linhas 12–19). A amostra tem 60 registros; CPF e e-mail têm zero vazios (amostra_colunas e amostra_resumo, campos registros e vazios).
- A amostra tem 17 registros lista_comprada, 19 evento e 24 site (amostra_contar, agrupamento por origem). A ficha também lista fornecedor-externo como origem (catalogo/marketing.leads_2026.yaml, linha 22).
- Quatro registros têm data de nascimento após 29/09/2008: linhas 6, 23, 39 e 52; três são lista_comprada (linhas 6, 23 e 52) (amostra_contar e amostra_linhas, filtro de data; datas em base/dados/marketing.leads_2026.csv). Isso confirma menores na amostra, mas não identifica se há crianças com menos de 12 anos: seria necessária uma contagem específica.
- A amostra distribui as origens pelos 60 registros; sua conclusão não é uma verificação de cargas futuras (amostra_contar, total da amostra).
- A campanha pedida é descrita como “campanha de fim de ano” (catalogo/marketing.leads_2026.yaml, linha 24), mas a finalidade formal da ficha está vazia (linha 6). A linhagem declara consumidores vazios (linha 23).
- A política de classificação atribui restrito a dados de menores e a política de acesso limita esse nível a pessoas nomeadas; portanto, o acesso ao grupo marketing não pode ser considerado adequado com as evidências atuais (base/politicas/classificacao.md, linhas 11–12; catalogo/marketing.leads_2026.yaml, linha 10).

Qual o impacto

Se a ficha for publicada como está, a regra R-07 pode tratar a ausência de tags como classificação interno, apesar dos identificadores pessoais e dos registros de menores. Isso não prova que alguém acessou ou que houve exposição; não foram fornecidos logs. A política informa que os logs ficam na plataforma de dados e são consultados pela Segurança sob demanda (base/politicas/acesso.md, linhas 9–10).

O que está faltando

- Dono do dado identificado pelo nome; finalidade específica e compatível com a campanha; base legal documentada e evidência que sustente o uso de cada origem, especialmente a lista comprada.
- Classificação coerente com a amostra, tags e tratamento da exceção de dados de menores na regra automática.
- Definição de quem, nominalmente, precisa acessar o ativo restrito e justificativa de necessidade; a ficha indica apenas o grupo marketing.
- Linhagem completa e consumidores previstos. A ficha não identifica consumidores e não explica como os dados de cada origem foram obtidos (catalogo/marketing.leads_2026.yaml, linhas 21–24).
- Avaliação do tratamento novo de dados pessoais e dos menores pela encarregada. O material não traz evidência dessa aprovação.
- Verificação, pela pessoa responsável, do número de crianças com menos de 12 anos na amostra. A contagem disponível agrupa todos os menores de 18.

Qual correção proponho

Regularizar ficha, dono, finalidade, base legal e linhagem; documentar a procedência e a autorização/condições de uso das listas compradas antes de propor seu uso na campanha. Reavaliar a classificação para refletir o conteúdo com dados de menores e rever a regra R-07, pois hoje a ausência da tag leva ao nível interno. Definir acesso por pessoas nomeadas, com justificativa e necessidade, em vez de presumir que o grupo marketing pode receber acesso. Não disponibilizar o ativo enquanto essas pendências não forem avaliadas e aprovadas pelos responsáveis.

Quem precisa aprovar

- Dono do dado: a ficha não informa o nome; o responsável precisa ser identificado. A política atribui ao dono a aprovação de acesso (base/politicas/classificacao.md, linhas 25–26).
- Marta Siqueira, encarregada (DPO): aprovação do tratamento novo de dados pessoais e, se mantida a classificação restrita, do acesso (base/politicas/classificacao.md, linhas 11–12 e 26–27).
- Comitê de Governança de Dados: eventual alteração da regra automática R-07, pois mudanças nas regras da política são de sua alçada (base/politicas/classificacao.md, linhas 3 e 28).

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_132946_f495b4

Session:        20260929_132946_f495b4
Duration:       2m 20s
Messages:       64 (1 user, 62 tool calls)
