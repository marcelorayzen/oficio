# Plano

Cada fase tem um critério de saída verificável. Não se passa para a próxima com a anterior
"quase pronta".

## Fase 0 — Desenho e avaliação ← **agora**

- [x] Visão e princípios (`docs/00-visao.md`)
- [x] Auditoria dos componentes (`docs/01-auditoria-componentes.md`)
- [x] Skills do piloto (`skills/governanca/`), adaptadas de `lgpd-skills` — ver `fontes/`
- [x] Base de teste sintética (`base/`) — escolhida em vez de DataHub (≥ 8 GB de RAM)
- [x] Casos 002–008 com resposta esperada e critério de acerto, números medidos na base
- [ ] Caso 001 com os detalhes reais de Marcelo (reconstruído sem dado real)
- [ ] Revisão dos gabaritos por Marcelo — **são a opinião do Claude sobre o que um profissional
      diria, e isso precisa de um profissional de verdade conferindo**

**Saída:** gabaritos revisados por Marcelo. Até lá, uma nota alta do agente só mede concordância
com o Claude.

## Fase 1 — Um profissional, só leitura

- Hermes pinado por commit, **num container próprio** (não o HUB existente do Rayzen).
- Um perfil `governanca`: `SOUL.md` com papel e limites, toolsets mínimos (sem terminal, sem
  browser), `skills.write_approval: true`, config montado somente-leitura.
- Carregar `skills/governanca/` no perfil; o agente recebe `base/` montada somente-leitura.
- Os casos rodam; resultado comparado à resposta esperada.

**Saída:** taxa de acerto medida nos casos, com as falhas explicadas. Incluir casos em que a
resposta certa é "não há evidência suficiente" — um agente que sempre acha algo não passa.

## Fase 2 — Ferramentas de leitura

- MCP de leitura para as fontes do domínio (documentos, catálogo de teste).
- Casos novos que exigem consultar a ferramenta em vez de responder de memória.

**Saída:** o profissional cita a fonte de cada afirmação; afirmação sem fonte conta como erro.

## Fase 3 — Propor e pedir aprovação

- Escrita só em rascunho; toda ação consequente passa por aprovação humana **por risco**.
- Teste de porta: a mesma ação pedida por caminhos diferentes (chat, rotina, outro perfil) cai
  no mesmo gate.

## Fase 4+ — Só com número na mão

| peça | entra quando |
|---|---|
| segundo profissional (QA) | o piloto passa na Fase 3 — reaproveitando a estrutura |
| Bot Mode | houver 2+ profissionais e uso real no desktop |
| OpenViking | os casos mostrarem falha de **recuperação**, não de raciocínio |
| Laya | houver centenas de decisões rotuladas e volume que justifique; comparado a LLM local no mesmo hardware |
| Browser | um caso real exigir sistema web **e** houver conta de serviço de privilégio mínimo |

## Decisões em aberto

- Onde roda: servidor doméstico (sem GPU) ou outra máquina.
- Qual modelo de raciocínio o profissional usa, e com qual orçamento mensal.
- Se isto é ferramenta pessoal ou produto (muda a leitura da AGPL do OpenViking e o cuidado com
  dados de terceiros).
