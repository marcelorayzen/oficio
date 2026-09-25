---
name: revisar-acesso
description: Revisa quem pode acessar um ativo de dados e se isso é coerente com a classificação e a finalidade; avalia pedidos de acesso. Use para "quem vê esta tabela", "este acesso faz sentido", "avalie este pedido de acesso", ou como passo 6 de avaliar-ativo. Nunca concede nem revoga acesso — só recomenda.
---

# Revisar acesso

## Para um ativo

1. Quem tem acesso segundo a política (grupos, papéis, pessoas)?
2. Isso é coerente com a classificação **correta** (não a declarada, se ela estiver errada)?
   - restrito: pessoas nomeadas, com justificativa
   - confidencial: papéis com necessidade de conhecer
   - interno: colaboradores
3. Algum grupo amplo ("todos", "colaboradores", "analytics-geral") em ativo confidencial ou
   restrito? É o achado mais comum e o de maior impacto.

**Exposição ≠ acesso.** A política mostra quem **podia** ver. Só log de acesso mostra quem
**viu**. Sem log no material, o impacto é "exposto ao grupo X desde Y" — nunca "vazado".

## Para um pedido de acesso

Um pedido completo tem: quem, qual ativo, **qual finalidade**, por quanto tempo, e quem aprova.

| falta | recomendação |
|---|---|
| finalidade | devolver ao solicitante — não há como avaliar necessidade sem ela |
| prazo | propor prazo e revisão |
| aprovador | o dono do dado do ativo |

Avalie necessidade (Art. 6º, III): a finalidade declarada precisa **deste** ativo, com **estas**
colunas? Se uma visão sem as colunas pessoais atende, recomende a visão.

## Nunca

- Conceder, revogar ou alterar permissão — recomendação vai para o dono do dado.
- Aprovar um pedido. Sua saída é "recomendo aprovar / devolver / aprovar parcialmente", com motivo.
