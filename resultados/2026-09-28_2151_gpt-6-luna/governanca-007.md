# governanca/007 — resposta do agente

- caso: `evals/governanca/007-ativo-sem-problema.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-28T21:58:28-03:00

## Pedido

> Faça uma avaliação de governança de `produto.catalogo_itens`.

## Resposta

Query: Faça uma avaliação de governança de `produto.catalogo_itens`.
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     governanca:avaliar-ativo  0.2s
  ┊ 📚 skill     governanca:mapear-dados-pessoais  0.5s
  ┊ 📚 skill     governanca:classificar-ativo  0.5s
  ┊ 📚 skill     governanca:base-legal-e-finalidade  0.6s
  ┊ 📚 skill     governanca:revisar-acesso  0.6s
  ┊ 🔎 find      *  0.9s
  ┊ 🔎 grep      catalogo_itens|produto  0.6s
  ┊ 📖 read      produto.catalogo_itens.yaml  0.1s
  ┊ 📖 read      produto.catalogo_itens.csv  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      README.md  0.2s
  ┊ 📖 read      normas-lgpd.md  0.2s
  ┊ 📖 read      ciclo-de-vida.md  0.2s
  ┊ 🔎 grep      catalogo_itens|produto  0.4s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

O material mostra um catálogo de itens com campos de produto, dono, finalidade e linhagem declarados. A amostra disponível não contém dados pessoais identificáveis. Não há evidência suficiente, porém, para confirmar a classificação interno, a qualidade dos dados ou se a linhagem descrita reflete o uso real: faltam evidências sobre conteúdo completo, regra de classificação aplicada e execução das verificações.

Qual regra está envolvida

- A política define interno como uso interno sem dado pessoal e permite todos-colaboradores para esse nível; ativos com dados pessoais são confidencial ou restrito conforme o tipo de dado ( base/politicas/classificacao.md, linhas 7–12).
- A regra automática R-07 classifica como interno quando não há a tag contem_pii; a política informa que as tags são preenchidas pelo dono ( base/politicas/classificacao.md, linhas 14–21). A ficha tem apenas a tag produto, sem declarar o resultado de uma análise de dados pessoais ( base/catalogo/produto.catalogo_itens.yaml, linhas 6–7).
- A política de acesso prevê aprovação pelo dono e, para ativos restritos, também pelo encarregado; prevê revisão semestral e prazo máximo de 12 meses ( base/politicas/acesso.md, linhas 5–10).
- Para dados pessoais, a LGPD define dado pessoal e sensível e os princípios de finalidade, necessidade, qualidade e segurança ( skills/governanca/referencias/normas-lgpd.md, linhas 14–20).

Qual evidência sustenta

- A ficha identifica o ativo como produto.catalogo_itens, no schema produto, com dono Gerência de Produto (Igor Matos) e finalidade de precificação, exposição no site e controle de estoque ( base/catalogo/produto.catalogo_itens.yaml, linhas 1–5).
- A ficha declara classificação interno, acesso todos-colaboradores e colunas sku, descricao, categoria, preco e estoque ( base/catalogo/produto.catalogo_itens.yaml, linhas 7–14).
- A amostra CSV contém 50 itens, com SKU, descrições genéricas “Item 1” a “Item 50”, categorias, preços e estoques; não há nomes, contatos ou outros identificadores pessoais visíveis nessa amostra ( base/dados/produto.catalogo_itens.csv, linhas 1–51). Isso não comprova que o conteúdo integral seja igual à amostra.
- A única regra de qualidade declarada é preco > 0, com status verde e última execução informada em 2026-08-31 ( base/catalogo/produto.catalogo_itens.yaml, linhas 15–16). A amostra visível contém preços positivos, mas não há evidência de execução independente, cobertura integral ou de regras para SKU, categoria e estoque.
- A linhagem declarada é origem erp e consumidores site e painel_estoque ( base/catalogo/produto.catalogo_itens.yaml, linhas 17–19). Não há no material consultado confirmação independente da origem ou dos consumidores efetivos.
- A pasta de dados é descrita como contendo amostras dos ativos, não necessariamente a totalidade ( base/README.md, linhas 5–9).

Qual o impacto

A permissão declarada alcança todos-colaboradores; a política da empresa descreve esse grupo como aproximadamente 1.200 pessoas ( base/catalogo/produto.catalogo_itens.yaml, linha 8; base/README.md, linhas 15–16). Se a classificação interno estiver correta, esse acesso é compatível com a política. Se houver dado pessoal não mapeado no ativo completo, a classificação e o alcance de acesso podem não ser adequados; isso é uma hipótese a verificar, não algo comprovado pela amostra. Não há logs disponíveis para determinar quem acessou o ativo.

O que está faltando

- Confirmação de que a amostra representa todas as colunas e formatos do ativo em produção, especialmente o conteúdo real de descricao.
- Evidência da análise de dados pessoais e do processo/regra que atribuiu interno; a ficha não declara contem_pii nem contem_sensivel.
- Resultado detalhado e cobertura da execução de Q-30; critérios de qualidade para as demais colunas.
- Confirmação da linhagem efetiva e de eventuais consumidores além dos declarados.
- Logs de acesso, caso seja necessário determinar acessos realizados. A política diz que esses logs ficam na plataforma de dados e são consultados pela Segurança sob demanda ( base/politicas/acesso.md, linhas 9–10).

Qual correção proponho

Como proposta para avaliação humana, confirmar com o dono se a amostra é representativa e documentar a análise do conteúdo completo. Revisar a regra de classificação para que ausência de tag de dado pessoal não rebaixe automaticamente o ativo sem validação; a política atual define R-07 dessa forma ( base/politicas/classificacao.md, linhas 14–21). Se a análise confirmar a ausência de dados pessoais, registrar a evidência que sustenta interno; se encontrar dados pessoais, reavaliar classificação e acesso conforme a política. Complementar as evidências de qualidade e linhagem sem alterar o ativo nesta avaliação.

Quem precisa aprovar

- Dono do dado (Gerência de Produto / Igor Matos): confirmar finalidade, representatividade da amostra e linhagem; aprovar eventual acesso, conforme política ( base/catalogo/produto.catalogo_itens.yaml, linha 4; base/politicas/classificacao.md, linha 25).
- Comitê de Governança de Dados: aprovar qualquer mudança na política ou nas regras automáticas de classificação ( base/politicas/classificacao.md, linha 28).
- Encarregado (DPO): envolver se a análise identificar dado pessoal ou tratamento novo; a política atribui ao encarregado aprovação de tratamentos novos de dado pessoal e acesso a ativos restritos ( base/politicas/classificacao.md, linhas 26–27).

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_005831_fe5242

Session:        20260929_005831_fe5242
Duration:       58s
Messages:       20 (1 user, 18 tool calls)
