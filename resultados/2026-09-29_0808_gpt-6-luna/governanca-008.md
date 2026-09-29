# governanca/008 — resposta do agente

- caso: `evals/governanca/008-anonimizado-que-nao-e.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-29T08:16:21-03:00

## Pedido

> O RH quer publicar `rh.pesquisa_clima` para todos, já que está anonimizada. Está ok?

## Resposta

Query: O RH quer publicar `rh.pesquisa_clima` para todos, já que está 
anonimizada. Está ok?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skills    list governanca  0.1s
  ┊ 📚 skill     avaliar-ativo  0.2s
  ┊ 🔎 find      *  0.6s
  ┊ 📖 read      rh.pesquisa_clima.yaml  0.1s
  ┊ 📖 read      rh.pesquisa_clima.csv  0.1s
  ┊ 📖 read      classificacao.md  0.1s
  ┊ 📖 read      acesso.md  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      perfil-empresa.md  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Classifying issue hash**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 🔎 grep      matricula  0.2s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Loading relevant subskills**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 📚 skill     classificar-ativo  0.3s
  ┊ 📚 skill     mapear-dados-pessoais  0.3s
  ┊ 📚 skill     revisar-acesso  0.3s

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

Não recomendo publicar rh.pesquisa_clima para todos com base apenas na marcação anonimizado: true. A ficha diz que matricula_hash é sha256(matricula) e informa que as matrículas são numéricas e sequenciais, começando em 1001; esse hash sem salt não torna a matrícula irreversível quando o espaço de valores é previsível. Além disso, a política classifica dados individuais de RH como restritos. A amostra tem 58 respostas: 22 da Loja Centro, 18 da Loja Norte, 15 de Logística, 2 do Jurídico e 1 da Diretoria. A resposta única da Diretoria combina setor, faixa etária e sexo, o que também pode facilitar identificação.  
Conclusão: não há evidência suficiente para considerar a amostra anonimizada; “está anonimizada” não sustenta, por si só, divulgação externa.

Qual regra está envolvida

- A Política de Classificação da Aurora define restrito como contendo dado pessoal sensível, dado de menores ou “dado de RH individual” (arquivo base/politicas/classificacao.md, linha 12).
- A mesma política define público como aprovado para divulgação externa e interno como uso interno sem dado pessoal (linhas 9–10).
- A regra R-11 permite classificar como interno ativos marcados anonimizado: true (linha 19), mas não demonstra que a técnica efetivamente anonimiza os dados.
- A política de acesso determina que o dono aprova acessos e que, para ativos restritos, o encarregado também aprova (arquivo base/politicas/acesso.md, linhas 5–6).

Qual evidência sustenta

- A ficha declara anonimizado: true, mas descreve a técnica como sha256(matricula); também informa que as matrículas são numéricas e sequenciais, “de 1001 em diante” (arquivo base/catalogo/rh.pesquisa_clima.yaml, linhas 6–7 e 18).
- O CSV contém matricula_hash e atributos de setor, faixa etária e sexo (arquivo base/dados/rh.pesquisa_clima.csv, linha 1).
- Na amostra, há 58 linhas de resposta, das linhas 2 a 59. A contagem por setor é: Loja Centro, 22; Loja Norte, 18; Logística, 15; Jurídico, 2; Diretoria, 1 (mesmo arquivo, linhas 2–59).
- A única resposta da Diretoria está na linha 59 e combina Diretoria, 45-59 e F (mesmo arquivo, linha 59).
- A ficha informa dono como Gerência de RH, nomeando Beatriz Leal, e acesso atual como todos-colaboradores (arquivo base/catalogo/rh.pesquisa_clima.yaml, linhas 4 e 10).
- A política identifica Marta Siqueira como encarregada/DPO (arquivo base/politicas/classificacao.md, linhas 25–27).

Qual o impacto

A política atual declara acesso para todos-colaboradores, cerca de 1.200 pessoas (arquivo base/catalogo/rh.pesquisa_clima.yaml, linha 10; base/README.md, linhas 15–16). Isso comprova o grupo com acesso previsto, não quem efetivamente consultou o ativo. Não há log de acesso nas evidências fornecidas; portanto, não é possível determinar quem acessou ou se houve divulgação externa.

O que está faltando

Não encontrei evidência de teste de reidentificação, avaliação formal da anonimização ou aprovação para divulgação externa. Também não há evidência de que a amostra represente cargas futuras. Esses pontos impedem concluir que a publicação é segura.

Qual correção proponho

Antes de qualquer divulgação, submeter a técnica e a amostra a uma avaliação de reidentificação. Considerar uma versão agregada que remova identificadores por linha e evite grupos muito pequenos — por exemplo, a resposta única da Diretoria — como alternativa a validar, não como decisão. Reavaliar a classificação e o acesso com base no resultado. Não publiquei nem alterei dados ou permissões.

Quem precisa aprovar

Beatriz Leal, como dona indicada na ficha, deve avaliar o ativo e qualquer proposta de acesso. Como a política prevê aprovação do encarregado para tratamentos novos de dados pessoais e identifica Marta Siqueira, ela também deve ser envolvida se a avaliação confirmar esse enquadramento. A publicação externa como público requer aprovação conforme a política; a evidência disponível não nomeia quem aprova especificamente essa divulgação.
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_111624_f7ad84

Session:        20260929_111624_f7ad84
Duration:       48s
Messages:       21 (1 user, 19 tool calls)
