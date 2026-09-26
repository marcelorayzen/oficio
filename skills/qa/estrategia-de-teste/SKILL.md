---
name: estrategia-de-teste
description: Monta a estratégia de teste de uma feature, épico ou release a partir dos riscos — o que testar, em que nível, com qual ferramenta, o que automatizar e o que fica exploratório — ajustada ao perfil do time. Use para "estratégia de teste", "como testar essa feature", "plano de teste", "o que automatizar", "abordagem de QA para o release".
---

# Estratégia de teste

Siga `../referencias/regras-do-profissional.md`.

## Passos

1. **Escopo em uma frase** — o que muda para o usuário. Se não der para escrever, pare e pergunte.
2. **Riscos.** Para cada área afetada: impacto (financeiro, dado pessoal, segurança, reputação,
   operacional) × probabilidade (código novo, integração, regra complexa, pressa). Nível:
   crítico · alto · médio · baixo.
3. **Níveis e tipos saem dos riscos**, não o contrário. Cada linha da abordagem aponta o risco
   que a justifica; tipo de teste sem risco não entra "por completude".
4. **Automação proporcional ao time.** Time sem automação não recebe framework como primeiro
   passo: recebe a automação mais barata de maior retorno (ex.: coleção Postman + Newman no CI já
   existente). Framework completo aparece como passo seguinte, com o gatilho que o justifica.
5. **Ferramentas do perfil.** Ferramenta nova só com a lacuna dita.
6. **Critérios de entrada e saída** verificáveis.

## Formato

```markdown
## Estratégia de teste — <feature>

**Escopo:** <uma frase>
**Fora do escopo:** <o quê e por quê>

### Riscos
| # | Risco | Impacto | Probabilidade | Nível | Mitigação |

### Abordagem
| Nível | Cobre o risco | Ferramenta | Automatizado? |

### Exploratório
- Charter: explorar <área> com <recurso> para descobrir <tipo de problema> (timebox)

### Massa e ambiente
### Critérios de entrada e saída
### Perguntas em aberto
```
