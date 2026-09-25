---
name: classificar-ativo
description: Verifica se a classificação de sensibilidade de um ativo de dados (público, interno, confidencial, restrito) é coerente com o que ele contém, e se a regra que atribuiu a classificação é robusta. Use para "a classificação está certa?", "qual deveria ser a classificação", "por que isto está como interno", ou como passo 4 de avaliar-ativo.
---

# Classificar ativo

A lógica de níveis vem da ideia geral de `classification-policy`
(mukul975/privacy-data-protection-skills, Apache-2.0), reescrita para LGPD e para **conferir**
classificação existente em vez de desenhar uma política do zero.

## Níveis de referência

Use os níveis **da política da organização** quando ela existir no material. Na ausência, este é
o padrão:

| nível | quando |
|---|---|
| público | aprovado para divulgação; anonimizado de fato (ver abaixo) |
| interno | sem dado pessoal; divulgação causaria incômodo, não dano |
| confidencial | contém dado pessoal (Art. 5º, I) |
| restrito | contém dado pessoal **sensível** (Art. 5º, II), dado de menores, credenciais, ou segredo |

**Regra de piso:** o nível do ativo é o nível da coluna **mais** sensível — inclusive de uma
coluna de texto livre onde o dado sensível apareceu por digitação.

## Duas perguntas, sempre

1. **A classificação está certa para o conteúdo?** Compare com o resultado de
   `mapear-dados-pessoais`.
2. **Como ela foi atribuída — e isso vai falhar de novo?** Se a classificação depende de uma
   tag, de um campo de metadado ou de uma regra automática, identifique a dependência. Uma regra
   do tipo "se tag `contem_pii` então confidencial, senão interno" transforma **metadado
   ausente** em **classificação baixa**: o padrão do erro favorece a exposição. Isso é achado
   de causa, mais importante que o ativo individual.

Uma regra robusta falha para o lado seguro: sem informação, classifica alto e pede revisão.

## "Anonimizado" que não é

Adaptado de `lgpd-anonymization` (goul4rt/lgpd-skills, MIT). Um ativo declarado anonimizado
continua sendo dado pessoal se:

- removeram o nome mas mantiveram CPF, e-mail, telefone ou endereço;
- o CPF está em hash **sem salt** (há ~10⁹ CPFs possíveis — reversível por força bruta);
- o "pseudônimo" é um ID interno que aparece em outras tabelas ou logs;
- sobra um registro único numa combinação de quasi-identificadores (CEP + nascimento + sexo).

Pseudonimizado (Art. 13, § 4º) **continua** dado pessoal. Só anonimizado de fato sai do escopo
(Art. 12).

## Saída

```markdown
- Classificação atual: interno (fonte: catálogo, campo `classificacao`)
- Classificação coerente com o conteúdo: restrito — coluna `descricao` contém dado de saúde
- Como foi atribuída: regra R-07, depende da tag `contem_pii` (ausente neste ativo)
- Falha de causa: sim — a regra rebaixa quando falta metadado
```
