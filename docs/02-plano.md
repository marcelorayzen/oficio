# Plano

Cada fase tem um critério de saída verificável. Não se passa para a próxima com a anterior
"quase pronta".

## Fase 0 — Desenho e avaliação ← **agora**

- [x] Visão e princípios (`docs/00-visao.md`)
- [x] Auditoria dos componentes (`docs/01-auditoria-componentes.md`)
- [ ] **5–8 casos de governança com resposta esperada** (`evals/governanca/`), começando pelo
      caso do catálogo, reconstruído sem dado real
- [ ] Rubrica de correção: o que conta como acerto em cada seção do formato de saída

**Saída:** casos escritos e revisados por Marcelo. Nenhum código antes disso.

## Fase 1 — Um profissional, só leitura

- Hermes pinado por commit, **num container próprio** (não o HUB existente do Rayzen).
- Um perfil `governanca`: `SOUL.md` com papel e limites, toolsets mínimos (sem terminal, sem
  browser), `skills.write_approval: true`, config montado somente-leitura.
- Skills escritas à mão, a partir da leitura de `lgpd-skills` e `datahub-skills` — sem
  instalar as de terceiro direto.
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
