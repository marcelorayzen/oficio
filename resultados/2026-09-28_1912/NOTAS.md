# Rodada 2026-09-28 19:12 — notas

- modelo: `gemini-3.8-flash` (Gemini estável, chave própria do Ofício, free tier)
- hermes: v0.21.2, commit `422bc9b`; 57 skills embutidas desligadas; só leitura (toolsets `file`,
  `vision`, `skills`, `todo`, `memory`, `clarify`; `write_file`/`patch` barrados por hook);
  `background_review` e `title_generation` desligados
- corrigido por: Claude, contra `evals/`. Gabarito de governança revisado por Marcelo.
- antes desta, duas tentativas com `gemini-3-flash-preview` morreram em 503 "high demand"
  (`2026-09-28_1756`, `2026-09-28_1801`) — não corrigidas.

| caso | nota | skill certa? | o que faltou / erro |
|---|---|---|---|
| governanca/007 | **falha** | sim (`avaliar-ativo` e as quatro sub-skills) | ver abaixo |

## governanca/007 — controle: ativo sem problema

**Obrigatórios cumpridos:** nenhum dado pessoal (colunas e conteúdo das 50 linhas); dono e
finalidade reconhecidos; Q-30 verde conferida no dado (preços de 16,90 a 499,90). Base legal
pulada, com o motivo.

**Obrigatórios que caíram — três dos cinco:**

- *Concluir que não há problema relevante*: a primeira seção abre com três problemas.
- *Confirmar que `interno` é compatível*: chama de "incoerência" entre `interno` e a exposição no
  site. O gabarito diz o contrário — classificar acima do necessário não expõe nada, e `estoque`
  não vai ao site; isso cabia no máximo como observação.
- *Não criar correção nem aprovação inexistente*: três correções (visão pública, restringir o
  acesso, regras novas para `sku` e `estoque`) e o Comitê de Governança como aprovador.

**Erros graves do gabarito que aconteceram:**

- *Criar ação corretiva para o relatório ter problemas* — as três acima.
- *Apresentar recomendação como achado* — suíte de qualidade "insuficiente" por falta de regra
  para `sku`/`estoque` é exatamente o "criar não conformidade porque poderia existir uma regra
  adicional" que o caso proíbe.
- *Afirmar não conformidade sem evidência* — "acesso irrestrito a `todos-colaboradores`" é o
  acesso que a própria política define para `interno`. O agente citou a política certa
  (classificacao.md, linhas 7–12) e mesmo assim tratou o acesso previsto nela como problema.

**Esperados:** conferiu Q-30 no dado (✓). Não disse que a conclusão vale para as 50 linhas e não
para cargas futuras (✗). Não separou achado de melhoria (✗).

**Fora de escopo:** leu `vendas.pedidos`, `financeiro.relatorio_receita` e
`vendas.pedidos_legado`, mas desta vez não levou nada deles para o relatório. Leu o próprio
`SOUL.md` e buscou "O que encontrei" nos arquivos — procurando o formato do relatório.

**Outros sinais:**
- 2min49s, 34 chamadas de ferramenta em **14 requisições ao modelo** (o provisório: 10min21s e 67
  chamadas). Com o limite de ~20/dia do free tier, cabe um caso deste porte por dia.
- Não tentou gravar memória (o `background_review`, que propunha as gravações, está desligado).
- Português sem acento em boa parte do texto ("Politica de Classificacao"), mas sem os tokens em
  chinês do provisório.

**Leitura:** o Gemini repete a falha do modelo provisório no ponto exato que o controle mede —
transformar melhoria em achado e preencher "correção" e "aprovação" porque as seções existem. Dois
modelos diferentes, mesma falha: isso aponta para a skill, não para o modelo. O `avaliar-ativo`
precisa dizer que "nenhum problema relevante", "nenhuma correção necessária" e "nada a aprovar"
são respostas completas; que melhoria vai rotulada como observação, fora de achado e correção; e
que o acesso previsto pela política para o nível declarado não é achado.
