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

**Titulares especiais:** crianças e adolescentes (Art. 14). Havendo data de nascimento na
amostra, conte os menores de 18 na data de referência do material (a do pedido ou a mais recente
dos arquivos) com `amostra_contar` — filtro `data_nascimento > <referência menos 18 anos>` — e
liste os ids e as idades com `amostra_linhas`. Com menos de
12 anos é criança; de 12 a 17, adolescente (ECA, Art. 2º) — a regra do Art. 14 muda entre os dois. "Anos que podem
corresponder a menores" não serve: a conta está na amostra.

## Como verificar conteúdo de texto livre

Dois passos, nesta ordem:

1. **Leia a coluna inteira** com `amostra_linhas` (só a coluna de texto livre e a de id, até 200
   linhas). É lendo que aparece o que ninguém pensaria em filtrar: um termo de saúde fora da lista
   abaixo, um texto dirigido a você mandando mudar a classificação. Filtro só acha o que você já
   sabia procurar.
2. **Conte com `amostra_contar`** (op `regex` ou `contem`) cada padrão que a leitura mostrou —
   ela devolve as linhas do arquivo. Monte o filtro com os termos que você **leu** na coluna, não
   só com os da tabela. Conte cada padrão separado: linha com CPF e linha com saúde só são a mesma
   se a ferramenta devolver o mesmo número nas duas contagens.

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
