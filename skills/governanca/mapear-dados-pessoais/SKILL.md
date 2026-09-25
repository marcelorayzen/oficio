---
name: mapear-dados-pessoais
description: Identifica dados pessoais e dados pessoais sensíveis (LGPD Art. 5º) num ativo de dados — pelas colunas declaradas E pelo conteúdo real, incluindo texto livre. Use para "tem dado pessoal aqui?", "quais colunas são PII", "mapear dados pessoais do dataset", ou como passo 3 de avaliar-ativo.
---

# Mapear dados pessoais

Adaptado de `lgpd-data-mapping` (goul4rt/lgpd-skills, MIT — ver `fontes/`). A original mapeia
**código-fonte** (schema Prisma, endpoints, SDKs); esta mapeia **ativos de dados** (colunas,
amostras, texto livre).

## A armadilha principal

**O nome da coluna não diz o que está nela.** Uma coluna `descricao`, `observacao`, `comentario`
ou `payload` pode conter CPF, telefone, diagnóstico médico — digitado por quem preencheu. Mapear só
pelos nomes declarados no catálogo é o erro mais comum, e é exatamente o que faz um ativo com dado
sensível ser classificado como interno.

Por isso, sempre que houver amostra dos dados, **olhe o conteúdo**, não só o esquema.

## O que procurar

**Dado pessoal** (Art. 5º, I) — identifica ou torna identificável:
nome, CPF, RG, e-mail, telefone, endereço, CEP completo, data de nascimento, placa, IP, ID de
dispositivo, matrícula, número de cliente ligado a pessoa.

**Dado pessoal sensível** (Art. 5º, II) — lista fechada da lei:
origem racial ou étnica · convicção religiosa · opinião política · filiação a sindicato ou a
organização religiosa, filosófica ou política · **saúde** · vida sexual · genético · biométrico.

**Atenção a combinações:** CEP + data de nascimento + sexo juntos podem identificar alguém mesmo
sem nome. Registre quasi-identificadores como tal.

**Titulares especiais:** crianças e adolescentes (Art. 14) — marque se a data de nascimento ou o
contexto indicar menores.

## Como verificar conteúdo de texto livre

Para cada coluna de texto livre com amostra disponível, procure padrões e conte ocorrências:

| padrão | forma típica |
|---|---|
| CPF | `\d{3}\.?\d{3}\.?\d{3}-?\d{2}` |
| e-mail | `[\w.+-]+@[\w-]+\.[\w.]+` |
| telefone | `\(?\d{2}\)?\s?9?\d{4}-?\d{4}` |
| saúde | termos como diagnóstico, CID, laudo, atestado, remédio, internação, gestante |

Relate **quantas linhas da amostra** contêm cada padrão, com 1–2 exemplos **mascarados**
(`123.***.***-45`). Nunca reproduza o dado inteiro no relatório.

## Saída

```markdown
| coluna | declarado no catálogo | encontrado no conteúdo | tipo | evidência |
|---|---|---|---|---|
| nome_cliente | pessoal | pessoal | direto | ficha + amostra |
| descricao | (nada) | CPF em 3/40 linhas; saúde em 2/40 | **sensível** | amostra linhas 7, 19 |
```

E uma linha de conclusão: *contém dado pessoal? sensível? menores? — sim/não/não verificável*.
"Não verificável" quando não há amostra de uma coluna de texto livre — nunca "não".
