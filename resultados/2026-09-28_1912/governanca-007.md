# governanca/007 — resposta do agente

- caso: `evals/governanca/007-ativo-sem-problema.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: gemini-3.8-flash · 2026-09-28T19:12:32-03:00

## Pedido

> Faça uma avaliação de governança de `produto.catalogo_itens`.

## Resposta

Query: Faça uma avaliação de governança de `produto.catalogo_itens`.
Initializing agent...
────────────────────────────────────────

  ┊ 📚 preparing skill_view…
  ┊ 🔎 preparing search_files…
  ┊ 📚 skill     avaliar-ativo  0.3s
  ┊ 🔎 grep      catalogo_itens  0.9s
  ┊ 📖 preparing read_file…
  ┊ 🔎 preparing search_files…
  ┊ 📖 read      produto.catalogo_itens.yaml  0.1s
  ┊ 🔎 grep      catalogo_itens  0.4s
  ┊ 🔎 preparing search_files…
  ┊ 🔎 find      *  0.9s
  ┊ 📖 preparing read_file…
  ┊ 📖 read      produto.catalogo_itens.csv  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 📚 preparing skill_view…
  ┊ 📚 skill     mapear-dados-pessoais  0.5s
  ┊ 📚 skill     classificar-ativo  0.5s
  ┊ 📚 preparing skill_view…
  ┊ 📚 skill     revisar-acesso  0.3s
  ┊ 📚 skill     base-legal-e-finalidade  0.3s
  ┊ 🔎 preparing search_files…
  ┊ 🔎 grep      produto\.catalogo_itens  0.4s
  ┊ 🔎 preparing search_files…
  ┊ 🔎 grep      Q-30  0.3s
  ┊ 🔎 preparing search_files…
  ┊ 🔎 find      *  0.1s
  ┊ 📖 preparing read_file…
  ┊ 📖 read      vendas.pedidos.yaml  0.0s
  ┊ 📖 read      financeiro.relatorio_receita.yaml  0.0s
  ┊ 📖 preparing read_file…
  ┊ 📖 read      vendas.pedidos_legado.yaml  0.0s
  ┊ 🔎 preparing search_files…
  ┊ 🔎 grep      O que encontrei  1.3s
  ┊ 📖 preparing read_file…
  ┊ 📖 read      SOUL.md  0.0s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

O ativo produto.catalogo_itens está ativo, não contém dados pessoais nem consome fontes depreciadas, e sua regra de qualidade Q-30 (preco > 0) está verde e mede dados reais. Contudo, há incoerência entre a classificação declarada (interno) e o consumo externo indicado na finalidade e linhagem (exposição no site), o acesso irrestrito ao grupo todos-colaboradores expõe dados de saldo de estoque sem necessidade justificada por papel, e a suíte de qualidade é insuficiente por não validar integridade de chave (sku) nem consistência da coluna estoque.

Qual regra está envolvida

- Politica de Classificacao da Informacao (base/politicas/classificacao.md, linhas 7 a 12): define o nivel "publico" como "aprovado para divulgacao externa / qualquer pessoa" e o nivel "interno" como "uso interno, sem dado pessoal / todos-colaboradores".
- Regra automatica do catalogo R-07 (base/politicas/classificacao.md, linhas 16 e 17): "Se a ficha tem a tag contem_pii, o nivel e confidencial. Caso contrario, o nivel e interno."
- Politica de Acesso a Dados (base/politicas/acesso.md, linha 8): "Quando uma visao sem colunas pessoais atende a finalidade, ela deve ser preferida" (principio de segregacao e menor privilegio aplicavel a consumo externo e visibilidade de colunas sensiveis ao negocio).
- Base legal e finalidade (LGPD Art. 7 e Art. 11): passo pulado por nao haver presenca de dados pessoais no ativo.

Qual evidência sustenta

- base/catalogo/produto.catalogo_itens.yaml, linha 4: dono declarado como Gerencia de Produto (Igor Matos).
- base/catalogo/produto.catalogo_itens.yaml, linha 5: finalidade declarada inclui "exposicao no site e controle de estoque".
- base/catalogo/produto.catalogo_itens.yaml, linha 7: classificacao declarada como interno.
- base/catalogo/produto.catalogo_itens.yaml, linha 8: acesso atribuido a [todos-colaboradores].
- base/catalogo/produto.catalogo_itens.yaml, linhas 10 a 14: colunas sku, descricao, categoria, preco, estoque.
- base/catalogo/produto.catalogo_itens.yaml, linha 16: regra Q-30 ("preco > 0", verde, ultima execucao 2026-08-31). Nao ha regras cadastradas para sku ou estoque.
- base/catalogo/produto.catalogo_itens.yaml, linhas 18 e 19: origem [erp] e consumidores [site, painel_estoque].
- base/dados/produto.catalogo_itens.csv, linhas 2 a 51: amostra com 50 itens sem presenca de dados pessoais ou dados pessoais sensiveis; precos variando entre 16.90 e 499.90 (todos estritamente positivos); estoque com valores inteiros entre 5 e 293.

Qual o impacto

O ativo operacional contendo estoque fisico de produtos esta disponivel a toda a organizacao (todos-colaboradores) e diretamente ligado como fonte do consumidor site. Nao e possivel determinar com o material disponivel desde quando esse acesso e essa configuracao vigoram (a ficha registra execucao de qualidade em 2026-08-31, mas nao data de criacao do ativo).

O que está faltando

- Informacao sobre a arquitetura de integracao com o site: se o site consome diretamente a tabela inteira (incluindo saldo de estoque) ou se passa por camada de servico/visao restrita.
- Posicionamento da Gerencia de Produto sobre o nivel de exposicao tolerado para dados de estoque.
- Logs de acesso reais da plataforma de dados para verificar se ha acessos fora do escopo operacional.

Qual correção proponho

- Segregacao de visao para consumo externo: criar uma visao/ativo derivado (ex.: produto.catalogo_publico) contendo apenas sku, descricao, categoria e preco, classificado formalmente como "publico" para atender ao site.
- Ajuste de acesso no ativo interno: alterar o grupo de acesso de produto.catalogo_itens de [todos-colaboradores] para grupos operacionais pertinentes (ex.: produto, suprimentos, logistica, bi).
- Reforco de regras de qualidade: adicionar regras no catalogo para unicidade e nao nulidade de sku (chave primaria) e nao negatividade de estoque (estoque >= 0).

Quem precisa aprovar

- Dono do dado (Gerencia de Produto / Igor Matos): aprova o desenho da visao publica, a reducao dos grupos de acesso e o cadastro das novas regras de qualidade.
- Comitê de Governança de Dados: aprova a criacao e enquadramento da nova visao como nivel publico no catalogo corporativo.



Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260928_221240_14abc1

Session:        20260928_221240_14abc1
Duration:       2m 49s
Messages:       36 (1 user, 34 tool calls)
