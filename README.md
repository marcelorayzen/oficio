# Ofício

Profissionais de IA que trabalham **junto** de um profissional humano — não um chatbot que
responde perguntas sobre um domínio.

Um profissional aqui é a soma de:

```
papel + conhecimento + skills + ferramentas + memória + permissões + avaliação + supervisão
```

Dois ofícios, **Governança de Dados** e **QA**, num agente só — separados no desenho (skills e
avaliação próprias), juntos no runtime.

## Estado

Fase 1 — runtime e executor dos casos escritos; **primeira subida pendente**. Nenhum agente
rodou ainda. Como subir: [`docs/03-fase1-runbook.md`](docs/03-fase1-runbook.md).

| documento | o que responde |
|---|---|
| [`docs/00-visao.md`](docs/00-visao.md) | o que é, as quatro camadas, os princípios que não se negociam |
| [`docs/01-auditoria-componentes.md`](docs/01-auditoria-componentes.md) | o que cada peça candidata **de fato** faz — confirmado × declarado × desmentido |
| [`docs/02-plano.md`](docs/02-plano.md) | ordem de execução e o critério para cada peça entrar |
| [`skills/governanca/`](skills/governanca/) | as skills do profissional — `avaliar-ativo` orquestra as outras quatro |
| [`skills/qa/`](skills/qa/) | as skills do profissional de QA — testabilidade, estratégia, casos de API, bug report |
| [`base/`](base/) | **Aurora Varejo**, empresa fictícia: catálogo, dados, políticas, pedidos de acesso — e em [`base/qa/`](base/qa/) o contrato da API, histórias e evidências |
| [`evals/governanca/`](evals/governanca/) · [`evals/qa/`](evals/qa/) | casos com resposta esperada — o agente **nunca** vê estas pastas |
| [`runtime/`](runtime/) · [`scripts/rodar-casos.sh`](scripts/rodar-casos.sh) | o agente em container (Hermes pinado) e o executor que roda os casos sem mostrar o gabarito |
| [`fontes/`](fontes/) | skills de terceiros no commit exato, com licença, e o que foi adaptado delas |
| [`ferramentas/gerar_base.py`](ferramentas/gerar_base.py) | gera `base/dados/` — determinístico, sem dependência |

## Relação com o Rayzen

**Nenhuma dependência.** Este projeto não importa código, não lê o banco e não escreve no Rayzen.
As lições aprendidas lá entram como princípios (ver `docs/00-visao.md`), não como acoplamento. Se
um dia houver ponte, é leitura por MCP com token próprio, decidida explicitamente.
