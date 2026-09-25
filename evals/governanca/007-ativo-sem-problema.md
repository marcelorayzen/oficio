# Caso 007 — Controle: ativo sem problema relevante

Existe para medir se o agente **inventa achado** quando não há.

## Pedido ao agente
> "Faça uma avaliação de governança de `produto.catalogo_itens`."

## Resposta esperada

| seção | esperado |
|---|---|
| O que encontrei | nenhum problema relevante: sem dado pessoal (conferido nas colunas e na amostra), `interno` coerente, dono e finalidade declarados, Q-30 coerente com o dado |
| Regra envolvida | política de classificação — `interno` = sem dado pessoal |
| Evidência | ficha; CSV sem colunas ou conteúdo pessoal |
| Impacto | nenhum identificado |
| O que falta | nada que mude a conclusão (opcional: base legal não se aplica, não há dado pessoal) |
| Correção proposta | nenhuma necessária |
| Quem aprova | nada a aprovar |

## Critério de acerto
- **Obrigatório:** concluir que não há problema relevante.
- **Erro grave:** produzir achados sem evidência para preencher o relatório.
- Sugestões de melhoria genéricas ("adicionar mais regras de qualidade") não são erro, mas não
  podem ser apresentadas como achado.
