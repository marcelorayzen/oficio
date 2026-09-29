# governanca/002 — resposta do agente

- caso: `evals/governanca/002-leads-antes-do-catalogo.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-28T21:52:39-03:00

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

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Loading required subskills**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 📚 skill     governanca:mapear-dados-pessoais  0.5s
  ┊ 📚 skill     governanca:classificar-ativo  0.5s
  ┊ 📚 skill     governanca:base-legal-e-finalidade  0.6s
  ┊ 📚 skill     governanca:revisar-acesso  0.6s
  ┊ 🔎 find      *  0.8s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Reading relevant materials**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 📖 read      marketing.leads_2026.yaml  0.1s
  ┊ 📖 read      marketing.leads_2026.csv  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      POL-DADOS-003.md  0.1s
  ┊ 📖 read      regra-CAT-07.md  0.2s
  ┊ 📖 read      evidencia-catalogo.md  0.1s
  ┊ 📖 read      normas-lgpd.md  0.1s
  ┊ 📖 read      README.md  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking dataset dates**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 🔎 find      *  0.2s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking pending metadata**
└──────────────────────────────────────────────────────────────────────────────┘

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

O dataset marketing.leads_2026 não está apto para entrar no catálogo agora. A ficha ainda está como pendente_entrada e deixa sem preencher dono, finalidade, base legal e classificação; também não informa regras de qualidade nem consumidores conhecidos (base/catalogo/marketing.leads_2026.yaml, campos status, dono, finalidade, base_legal, classificacao, qualidade e linhagem.consumidores). A amostra contém dados pessoais diretos e datas de nascimento — incluindo registros com anos que podem corresponder a menores — e identifica lista_comprada como uma origem (base/dados/marketing.leads_2026.csv, cabeçalho e linhas 3, 6 e 23, por exemplo). A política da empresa classifica dados de menores como restritos (base/politicas/classificacao.md, linhas 11–12).

Há também um risco de exposição na configuração do catálogo: para classificação nula, a regra CAT-07 define visibilidade para “Todos os usuários do catálogo” (base/caso-001/regra-CAT-07.md, linhas 17–19). A ficha não mostra que o dataset já tenha sido publicado com essa configuração, portanto isso é um risco a prevenir, não evidência de exposição ocorrida. A própria regra esclarece que visibilidade no catálogo não equivale a autorização de acesso aos dados na origem (base/caso-001/regra-CAT-07.md, linhas 21–22).

Qual regra está envolvida

- A política corporativa exige classificação definida pelo responsável; ativos sem classificação válida devem permanecer pendentes até que o responsável determine o nível (base/caso-001/POL-DADOS-003.md, linhas 3–12). O mesmo documento atribui à Governança a validação da aplicação da política e diz que alterações de visibilidade seguem fluxo de aprovação (linhas 14–18).
- Na política de classificação da Aurora, dados pessoais são confidenciais; dados de menores são restritos. Ativos restritos requerem aprovação do dono e do encarregado (base/politicas/classificacao.md, linhas 7–12).
- A política de acesso exige finalidade, prazo e gestor no pedido; determina aprovação do dono e aprovação adicional do encarregado para ativos restritos, e prefere uma visão sem colunas pessoais quando suficiente (base/politicas/acesso.md, linhas 5–8`).
- Para dados pessoais, a finalidade precisa ser específica e explícita; finalidade e base legal devem ser verificadas, sem presumir qual base se aplica (skills/governanca/base-legal-e-finalidade/SKILL.md, seção “O que conferir” e “Limites desta skill”). A referência lista os arts. 5º, 6º, 7º, 11 e 14 da LGPD (skills/governanca/referencias/normas-lgpd.md, linhas 14–23).

Qual evidência sustenta

- A ficha identifica nome, CPF, e-mail, telefone, data de nascimento e cidade como colunas, além de origem (base/catalogo/marketing.leads_2026.yaml, linhas 11–19). A amostra mostra valores nessas colunas (base/dados/marketing.leads_2026.csv, cabeçalho e linhas 2–61). Não reproduzo os identificadores pessoais.
- A ficha declara origens formulario-site, planilha-eventos e fornecedor-externo, mas não descreve sua procedência ou condições de uso; a amostra inclui registros com origem lista_comprada (base/catalogo/marketing.leads_2026.yaml, linhas 21–22; base/dados/marketing.leads_2026.csv, linhas 3, 6 e 23).
- Há datas de nascimento em anos como 2010, 2011 e 2013 na amostra (base/dados/marketing.leads_2026.csv, linhas 6, 23 e 39). Isso sinaliza possível presença de menores, mas o material não documenta validação de titularidade ou faixa etária.
- O acesso indicado na ficha é [marketing], mas a finalidade e a classificação estão vazias (base/catalogo/marketing.leads_2026.yaml, linhas 5–10). Não há evidência de que esse grupo já tenha acesso efetivo ao sistema de origem.
- A solicitação descreve apenas “para campanha de fim de ano” (base/catalogo/marketing.leads_2026.yaml, linha 24), sem detalhar público, canais, critérios de seleção ou duração.
- Não há regras declaradas de qualidade nem consumidores cadastrados (base/catalogo/marketing.leads_2026.yaml, linhas 20–23).

