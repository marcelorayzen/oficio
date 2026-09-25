---
name: analisar-testabilidade
description: Analisa se uma história de usuário, PRD, protótipo ou transcrição de refinamento está pronta para ser testada — ambiguidades, critérios de aceite ausentes ou vagos, regras sem limite, caminhos de erro ignorados, riscos de dado pessoal — e devolve perguntas ao PO e critérios sugeridos em Gherkin. Use para "analisa essa história", "está testável?", "o que falta nessa HU", "revise os critérios de aceite", ou quando uma história nova chegar.
---

# Analisar testabilidade

Siga `../referencias/regras-do-profissional.md`.

## O que procurar

| problema | exemplo |
|---|---|
| critério ausente ou vago | "o desconto é aplicado corretamente"; "deve ser rápido" |
| ambiguidade | "cliente" — qual papel? "valor" — com ou sem frete? |
| regra sem limite | "compras grandes" — a partir de quanto? |
| regra sem combinação definida | dois benefícios juntos: acumulam? qual prevalece? |
| caminho infeliz ignorado | e se o cupom expirou? e se o pagamento falhar? |
| contradição | uma regra contradiz outra ou o contrato da API |
| dependência oculta | outra história, feature flag, dado pré-existente |
| dado pessoal e acesso | exporta, exibe ou envia dado pessoal? quem pode? há finalidade? |
| não funcional implícito | volume, permissão, desempenho — com número ou sem |

## Formato

```markdown
## Testabilidade — <história>

**Veredito:** pronta · pronta com ressalvas · não testável ainda

### Pontos a esclarecer
| # | Trecho (literal) | Problema | Pergunta ao PO |
|---|---|---|---|

### Riscos já visíveis
- <risco> — <por quê>

### Critérios de aceite sugeridos (Gherkin) — para o PO validar
Cenário: …
```

## Cuidados

- Cite o **trecho literal**; crítica sem trecho não é acionável.
- Critério sugerido é sugestão para o PO. Ele **não resolve** a ambiguidade: o valor que o PO não
  deu aparece como `<valor a definir>`, nunca como número escolhido por você.
- História boa recebe "pronta". Sugestões menores entram rotuladas como opcionais, sem virar
  "ponto a esclarecer".
- Se a história envolve dado pessoal, o problema de governança é **achado de testabilidade**:
  sem finalidade e controle de acesso definidos, não há resultado esperado para testar.
