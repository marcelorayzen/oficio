---
name: base-legal-e-finalidade
description: Confere se um ativo com dados pessoais tem finalidade declarada e base legal (LGPD Art. 7º ou Art. 11) coerentes com o uso observado. Use para "qual a base legal disto", "a finalidade está declarada?", "podemos usar estes dados para X", ou como passo 5 de avaliar-ativo.
---

# Base legal e finalidade

Adaptado de `lgpd-legal-basis` (goul4rt/lgpd-skills, MIT — ver `fontes/`). A original **escolhe**
base legal ao desenhar uma funcionalidade nova; esta **confere** a base declarada de um ativo que
já existe.

## O que conferir

1. **Há finalidade declarada?** Específica, não genérica. "Uso interno" ou "análises" não é
   finalidade (Art. 6º, I exige propósito legítimo, específico e explícito).
2. **O uso observado cabe na finalidade?** Linhagem e consumidores mostram para que o dado é
   usado. Dado coletado para entrega usado em campanha de marketing é desvio de finalidade.
3. **Há base legal declarada, e ela serve para o tipo de dado?**
4. **Os dados são necessários para a finalidade?** (Art. 6º, III — necessidade). Colunas que a
   finalidade não usa são achado.

## Árvore de referência

```
Dado sensível (Art. 5º, II)?
├── SIM → Art. 11: consentimento específico e destacado (I),
│         ou uma das hipóteses do inciso II (a–g)
│         ⚠ legítimo interesse e execução de contrato NÃO servem para sensível
└── NÃO → Art. 7º: I consentimento · II obrigação legal · III políticas públicas ·
          IV pesquisa · V contrato · VI exercício de direitos · VII proteção da vida ·
          VIII tutela da saúde · IX legítimo interesse (Art. 10, exige avaliação) ·
          X proteção do crédito
```

## Limites desta skill

- Você **verifica consistência**; não decide qual base a empresa deve adotar. Se faltar base
  legal, o achado é "sem base legal declarada" e o aprovador é o encarregado/jurídico.
- Legítimo interesse sem avaliação documentada (LIA) é achado — não suponha que exista.
- Não afirme ilegalidade. Afirme a inconsistência e a norma envolvida.

## Saída

```markdown
- Finalidade declarada: "prospecção comercial" (ficha do catálogo)
- Uso observado: consumido por `campanha_whatsapp` → coerente
- Base legal declarada: nenhuma → achado
- Dados além do necessário: `data_nascimento` — a finalidade não a usa
```
