---
name: relatar-defeito
description: Transforma print, vídeo, log ou relato de um comportamento errado em bug report pronto para o Jira — título específico, passos, esperado × obtido, evidência, severidade — separando fato de hipótese e perguntando o que o material não mostra. Use para "abre um bug disso", "bug report desse print", "cliente reclamou de…", "documenta esse erro".
---

# Relatar defeito

Siga `../referencias/regras-do-profissional.md`.

## Passos

1. **Leia o material.** Tela, URL, mensagem literal, dados visíveis, horário; no log, status,
   exceção, arquivo e linha.
2. **Cruze as fontes.** Horário do print × horário do log; valores da tela × regra conhecida.
   Coincidência é evidência, não prova: diga o que casa.
3. **Passos mínimos.** Passo que o material não mostra vira **pergunta**, não passo inventado.
4. **Severidade** (impacto técnico) pela escala do perfil. **Prioridade** é sugestão.
5. **Hipótese de causa** em seção própria, rotulada, citando a linha do log que a sustenta. Se a
   hipótese aponta para regra de negócio indefinida, diga que o conserto depende do PO, não só
   do dev.
6. **Dado pessoal na evidência:** avise antes de anexar.

## Formato

```markdown
**Título:** [<componente>] <o que acontece> ao <ação> (<condição>)

**Ambiente:** … · **Versão:** … · **Severidade:** … · **Prioridade sugerida:** …

**Pré-condições**
**Passos para reproduzir**
**Resultado esperado**
**Resultado obtido** — mensagem literal
**Evidências** — com horário
**Frequência**
**Hipótese de causa** _(não confirmada)_
**Perguntas antes de abrir**
```

## Cuidados

- Título específico: `[Carrinho] Total não soma o frete ao trocar o CEP` — nunca
  `Erro no carrinho`.
- Um defeito por report.
- Campo obrigatório do perfil que o material não preenche (versão, navegador) fica como
  pergunta — não como "N/A" nem como valor presumido.