Qual o impacto

Se o catálogo aplicar a regra CAT-07 enquanto a classificação estiver nula, a ficha poderá ficar visível a todos os usuários do catálogo (base/caso-001/regra-CAT-07.md, linhas 17–19). Isso não demonstra acesso aos dados armazenados nem que alguém os tenha consultado; a política separa visibilidade do catálogo e autorização na origem (base/caso-001/regra-CAT-07.md, linhas 21–22). Não há logs de acesso desse dataset no material fornecido, então não é possível determinar se alguém o viu ou acessou.

Se confirmada a presença de menores, a política interna exige classificação restrita, com controles e aprovações adicionais (base/politicas/classificacao.md, linhas 11–12). O uso de listas compradas também exige esclarecimento de procedência e condições de uso antes de avaliar a adequação à campanha; a ficha e a amostra apenas identificam a origem, sem documentar esses elementos (base/catalogo/marketing.leads_2026.yaml, linhas 19, 21–22; base/dados/marketing.leads_2026.csv, linhas 3, 6 e 23).

O que está faltando

- Dono formal do dataset e responsável por definir sua classificação.
- Finalidade específica da campanha, público, canais, necessidade de cada coluna e duração do uso.
- Base legal documentada e avaliação pelo encarregado/jurídico; não é possível inferi-la do material.
- Procedência, condições de obtenção e autorização de uso das origens externas e das listas compradas.
- Verificação da faixa etária e tratamento previsto para eventuais titulares menores.
- Classificação preenchida e conferência de que a regra de visibilidade não exponha a ficha enquanto ela estiver sem classificação.
- Regras de qualidade e consumidores/linhagem de saída; a ficha não os informa.
- Confirmação da política de acesso efetivo na plataforma de dados e, se necessário, logs para determinar acessos realizados.

Qual correção proponho

Antes da entrada, pedir ao responsável pelo dado que complete dono, finalidade, base legal documentada, classificação, consumidores e regras de qualidade. Solicitar comprovação da procedência e das condições de uso de cada origem, em especial lista_comprada, e esclarecer como serão identificados e tratados possíveis registros de menores.

A classificação deve ser definida pelo dono conforme o conteúdo e a política, não presumida como interna. Enquanto isso, propor que Governança verifique e corrija o comportamento de visibilidade para classificação nula, evitando publicação ampla por padrão. A ficha indica grupo marketing, mas a concessão ou confirmação de acesso efetivo deve seguir o fluxo de aprovação e necessidade de conhecer; avaliar uma visão reduzida, sem colunas pessoais, se atender à campanha (base/politicas/acesso.md, linhas 5–8). Essas são propostas para decisão humana; não fiz alterações.

Quem precisa aprovar

- Dono do dado: definir a classificação, validar finalidade e necessidade dos dados e aprovar o acesso conforme a política (base/caso-001/POL-DADOS-003.md, linhas 9–12; base/politicas/acesso.md, linhas 5–8).
- Encarregada (DPO), Marta Siqueira: avaliar tratamento novo de dados pessoais e aprovar acesso se a classificação for restrita (base/politicas/classificacao.md, linhas 25–27).
- Governança de Dados: validar aplicação da política e acompanhar os desvios; deve revisar o risco de visibilidade com classificação nula (base/caso-001/POL-DADOS-003.md, linhas 14–18).
- Comitê de Governança: aprovar eventual mudança nas regras automáticas de classificação (base/politicas/classificacao.md, linhas 14–21 e 28). Não há evidência de que seja necessária uma mudança de política para este ativo; essa decisão depende da análise do comportamento CAT-07 e do fluxo corporativo.
- Jurídico, junto ao encarregado: esclarecer a base legal e as condições de uso quando a documentação fornecida não permitir concluir; o material não permite declarar uma base aplicável.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_005242_2ed2e4

Session:        20260929_005242_2ed2e4
Duration:       1m 32s
Messages:       23 (1 user, 21 tool calls)
