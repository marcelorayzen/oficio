# governanca/002 — resposta do agente

- caso: `evals/governanca/002-leads-antes-do-catalogo.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T08:09:46-03:00

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

  ┊ 📚 skills    list governanca  0.0s
  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 🔎 find      *  0.9s
  ┊ 📚 skill     mapear-dados-pessoais  0.6s
  ┊ 📚 skill     classificar-ativo  0.4s
  ┊ 📚 skill     base-legal-e-finalidade  0.5s
  ┊ 📚 skill     revisar-acesso  0.6s
  ┊ 📖 read      marketing.leads_2026.yaml  0.1s
  ┊ 📖 read      marketing.leads_2026.csv  0.2s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 📖 read      perfil-empresa.md  0.1s
  ┊ 📖 read      campanha-pos-venda.md  0.1s
  ┊ 📖 read      HU-103-exportar-clientes-para-campanha.md  0.1s
  ┊ 📖 read      clientes.cadastro.yaml  0.0s
  ┊ 📖 read      vendas.pedidos.yaml  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      regras-do-profissional.md  0.1s [File not found: regras-do-profissional.md]
  ┊ 📖 read      normas-lgpd.md  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Calculating sample count**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ ⚡ tool_sear   0.2s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

O dataset marketing.leads_2026 não está apto para entrar no catálogo agora nem para ser disponibilizado ao grupo marketing. A ficha deixa sem preenchimento dono, finalidade, base legal e classificação, e não tem tags de classificação (base/catalogo/marketing.leads_2026.yaml, linhas 5–9). A amostra contém 60 registros e campos diretamente identificáveis — nome, CPF, e-mail e telefone — além de data de nascimento (base/dados/marketing.leads_2026.csv, cabeçalho e linhas 2–61). Quatro registros são de pessoas menores de 18 anos na data de referência de 2026-09-29: linhas 6, 23, 39 e 52 da amostra; por conter dados de menores, a classificação de referência da política é restrito (base/politicas/classificacao.md, linha 12). Não reproduzo os identificadores desses registros.

Há também uma pendência específica de origem: a ficha lista fornecedor-externo como fonte e lista_comprada como valor de origem (base/catalogo/marketing.leads_2026.yaml, linhas 19 e 22); 18 dos 60 registros têm origem=lista_comprada (base/dados/marketing.leads_2026.csv, linhas 3, 6, 11, 14, 17, 22, 23, 27, 29, 32, 35, 44, 46, 47, 52, 57 e 58). O material não documenta a procedência detalhada dessa lista nem a base legal aplicável ao uso proposto. A finalidade registrada para o pedido é apenas “campanha de fim de ano” (base/catalogo/marketing.leads_2026.yaml, linha 24); isso não substitui a finalidade específica e a base legal que faltam na ficha.

A regra automática R-07 classifica como interno quando a tag contem_pii não está presente; R-08 só eleva para restrito se houver contem_sensivel (base/politicas/classificacao.md, linhas 14–21). Como as tags da ficha estão vazias, essa regra pode resultar em classificação inferior à exigida pelo conteúdo — e não contempla, no trecho citado, o tratamento de dados de menores. Para esta amostra, a classificação coerente com a política é restrito, não interno (base/politicas/classificacao.md, linhas 10–18).

O pedido de acesso ao grupo marketing também não está pronto para aprovação: falta dono do dado, finalidade completa e prazo (base/catalogo/marketing.leads_2026.yaml, linhas 5–6 e 10; base/politicas/acesso.md, linhas 5–7). A política exige pessoas nomeadas e aprovação do dono e do encarregado para ativo restrito (base/politicas/classificacao.md, linha 12). A história de exportação de clientes relacionada à campanha prevê exportar todas as colunas pessoais e permitir exportação a qualquer usuário autenticado na área administrativa (base/qa/historias/HU-103-exportar-clientes-para-campanha.md, linhas 11–19); isso é um risco a resolver no desenho do uso, não evidência de que o grupo já acessou este dataset.

Qual regra está envolvida

- A Política de Classificação da Aurora define restrito para dados de menores e exige aprovação do dono e do encarregado; para dados pessoais comuns, define confidencial (base/politicas/classificacao.md, linhas 10–12).
- R-07 e R-08 atribuem nível com base nas tags contem_pii e contem_sensivel; as tags são preenchidas pelo dono (base/politicas/classificacao.md, linhas 14–21).
- A Política de Acesso exige solicitante, ativo, finalidade, prazo e gestor; prevê aprovação do dono e, para ativo restrito, também do encarregado. Acesso tem prazo máximo de 12 meses e revisão semestral (base/politicas/acesso.md, linhas 5–8).
- Para dados pessoais, a LGPD define dado pessoal no Art. 5º, I; a finalidade e a necessidade constam do Art. 6º, I e III; bases legais são tratadas no Art. 7º, e dados de menores no Art. 14 (skills/governanca/referencias/normas-lgpd.md, linhas 14–20 e 23). O material disponível não permite concluir qual base legal se aplica nem afirmar ilegalidade.

Qual evidência sustenta

- A ficha identifica o ativo, sistema e status pendente; deixa dono, finalidade, base legal e classificação vazios, tags vazias e consumidores vazios (base/catalogo/marketing.leads_2026.yaml, linhas 1–10 e 21–24).
- O esquema declara nome, CPF, e-mail, telefone e data de nascimento (base/catalogo/marketing.leads_2026.yaml, linhas 12–19); os mesmos campos estão presentes na amostra (base/dados/marketing.leads_2026.csv, cabeçalho).
- A amostra tem 60 registros de dados, nas linhas 2–61 do CSV (base/dados/marketing.leads_2026.csv).
- Quatro datas de nascimento da amostra correspondem a menores de 18 anos em 2026-09-29: linhas 6, 23, 39 e 52 (base/dados/marketing.leads_2026.csv).
- A origem declarada inclui formulário do site, planilha de eventos e fornecedor externo; o esquema também admite lista_comprada (base/catalogo/marketing.leads_2026.yaml, linhas 19 e 22). A amostra registra esse valor em 18 linhas.
- A política classifica dados de menores como restritos e exige aprovação do dono e do encarregado (base/politicas/classificacao.md, linha 12); o encarregado nomeado é Marta Siqueira (base/politicas/classificacao.md, linhas 25–27).
- A história de exportação proposta inclui todas as colunas pessoais e permite exportação por qualquer usuário autenticado na área administrativa (base/qa/historias/HU-103-exportar-clientes-para-campanha.md, linhas 11–19).

Qual o impacto

Se o dataset fosse disponibilizado conforme a ficha atual, o grupo marketing receberia acesso a dados pessoais e a dados de menores sem classificação coerente, finalidade/base legal registradas ou aprovadores identificados. A política não permite inferir que houve acesso efetivo; o material não contém logs. A extensão de eventual exposição e a existência de uso anterior não são determináveis pelas evidências disponíveis.

O que está faltando

- Dono do dado identificado, finalidade específica para a campanha, base legal registrada e classificação/tag coerentes com o conteúdo — campos ausentes na ficha (base/catalogo/marketing.leads_2026.yaml, linhas 5–9).
- Evidência documentada da procedência da lista comprada e da base aplicável ao uso dos registros de origem lista_comprada; a ficha e a amostra mostram a origem, mas não esses elementos (base/catalogo/marketing.leads_2026.yaml, linhas 19 e 22; base/dados/marketing.leads_2026.csv, coluna origem).
- Justificativa de necessidade das colunas pessoais para a campanha e escopo de acesso compatível com a classificação restrita.
- Solicitante/gestor responsável e prazo proposto para o acesso, conforme a política (base/politicas/acesso.md, linhas 5–7).
- Evidência sobre acessos efetivos, caso seja necessário avaliar quem já consultou o ativo; a ficha não traz logs, e a política informa que ficam na plataforma de dados e são consultados sob demanda (base/politicas/acesso.md, linhas 9–10).

Qual correção proponho

1. Não disponibilizar o dataset ao grupo enquanto as pendências de governança e aprovação não forem resolvidas.
2. Identificar o dono e completar finalidade e base legal após avaliação humana; documentar a procedência da lista externa.
3. Corrigir a classificação para refletir o dado de menor presente na amostra e revisar a regra/tag automática para que metadado ausente não resulte em classificação baixa.
4. Avaliar se a campanha precisa de todas as colunas e registros; considerar uma visão minimizada se ela atender à finalidade, como determina a política (base/politicas/acesso.md, linha 8).
5. Só então submeter a inclusão no catálogo e o acesso solicitado aos aprovadores competentes.

Quem precisa aprovar

- Dono do dado: a ficha não o identifica; precisa ser nomeado para aprovar o acesso. A política atribui ao dono a aprovação de acesso (base/politicas/acesso.md, linha 6).
- Marta Siqueira, encarregada (DPO): aprovação necessária para acesso a ativo restrito e para tratamento novo de dado pessoal (base/politicas/classificacao.md, linhas 25–27).
- O material não nomeia quem aprova especificamente a entrada no catálogo; a ficha apenas informa que está pendente de avaliação (base/catalogo/marketing.leads_2026.yaml, linha 4). Não atribuo essa aprovação a um papel sem evidência.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_110949_547776

Session:        20260929_110949_547776
Duration:       1m 46s
Messages:       30 (1 user, 28 tool calls)
