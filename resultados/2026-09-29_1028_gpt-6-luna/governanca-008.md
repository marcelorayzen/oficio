# governanca/008 — resposta do agente

- caso: `evals/governanca/008-anonimizado-que-nao-e.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T10:40:15-03:00

## Pedido

> O RH quer publicar `rh.pesquisa_clima` para todos, já que está anonimizada. Está ok?

## Resposta

Query: O RH quer publicar `rh.pesquisa_clima` para todos, já que está 
anonimizada. Está ok?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 📖 read      README.md  0.0s
  ┊ 📚 skill     mapear-dados-pessoais  1.0s
  ┊ 📚 skill     classificar-ativo  1.0s
  ┊ 📚 skill     base-legal-e-finalidade  0.8s
  ┊ 📚 skill     revisar-acesso  0.4s
  ┊ 📖 read      rh.pesquisa_clima.yaml  0.2s
  ┊ 📖 read      classificacao.md  0.2s
  ┊ 📖 read      acesso.md  0.2s
  ┊ 📖 read      ciclo-de-vida.md  0.2s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking sample schemas**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ ⚡ tool_desc   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s
  ┊ ⚡ mcp__amos   0.0s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking sample group uniqueness**
└──────────────────────────────────────────────────────────────────────────────┘

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei
Não recomendo publicar rh.pesquisa_clima para todos com base na alegação de anonimização. A ficha diz que matricula foi substituída por sha256(matricula), mas informa que as matrículas são numéricas e sequenciais a partir de 1001 — um hash sem salt pode ser testado contra esse espaço previsível. Além disso, a amostra tem combinações de setor, faixa etária e sexo que aparecem uma única vez, o que aumenta o risco de identificação. O conteúdo, portanto, não está demonstrado como efetivamente anonimizado. Isso não prova que alguém foi identificado ou acessou os dados.

Qual regra está envolvida
- A política da Aurora define como público o ativo aprovado para divulgação externa; interno é para uso interno sem dado pessoal; e restrito inclui dado de RH individual ( base/politicas/classificacao.md, linhas 9–12).
- A mesma política permite classificar como interno ativos marcados anonimizado: true pela regra R-11, mas não declara que essa marca, por si só, comprove anonimização (base/politicas/classificacao.md, linhas 19–21).
- A regra de classificação orienta que hash de CPF sem salt pode ser revertido por força bruta e que pseudonimização continua sendo dado pessoal (base/politicas/classificacao.md, linhas 16–20; referência operacional em avaliar-ativo, skill classificar-ativo, seção “Anonimizado” que não é).
- A política prevê acesso de todos-colaboradores para ativos internos, mas acesso público significa qualquer pessoa (base/politicas/classificacao.md, linhas 9–12).

Qual evidência sustenta
- A ficha declara a finalidade como medir clima organizacional por setor, marca o ativo como anonimizado e registra sha256(matricula) como técnica. Também informa que as matrículas são sequenciais a partir de 1001 (base/catalogo/rh.pesquisa_clima.yaml, linhas 5–7 e 18).
- A ficha declara classificação interno, atribuída pela R-11, e acesso a todos-colaboradores (base/catalogo/rh.pesquisa_clima.yaml, linhas 9–10).
- As colunas incluem matricula_hash, setor, faixa_etaria e sexo (base/catalogo/rh.pesquisa_clima.yaml, linhas 11–17). A ferramenta de amostra confirma essas colunas e informa 58 registros (base/dados/rh.pesquisa_clima.csv, metadados devolvidos por amostra_colunas).
- A contagem agrupada pela ferramenta encontrou combinações de setor, faixa etária e sexo com apenas um registro, incluindo Diretoria / 45–59 / M e Jurídico / 18–29 / F (base/dados/rh.pesquisa_clima.csv, resultado de amostra_contar, linhas de arquivo 2–59). Não reproduzo os valores de hash da amostra.

Qual o impacto
A classificação atual e o acesso registrado permitem visibilidade aos colaboradores, não divulgação externa. Publicar “para todos” ampliaria o público para qualquer pessoa se significar acesso público, conforme a política (base/politicas/classificacao.md, linhas 9–12). A amostra sustenta risco de reidentificação; não há evidência no material de que alguém tenha sido identificado ou acessado o ativo.

O que está faltando
- Evidência técnica de que a transformação remove a possibilidade razoável de associação dos hashes às matrículas, considerando a sequência descrita na ficha.
- Confirmação do público pretendido por “todos”: todos os colaboradores ou qualquer pessoa.
- Aprovação explícita para divulgação externa; a ficha e os arquivos consultados não a registram.

Qual correção proponho
Não publicar a tabela identificável como pública com base apenas no campo anonimizado: true. Propor ao dono do dado e ao encarregado uma revisão da técnica e do risco de reidentificação; considerar uma visão agregada que suprima grupos pequenos, se atender à finalidade. A classificação e a política só devem ser alteradas após validação e aprovação humana.

Quem precisa aprovar
- Beatriz Leal, dona indicada na ficha, e Marta Siqueira, encarregada, para avaliar o tratamento e eventual divulgação de dados pessoais; a política exige aprovação do dono e do encarregado para ativos restritos (base/catalogo/rh.pesquisa_clima.yaml, linha 4; base/politicas/classificacao.md, linhas 12 e 26–27).
- Comitê de Governança de Dados, se a proposta exigir mudar a política ou suas regras automáticas (base/politicas/classificacao.md, linha 28).

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_134018_ac3590

Session:        20260929_134018_ac3590
Duration:       47s
Messages:       21 (1 user, 19 tool calls)
