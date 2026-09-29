# Aurora Varejo — ambiente de governança (fictício)

Empresa de varejo **fictícia**. Nenhum dado aqui é real.

**Leia este mapa antes de procurar.** Se um arquivo que você espera não está listado aqui, ele não
existe; se está, abra pelo caminho — não dependa de busca por palavra.

| caminho | conteúdo |
|---|---|
| `catalogo/<ativo>.yaml` | ficha de cada ativo: dono, finalidade, base legal, classificação, tags, acesso, colunas, qualidade, linhagem |
| `dados/<ativo>.csv` | amostra de cada ativo — conte e resuma com as ferramentas `amostra_*`, não lendo |
| `politicas/classificacao.md` | níveis, regras automáticas de classificação e quem aprova (encarregada, comitê) |
| `politicas/acesso.md` | como se pede, aprova e revisa acesso; onde ficam os logs |
| `politicas/ciclo-de-vida.md` | depreciação, migração e linhagem |
| `pedidos-acesso/PA-*.md` | pedidos de acesso aguardando avaliação |
| `contexto/*.md` | o que as áreas de negócio relatam (campanhas, reclamações) |
| `qa/perfil-empresa.md` | stack, ferramentas, CI, formatos e escala de severidade do time |
| `qa/api/pedidos-openapi.yaml` | contrato da API de pedidos |
| `qa/historias/HU-*.md` | histórias de usuário do backlog |
| `qa/evidencias/*.md` | material recebido sobre um possível defeito: print descrito, log, relato |
| `caso-001/` | **outra** empresa fictícia, só para o caso 001. Suas regras e fichas **não** valem para a Aurora |

Ativos com ficha e amostra: `atendimento.chamados`, `clientes.cadastro`, `logistica.entregas`,
`marketing.leads_2026`, `produto.catalogo_itens`, `rh.pesquisa_clima`, `vendas.pedidos`,
`vendas.pedidos_legado`.
`financeiro.relatorio_receita` tem ficha e não tem amostra.

Grupos de acesso existentes: `todos-colaboradores` (~1.200 pessoas), `atendimento` (40),
`crm` (8), `marketing` (15), `financeiro` (12), `rh` (6), `bi` (10), `logistica` (25).
