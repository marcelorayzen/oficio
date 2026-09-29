# governanca/005 — resposta do agente

- caso: `evals/governanca/005-linhagem-tabela-depreciada.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-28T21:55:52-03:00

## Pedido

> A diretoria achou a receita de 2026 estranha no `financeiro.relatorio_receita`. Pode investigar se existe algum problema de governança de dados por trás, e dizer o impacto e o que precisa ser feito?

## Resposta

Query: A diretoria achou a receita de 2026 estranha no 
`financeiro.relatorio_receita`. Pode investigar se existe algum problema de 
governança de dados por trás, e dizer o impacto e o que precisa ser feito?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 📚 skill     mapear-dados-pessoais  0.2s
  ┊ 📚 skill     classificar-ativo  0.2s
  ┊ 📚 skill     base-legal-e-finalidade  0.2s
  ┊ 📚 skill     revisar-acesso  0.1s
  ┊ 🔎 find      *  0.6s
  ┊ 📖 read      alerta.md  0.1s
  ┊ 📖 read      evidencia-catalogo.md  0.1s
  ┊ 📖 read      ficha-CAT-004821.md  0.1s
  ┊ 📖 read      POL-DADOS-003.md  0.1s
  ┊ 📖 read      regra-CAT-07.md  0.1s
  ┊ 📖 read      financeiro.relatorio_receita.yaml  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      ciclo-de-vida.md  0.1s
  ┊ 📖 read      vendas.pedidos_legado.csv  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Searching finance contents**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 🔎 grep      financeiro.relatorio_receita|2026|receita  1.0s
  ┊ 📖 read      vendas.pedidos.yaml  0.0s
  ┊ 📖 read      vendas.pedidos_legado.yaml  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking report data dates**
└──────────────────────────────────────────────────────────────────────────────┘

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

Há um problema de governança plausivelmente relacionado à receita “estranha”: financeiro.relatorio_receita declara como origem vendas.pedidos_legado, ativo depreciado em 01/03/2026 e sem cargas novas desde janeiro de 2025. A ficha também mostra que a linhagem do relatório não foi atualizada para a fonte substituta, vendas.pedidos. Isso pode deixar a receita de 2026 incompleta ou desatualizada. O material confirma a inconsistência de linhagem, mas não contém os valores do relatório nem evidência suficiente para afirmar que essa é a causa da diferença observada.

Qual regra está envolvida

- A política de ciclo de vida determina que a linhagem reflita a fonte efetivamente utilizada, que dependências de ativos depreciados tenham plano de migração registrado e que consumidores conhecidos sejam alertados quando uma fonte é depreciada (base/politicas/ciclo-de-vida.md, itens 3–5).
- A mesma política determina que ativos depreciados não recebam novos consumidores (base/politicas/ciclo-de-vida.md, item 1).
- A política de classificação define confidencial para ativos com dados pessoais e prevê acesso por grupos com necessidade de conhecer, aprovados pelo dono (base/politicas/classificacao.md, linhas 10–12).

Qual evidência sustenta

- O relatório lista vendas.pedidos_legado como origem e apresentacao_diretoria como consumidor (base/catalogo/financeiro.relatorio_receita.yaml, linhas 12–14).
- A ficha do legado registra que ele foi depreciado em 01/03/2026, substituído por vendas.pedidos e não recebe cargas novas desde janeiro de 2025; ainda lista relatorio_receita como consumidor (base/catalogo/vendas.pedidos_legado.yaml, linhas 5–7 e 20–22).
- A fonte substituta contém dados de pedidos a partir de 2025 e também lista relatorio_receita entre os consumidores (base/catalogo/vendas.pedidos.yaml, linhas 1–2 e 20–22).
- O relatório declara atualização em 31/08/2026, mas sua linhagem aponta para a fonte sem cargas novas desde janeiro de 2025 (base/catalogo/financeiro.relatorio_receita.yaml, linha 15; base/catalogo/vendas.pedidos_legado.yaml, linha 7). Isso evidencia uma divergência de metadados; não prova quando ou como os dados do relatório foram atualizados.
- A ficha da fonte substituta declara colunas pessoais — nome e e-mail do cliente — e classificação confidencial (base/catalogo/vendas.pedidos.yaml, linhas 8 e 13–16). Como o relatório declara apenas mês e receita, não há evidência no catálogo de que ele exponha esses identificadores; a transformação e a agregação precisam ser verificadas.
- A amostra disponível da fonte substituta contém registros datados de 2026 (base/dados/vendas.pedidos.csv, por exemplo, linhas 3–4). A amostra do legado contém datas de 2023 e 2024 (base/dados/vendas.pedidos_legado.csv, linhas 2–5). Amostras não demonstram o conteúdo efetivamente usado para gerar o relatório.

Qual o impacto

- Impacto potencial na receita reportada: se o relatório depender apenas do legado, pode não refletir pedidos de 2025–2026. A existência de dados de 2026 na fonte substituta e a ausência de novas cargas no legado sustentam essa hipótese, mas não permitem quantificar o efeito nem confirmar que houve omissão no relatório.
- Impacto na decisão executiva: a diretoria pode estar usando números incompletos ou desatualizados, caso a hipótese de dependência exclusiva do legado se confirme.
- Impacto de privacidade: não é possível determinar se o relatório contém ou permite reidentificar dados de clientes sem ver os dados produzidos e a transformação aplicada. O catálogo registra acesso financeiro e bi para o relatório (base/catalogo/financeiro.relatorio_receita.yaml, linhas 7–8); isso, por si só, não comprova acesso indevido nem exposição de dados pessoais nesse relatório.

O que está faltando

- Dados do relatório por mês, período coberto e critério de cálculo, para comparar com as fontes.
- SQL, job ou outra especificação da transformação, além dos logs de execução e da linhagem observada em produção.
- Confirmação de que relatorio_receita e financeiro.relatorio_receita são o mesmo ativo: o relatório usa o primeiro nome como consumidor, enquanto a ficha do catálogo usa o segundo (base/catalogo/vendas.pedidos.yaml, linha 22; base/catalogo/financeiro.relatorio_receita.yaml, linha 1).
- Plano de migração registrado e evidência de alertas aos consumidores, exigidos pela política de ciclo de vida.
- Evidência sobre quais campos chegam ao relatório final e se a agregação impede identificação de clientes.

Qual correção proponho

1. Pedir ao dono do relatório e à equipe de BI que rastreiem a execução e confirmem a fonte efetivamente consultada, comparando cobertura, período e totais com vendas.pedidos.
2. Se confirmado que o legado alimenta a receita de 2026, propor a migração do relatório para a fonte substituta e a reconciliação dos valores antes de republicar ou reapresentar números. Não sobrescrever ou corrigir dados sem aprovação do responsável.
3. Atualizar a linhagem e os consumidores no catálogo para refletir o fluxo real; registrar o plano de migração e tratar o consumidor do legado conforme a política de depreciação.
4. Verificar a transformação e o resultado do relatório para confirmar que somente os dados necessários à finalidade chegam aos consumidores. Se houver dados pessoais no resultado, reavaliar classificação e acesso com o dono do dado.

Quem precisa aprovar

- Dono do dado/relatório (Controladoria, indicado como Paulo Viana): confirmar a finalidade e aprovar mudanças no relatório e a validação dos números (base/catalogo/financeiro.relatorio_receita.yaml, linhas 4–5).
- Dono da fonte (Gerência de E-commerce, indicada como Clara Nunes): validar a fonte substituta e apoiar a reconciliação (base/catalogo/vendas.pedidos.yaml, linha 4).
- Governança de Dados: validar a correção da linhagem e o cumprimento da política de ciclo de vida.
- Encarregado/DPO e Segurança: envolver se a inspeção confirmar dados pessoais no relatório ou exposição incompatível com a classificação; não há evidência suficiente, neste material, para concluir que isso ocorreu.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para os aprovadores, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_005555_b8f78f

Session:        20260929_005555_b8f78f
Duration:       1m 17s
Messages:       34 (1 user, 32 tool calls)
