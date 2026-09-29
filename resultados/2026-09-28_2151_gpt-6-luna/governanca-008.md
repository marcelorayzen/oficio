# governanca/008 — resposta do agente

- caso: `evals/governanca/008-anonimizado-que-nao-e.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-28T21:59:31-03:00

## Pedido

> O RH quer publicar `rh.pesquisa_clima` para todos, já que está anonimizada. Está ok?

## Resposta

Query: O RH quer publicar `rh.pesquisa_clima` para todos, já que está 
anonimizada. Está ok?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 🔎 find      *pesquisa_clima*  0.2s
  ┊ 📚 skill     mapear-dados-pessoais  0.2s
  ┊ 📖 read      rh.pesquisa_clima.yaml  0.0s
  ┊ 📖 read      rh.pesquisa_clima.csv  0.0s
  ┊ 🔎 find      *  0.3s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 🔎 grep      R-11  0.3s
  ┊ 📚 skill     classificar-ativo  0.2s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

Não há evidência suficiente para considerar rh.pesquisa_clima efetivamente anonimizada ou aprovar sua divulgação pública. A ficha diz que a matrícula foi substituída por sha256(matricula), mas também informa que as matrículas são numéricas e sequenciais a partir de 1001. Isso torna plausível testar valores de matrícula e comparar seus hashes com os do arquivo. Além disso, a amostra contém setor, faixa etária, sexo e respostas individuais — combinação que pode facilitar reconhecer pessoas, especialmente em grupos pequenos. Não recomendo tratar a declaração anonimizado: true como prova de anonimização.

Qual regra está envolvida

A política define “público” como aprovado para divulgação externa e “interno” como uso interno sem dado pessoal (base/politicas/classificacao.md, linhas 7–12). A regra R-11 permite classificar ativos marcados como anonimizados como internos, mas não declara que essa marcação comprove anonimização nem autoriza publicação externa (base/politicas/classificacao.md, linhas 14–21). A regra de acesso permite todos-colaboradores para interno; isso não equivale a acesso público externo (base/politicas/classificacao.md, linhas 7–12; base/catalogo/rh.pesquisa_clima.yaml, linha 10).

Qual evidência sustenta

- A ficha declara anonimizado: true e descreve a técnica como sha256(matricula) (base/catalogo/rh.pesquisa_clima.yaml, linhas 6–7).
- A mesma ficha informa que as matrículas são numéricas e sequenciais, a partir de 1001 (base/catalogo/rh.pesquisa_clima.yaml, linha 18). A amostra apresenta hashes individuais (base/dados/rh.pesquisa_clima.csv, coluna matricula_hash, linhas 2–59). Isso sustenta uma hipótese de possibilidade de associação por tentativa de hashes, mas não prova que a associação foi realizada.
- A amostra contém respostas por linha, com setor, faixa etária, sexo e notas (base/dados/rh.pesquisa_clima.csv, cabeçalho e linhas 2–59). Há, por exemplo, registros dos setores Diretoria e Jurídico nas linhas 59 e 57–58, respectivamente; o material não informa o tamanho real desses grupos.
- A classificação atual está como interno, atribuída pela R-11, e o acesso cadastrado é todos-colaboradores (base/catalogo/rh.pesquisa_clima.yaml, linhas 9–10). A política reserva público para divulgação externa aprovada (base/politicas/classificacao.md, linha 9).
- Não encontrei, nos materiais consultados, aprovação para divulgação externa, avaliação documentada de risco de reidentificação ou evidência de que os hashes não possam ser associados às matrículas.

Qual o impacto

A publicação poderia expor respostas individuais de uma pesquisa de RH ou permitir associação a colaboradores, caso os hashes sejam testáveis e as combinações de atributos identifiquem pessoas. Isso é risco potencial, não evidência de reidentificação já ocorrida. O material disponível não permite determinar quem seria identificável nem o impacto concreto.

O que está faltando

- Evidência técnica de avaliação de reidentificação, incluindo teste do espaço de matrículas sequenciais contra os hashes.
- Tamanho dos grupos e avaliação de combinações raras de setor, faixa etária e sexo.
- Escopo exato de “publicar para todos” — colaboradores da empresa ou público externo.
- Aprovação formal de divulgação pública e avaliação do dono do dado, da Segurança e, se houver tratamento de dado pessoal, do encarregado.
- Política ou regra que estabeleça critérios para declarar anonimização suficiente para divulgação externa.

Qual correção proponho

Antes de qualquer publicação, manter o ativo fora do escopo público e solicitar avaliação humana da técnica de anonimização e do risco de reidentificação. Se a divulgação for necessária, considerar uma saída agregada, com supressão ou agrupamento de células pequenas e sem identificador por linha; validar a utilidade e o risco antes de aprovar. Isso é uma proposta, não uma alteração executada.

Quem precisa aprovar

- Dono do dado — Gerência de RH, identificada na ficha (base/catalogo/rh.pesquisa_clima.yaml, linha 4): finalidade e eventual divulgação.
- Segurança — avaliação técnica do risco de associação dos hashes às matrículas.
- Encarregado/DPO — avaliação do tratamento e da exposição caso permaneça risco de identificação; a política o identifica como aprovador de tratamentos novos de dado pessoal (base/politicas/classificacao.md, linhas 25–27).
- Comitê de Governança — se for necessário alterar a política ou as regras automáticas (base/politicas/classificacao.md, linha 28).

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_005934_9b7943

Session:        20260929_005934_9b7943
Duration:       44s
Messages:       19 (1 user, 17 tool calls)
