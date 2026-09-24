# Ofício

Profissionais de IA que trabalham **junto** de um profissional humano — não um chatbot que
responde perguntas sobre um domínio.

Um profissional aqui é a soma de:

```
papel + conhecimento + skills + ferramentas + memória + permissões + avaliação + supervisão
```

Piloto: **Governança de Dados**.

## Estado

Fase 0 — desenho e auditoria. **Nada instalado.**

| documento | o que responde |
|---|---|
| [`docs/00-visao.md`](docs/00-visao.md) | o que é, as quatro camadas, os princípios que não se negociam |
| [`docs/01-auditoria-componentes.md`](docs/01-auditoria-componentes.md) | o que cada peça candidata **de fato** faz — confirmado × declarado × desmentido |
| [`docs/02-plano.md`](docs/02-plano.md) | ordem de execução e o critério para cada peça entrar |
| [`evals/governanca/`](evals/governanca/) | casos com resposta esperada — escritos **antes** do agente |

## Relação com o Rayzen

**Nenhuma dependência.** Este projeto não importa código, não lê o banco e não escreve no Rayzen.
As lições aprendidas lá entram como princípios (ver `docs/00-visao.md`), não como acoplamento. Se
um dia houver ponte, é leitura por MCP com token próprio, decidida explicitamente.
