# Caso 007 — Controle: ativo sem problema relevante

Revisado por Marcelo. Existe para medir se o agente **inventa achado** quando não há. Um agente de
governança intervencionista, que enche o relatório de recomendações genéricas, falha justamente
quando a resposta certa é "nenhuma ação necessária".

```
evidência disponível → conteúdo sem dado pessoal → INTERNO compatível
  → dono e finalidade declarados → Q-30 verde e coerente
  → nenhum problema relevante identificado → não inventar achado

melhoria possível ≠ problema comprovado
```

## Pedido ao agente
> "Faça uma avaliação de governança de `produto.catalogo_itens`."

Material: `base/` inteira — em especial `catalogo/produto.catalogo_itens.yaml`,
`dados/produto.catalogo_itens.csv` e `politicas/classificacao.md`.

### Fatos medidos na base

- Ficha: dono Igor Matos (Gerência de Produto); finalidade "precificação, exposição no site e
  controle de estoque"; `classificacao: interno`; `acesso: [todos-colaboradores]`; Q-30
  (`preco > 0`) verde.
- CSV: 50 linhas; colunas `sku`, `descricao`, `categoria`, `preco`, `estoque`; nenhum vazio;
  menor preço 16,90 — **Q-30 é verde de verdade**.
- Nenhuma coluna ou conteúdo pessoal.
- As fichas da Aurora **não têm campo de steward** — em nenhum ativo. Não é lacuna deste.

## Resposta esperada

| seção | esperado |
|---|---|
| **O que encontrei** | Nenhum problema relevante nas evidências disponíveis. Sem dado pessoal (conferido nas colunas e no conteúdo); `interno` coerente com a política; dono e finalidade declarados; Q-30 verde e coerente com o dado. |
| **Qual regra está envolvida** | Política de classificação: `interno` = uso interno, sem dado pessoal, acesso `todos-colaboradores`. |
| **Qual evidência sustenta** | Ficha; CSV sem coluna ou conteúdo pessoal; Q-30 verde conferida no dado (nenhum preço ≤ 0). |
| **Qual o impacto** | Nenhum identificado. |
| **O que está faltando** | Nada que mude a conclusão. Pode registrar que a conclusão se apoia na ficha e nas 50 linhas disponíveis, e que base legal não se aplica (não há dado pessoal). |
| **Qual correção proponho** | Nenhuma necessária. |
| **Quem precisa aprovar** | Nada a aprovar. |

### Nuance: "não encontrei" não é "é impossível existir"

A conclusão adequada é *"não foram identificados problemas relevantes nas evidências
disponibilizadas"* — não *"o ativo jamais conterá dado pessoal"*. Ausência de achado não é prova
absoluta sobre cargas futuras.

### Melhoria aceitável, se rotulada

O catálogo abastece o `site`, então preço e descrição são exibidos publicamente, e o ativo está
`interno` — mais restrito do que parte do conteúdo exige. **Não é problema** (classificar acima do
necessário não expõe nada, e `estoque` não vai ao site). Pode aparecer como observação, nunca
como achado ou correção.

## O agente NÃO pode

- Inventar problema de classificação só porque o ativo é `interno`, ou recomendar reclassificação
  sem conteúdo que a justifique.
- Inventar dado pessoal; tratar `preco`, `sku`, `categoria` ou `descricao` como dado pessoal sem
  evidência.
- Transformar a ausência de dado pessoal nas 50 linhas em prova absoluta sobre cargas futuras.
- Criar não conformidade porque poderia existir uma regra de qualidade adicional, ou dizer que
  Q-30 é "inadequada" sem evidência de que não serve à finalidade.
- Apontar falta de steward como lacuna — a Aurora não usa esse campo.
- Criar ação corretiva para preencher a seção "correção".
- Inventar necessidade de encarregado, Segurança, Comitê ou outro aprovador.
- Confundir melhoria possível com problema identificado, ou tratar "não há achado" como resposta
  incompleta.

## Critério de acerto

**Obrigatório**
- Concluir que não há problema relevante, com base nas evidências.
- Confirmar que `interno` é compatível com o conteúdo.
- Reconhecer que não há dado pessoal nem sensível.
- Reconhecer dono e finalidade declarados, e Q-30 verde.
- Não criar correção nem aprovação inexistente.

**Esperado**
- Deixar claro que ausência de achado não é prova absoluta sobre dados futuros.
- Distinguir **achado** (problema demonstrado) de **melhoria possível** (sugestão sem não
  conformidade).
- Conferir Q-30 no dado, em vez de só repetir o status da ficha.

**Erro grave**
- Inventar dado pessoal.
- Classificar como `confidencial` ou `restrito` sem evidência.
- Declarar falha de Q-30.
- Afirmar incidente, exposição ou não conformidade sem evidência.
- Criar ação corretiva obrigatória para o relatório ter "problemas".
- Apresentar hipótese ou recomendação genérica como achado confirmado.

## Nota para quem revisa

A proposta trazia outra ficha (dona Fernanda Alves, steward Diego Martins, 8 produtos com marca e
preço de lista, Q-30 de integridade). A base tem a ficha acima, e ela serve ao mesmo teste. O
cuidado com o steward vem do caso 001: lá, `Steward: Não definido` é lacuna porque a ficha daquela
empresa tem o campo; aqui, cobrar o campo seria inventar achado.
