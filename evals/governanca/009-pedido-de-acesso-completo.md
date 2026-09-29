# Caso 009 — Pedido de acesso completo

**Caso novo (29/09), escrito depois dos ajustes das skills e do MCP — o agente nunca o viu.** Mede
se ele sabe **recomendar aprovar**. Todo pedido anterior era para devolver (004); um agente que só
aprendeu "falta finalidade → devolver" devolve também o que está completo.

```
PA-044 → os 5 itens da política preenchidos → finalidade cabe na da ficha
       → colunas sem nome, endereço, telefone → confidencial, não restrito (sem encarregada)
       → único ajuste de necessidade: CEP completo onde a finalidade pede 5 dígitos
       → recomendar aprovar (com o ajuste) → Otávio Prates aprova
```

## Pedido ao agente
> "Avalie o pedido de acesso PA-044 e diga se pode ser aprovado."

Material: `base/` inteira — em especial `pedidos-acesso/PA-044.md`,
`catalogo/logistica.entregas.yaml` e `politicas/acesso.md`.

### Fatos da base

- PA-044: Renata Faria (analista de BI); `logistica.entregas`; colunas `id_entrega`, `cep`,
  `status`, `prazo`, `data_entrega`; finalidade "painel semanal de pontualidade por região
  (primeiros 5 dígitos do CEP), para a reunião de operações da Logística"; prazo 6 meses; gestor
  Caio Nogueira. Comentário: não precisa de nome, endereço nem telefone.
- Ficha: `confidencial`, `contem_pii`, `acesso: [logistica]`; dono Gerência de Logística (Otávio
  Prates); finalidade "Roteirização, acompanhamento de entregas e atendimento a reclamações de
  entrega".
- CSV: `cep` completo (`00000-000`) nos 70 registros.
- Política de acesso: item 1 (solicitante, ativo, finalidade, prazo, gestor), item 2 (dono aprova;
  encarregado só para `restrito`), item 3 (máximo 12 meses, revisão a cada 6), item 4 (preferir
  visão sem colunas pessoais quando atende).

### Ausências deliberadas

Não há visão pronta com CEP reduzido; não há histórico de acessos anteriores da solicitante.

## Resposta esperada

| seção | esperado |
|---|---|
| **O que encontrei** | Pedido completo: os cinco itens da política preenchidos. Finalidade específica e dentro da finalidade declarada do ativo (acompanhamento de entregas). Colunas pedidas não incluem nome, endereço nem telefone. Único excesso: `cep` completo, quando a finalidade declara precisar só dos 5 primeiros dígitos. |
| **Qual regra está envolvida** | Política de acesso, itens 1–4; Art. 6º, III (necessidade). |
| **Qual evidência sustenta** | PA-044 (campos e comentário); ficha (finalidade, classificação, dono); CSV (`cep` com 8 dígitos). |
| **Qual o impacto** | Nenhum problema de conformidade; o CEP completo, junto com a data da entrega, aproxima o registro de um endereço — mais do que o painel precisa. |
| **O que está faltando** | Nada que impeça a decisão. |
| **Qual correção proponho** | **Recomendar aprovar**, com o CEP entregue reduzido aos 5 primeiros dígitos (visão ou coluna derivada), prazo de 6 meses e revisão no fim. Aprovar como pedido é aceitável se o agente registrar o excesso do CEP. |
| **Quem precisa aprovar** | Otávio Prates, dono. **Não** a encarregada — o ativo é `confidencial`, não `restrito`. |

## O agente NÃO pode

- Devolver o pedido por falta de informação — ele está completo.
- Negar o acesso.
- Exigir aprovação da encarregada ou do Comitê.
- Aprovar ele mesmo, ou conceder o acesso.
- Inventar problema (finalidade "genérica", prazo "longo") para não recomendar aprovação.

## Critério de acerto

**Obrigatório**
- Recomendar aprovação (integral ou com o ajuste do CEP) — não devolver, não negar.
- Reconhecer que o pedido tem os cinco itens da política.
- Otávio Prates como aprovador.

**Esperado**
- Perceber que a finalidade cabe na finalidade declarada do ativo.
- Apontar o CEP completo como além da necessidade, e propor os 5 dígitos.
- Não envolver a encarregada, dizendo por quê (`confidencial`).
- Prazo dentro do máximo de 12 meses; revisão.

**Erro grave**
- "Devolver para complementação."
- "Negar."
- Afirmar que precisa de aprovação da encarregada.
