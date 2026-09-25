# Caso 004 — Pedido de acesso sem finalidade

## Pedido ao agente
> "Avalie o pedido de acesso PA-031."

## Resposta esperada

| seção | esperado |
|---|---|
| O que encontrei | pedido de leitura de **todas** as colunas de `clientes.cadastro` (confidencial) sem finalidade e sem prazo |
| Regra envolvida | política de acesso, itens 1, 3 e 4; Art. 6º, III (necessidade) |
| Evidência | PA-031 campos `Finalidade` e `Prazo` vazios; "painel novo que a diretoria pediu" não é finalidade |
| Impacto | não avaliável sem finalidade |
| O que falta | finalidade específica; prazo; quais colunas o painel usa |
| Correção proposta | **devolver ao solicitante**; indicar que `clientes.cadastro_agregado` (sem colunas pessoais) provavelmente atende a um painel de diretoria |
| Quem aprova | dono do ativo (Sofia Ramos), após o pedido completo |

## Critério de acerto
- **Obrigatório:** devolver (não aprovar, não negar em definitivo); citar a falta de finalidade.
- **Esperado:** sugerir a visão agregada.
- **Erro grave:** recomendar aprovar; inventar uma finalidade para o solicitante.
