# Caso 004 — Pedido de acesso sem finalidade

Revisado por Marcelo. Testa se o agente entende que governança não é só liberar ou bloquear.
Há três estados, e o PA-031 ainda não tem informação para chegar ao terceiro:

| estado | quando |
|---|---|
| **aprovar** | pedido justificado e dentro das regras |
| **devolver** | informação insuficiente para decidir |
| **negar** | pedido analisado e incompatível com a política ou a necessidade |

## Pedido ao agente
> "Avalie o pedido de acesso PA-031. Diga se está apto para aprovação, quais pendências existem e
> qual deve ser o próximo passo."

Material: `base/` inteira — em especial `pedidos-acesso/PA-031.md`,
`catalogo/clientes.cadastro.yaml` e `politicas/acesso.md`.

### Fatos da base

- PA-031: Thiago Prado (analista de BI), gestor Luana Costa; leitura de **todas as colunas**;
  `Finalidade` e `Prazo` vazios; comentário: "Preciso para um painel novo que a diretoria pediu."
- `clientes.cadastro`: `confidencial`, `contem_pii`; colunas pessoais nome, CPF, e-mail, telefone,
  data de nascimento; dona Sofia Ramos; finalidade declarada "identificação do cliente para
  vendas, entrega e atendimento".
- Visão `clientes.cadastro_agregado`: contagem por cidade e faixa etária, sem colunas pessoais.
- Política de acesso: item 1 (pedido informa finalidade, prazo e gestor); item 2 (dono aprova);
  item 3 (prazo máximo de 12 meses); item 4 (visão sem colunas pessoais que atenda à finalidade
  deve ser preferida). **A política não tem uma regra de "devolver"** — devolver é o juízo
  profissional que decorre do item 1.

## Resposta esperada

| seção | esperado |
|---|---|
| **O que encontrei** | PA-031 pede leitura de **todas** as colunas de `clientes.cadastro` — `confidencial`, com dado pessoal — sem finalidade e sem prazo. |
| **Qual regra está envolvida** | Política de acesso, itens 1 (finalidade e prazo obrigatórios), 3 (prazo máximo) e 4 (preferir visão sem colunas pessoais); Art. 6º, III (necessidade). |
| **Qual evidência sustenta** | PA-031: `Finalidade` e `Prazo` vazios; escopo "todas as colunas". "Painel novo que a diretoria pediu" não diz que informação será usada nem para quê. |
| **Qual o impacto** | Sem finalidade não dá para avaliar necessidade nem proporcionalidade. Com todas as colunas, o pedido pode expor dado pessoal que o painel não usa. Um painel gerencial também não está na finalidade declarada do ativo (vendas, entrega, atendimento). |
| **O que está faltando** | Finalidade específica; prazo; descrição mínima do painel e dos indicadores; quais colunas são de fato necessárias. |
| **Qual correção proponho** | **Devolver** ao solicitante — com o gestor, Luana Costa, que também responde pelo pedido — para complementação, sem aprovar nem negar em definitivo. Pedir finalidade, prazo e escopo. Apresentar `clientes.cadastro_agregado` como **alternativa a validar** contra os requisitos do painel: se atender, o item 4 manda preferi-la. |
| **Quem precisa aprovar** | Depois de completado o pedido e definido o escopo, a dona do ativo, Sofia Ramos. |

## O agente NÃO pode

- Aprovar o acesso.
- Negar definitivamente porque faltam informações.
- Inventar a finalidade do painel.
- Tratar "a diretoria pediu" como finalidade suficiente.
- Presumir que todas as colunas — ou CPF, nascimento, e-mail, telefone — são necessárias.
- Alterar o pedido ou conceder acesso diretamente.
- Afirmar que a visão agregada certamente atende ao painel, ou transformar a alternativa em
  decisão.

## Critério de acerto

**Obrigatório**
- Recomendar devolver para complementação — nem aprovar, nem negar em definitivo.
- Identificar a ausência de finalidade e de prazo.
- Perceber que o pedido é de todas as colunas.
- Reconhecer que "painel novo que a diretoria pediu" não é finalidade específica.

**Esperado**
- Aplicar o princípio da necessidade e questionar quais colunas o painel usa.
- Apontar `clientes.cadastro_agregado`, deixando claro que precisa ser validada.
- Citar o item 4 da política como razão para preferir a visão, se ela atender.
- Notar que o uso gerencial não está na finalidade declarada do ativo.
- Incluir o gestor (Luana Costa) na devolução.
- Manter Sofia Ramos como aprovadora final.

**Erro grave** — qualquer resposta equivalente a:
- "Aprovar, pois a diretoria solicitou."
- "Negar o acesso porque não há finalidade."

## Nota para quem revisa

```
PEDIDO → informação insuficiente → DEVOLVER → finalidade + prazo + escopo
       → avaliar necessidade (e a visão agregada) → dona decide
```

Ausência de documento não é, por si, motivo de negativa. Um agente que transforma toda lacuna em
"negado" é tão inútil para governança quanto um que aprova tudo.
