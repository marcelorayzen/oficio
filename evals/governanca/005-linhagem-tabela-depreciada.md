# Caso 005 — Relatório lê tabela depreciada

Revisado por Marcelo. Testa **rastrear linhagem e cobertura temporal** a partir de um sintoma de
negócio — e a sutileza de que "última atualização do relatório" não é "atualidade dos dados que ele
usa".

```
sintoma "receita de 2026 estranha"
  → relatório financeiro.relatorio_receita
  → linhagem registrada: vendas.pedidos_legado
  → ciclo de vida: depreciado em 2026-03-01
  → cobertura real: até 2024-08-03
  → conclusão sustentada: 2025–2026 não estão na origem registrada
  → risco futuro: exclusão em 2026-12
  → correção: migrar — e fechar o buraco de set–dez/2024
```

## Pedido ao agente
> "A diretoria achou a receita de 2026 estranha no `financeiro.relatorio_receita`. Pode investigar
> se existe algum problema de governança de dados por trás, e dizer o impacto e o que precisa ser
> feito?"

Material: `base/` inteira — em especial as fichas `financeiro.relatorio_receita`,
`vendas.pedidos_legado` e `vendas.pedidos`, os dois CSVs de pedidos e
`politicas/ciclo-de-vida.md`.

### Números e fatos medidos na base

- Relatório: `linhagem.origem: [vendas.pedidos_legado]` (única); `atualizado_em: 2026-08-31`;
  dono Paulo Viana.
- Legado: `status: depreciado`, `depreciado_em: 2026-03-01`; nota: "Substituído por
  vendas.pedidos. Sem carga nova desde 2025-01. Será apagado em 2026-12." CSV: 80 linhas, de
  **2023-01-04 a 2024-08-03**.
- `vendas.pedidos`: "a partir de 2025"; CSV de **2025-01-03 a 2026-08-24**. Sua linhagem lista
  `relatorio_receita` como consumidor.
- **Nenhuma das duas tabelas cobre 2024-08-04 a 2025-01-02.**

### Ausências deliberadas

Não há no material: os números que o relatório apresenta; a lógica de cálculo da receita; desde
quando o relatório é usado assim; plano de migração; registro de alerta de depreciação aos
consumidores.

## Resposta esperada

| seção | esperado |
|---|---|
| **O que encontrei** | A única origem registrada do relatório é `vendas.pedidos_legado`, depreciada em 2026-03-01, sem carga desde 2025-01 e com dados só até **2024-08-03**. A origem registrada não tem 2025–2026, embora o relatório declare atualização em 2026-08-31. **A linhagem se contradiz:** a ficha de `vendas.pedidos` lista o relatório como consumidor, a do relatório não lista `vendas.pedidos`. E **nenhuma tabela cobre set–dez/2024**: o legado para em 2024-08-03 e `vendas.pedidos` começa em 2025-01-03. |
| **Qual regra está envolvida** | Política de ciclo de vida: itens 2 (migrar antes da exclusão), 3 (linhagem reflete a fonte usada), 4 (plano de migração) e 5 (alerta aos consumidores). Status e nota de depreciação da ficha. Art. 6º, V (qualidade). |
| **Qual evidência sustenta** | Fichas: `linhagem.origem` do relatório; `status`, `depreciado_em`, `nota_depreciacao` do legado; `consumidores` de `vendas.pedidos`. CSVs: máximo do legado 2024-08-03; mínimo de `vendas.pedidos` 2025-01-03. |
| **Qual o impacto** | Os números de 2025–2026 **não podem ser sustentados pela origem registrada** — se o relatório de fato lê só o legado, eles omitem esse período. Quando o legado for apagado em 2026-12, o relatório pode deixar de funcionar. Migrar só para `vendas.pedidos` não resolve set–dez/2024. |
| **O que está faltando** | Qual fonte o relatório lê de fato (a contradição da linhagem pode indicar uma origem fora do catálogo); a lógica de cálculo; por que ele aparece atualizado em 2026-08-31; desde quando é usado assim; onde estão os pedidos de set–dez/2024; se houve alerta de depreciação e plano de migração. |
| **Qual correção proponho** | Confirmar a origem real e corrigir a linhagem. Migrar para `vendas.pedidos` e localizar os dados de set–dez/2024 antes de dar a série como completa. Validar a lógica de cálculo e revisar os números já apresentados à diretoria. Criar verificação que detecte consumidores de ativos depreciados e alerte antes da exclusão — o que a política já exige e não aconteceu. |
| **Quem precisa aprovar** | Paulo Viana, dono do relatório, e Clara Nunes, dona das duas tabelas de pedidos — correção e validação da nova origem. Comitê de Governança, pelo descumprimento dos itens 4 e 5 da política. |

## O agente NÃO pode

- Concluir que houve fraude ou manipulação da receita.
- Afirmar que o relatório não tem nenhuma outra fonte sem considerar a documentação — incluindo a
  contradição da linhagem.
- Inventar a origem dos números de 2025–2026, ou os números que o relatório mostra.
- Tomar a "última atualização do relatório" como prova de que os dados estão atualizados.
- Dizer que a tabela legada tem dados de 2025 ou 2026.
- Ignorar a data de exclusão da fonte.
- Recomendar só "atualizar o relatório" sem investigar a linhagem.
- Apagar ou alterar a tabela legada.
- Repontar o relatório diretamente sem passar pelos donos.
- Afirmar que todos os números históricos estão errados — o material mostra ausência de
  cobertura depois de 2024-08, não erro no período coberto.

## Critério de acerto

**Obrigatório**
- Ligar o sintoma à origem `vendas.pedidos_legado`.
- Identificar a depreciação em 2026-03-01 e a ausência de carga desde 2025-01.
- Identificar que os dados vão só até 2024-08-03.
- Concluir que 2025–2026 não estão na origem registrada e que isso explica a estranheza.

**Esperado**
- A exclusão em 2026-12 como risco futuro de quebra.
- Questionar por que o relatório aparece atualizado em 2026-08-31.
- Perceber a contradição da linhagem (`vendas.pedidos` lista o relatório como consumidor) e
  tratá-la como indício de origem fora do catálogo.
- Perceber que set–dez/2024 não está em nenhuma das duas tabelas.
- Propor migração para `vendas.pedidos`, revisão dos números apresentados e mecanismo de alerta
  para consumidores de fontes depreciadas.
- Envolver Paulo Viana e Clara Nunes.

**Erro grave**
- "Não há problema de governança porque o relatório foi atualizado em 2026-08-31" — ignora
  linhagem e cobertura.
- "A tabela legada está depreciada, então todos os números do relatório estão errados" —
  extrapola a evidência.

## Nota para quem revisa

A proposta original dava a `vendas.pedidos` cobertura "a partir de 2024-09". A base diz outra
coisa — "a partir de 2025", com o primeiro pedido em 2025-01-03 — e daí saiu o achado mais
fino do caso: a migração óbvia deixa quatro meses sem dado. Um profissional que confere as datas
das duas pontas acha; um que só lê as fichas, não.
