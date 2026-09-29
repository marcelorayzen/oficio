# Rodada 2026-09-27 22:20 — notas

- modelo: `space-bunny-free` via `opencode-free` (**provisório** — não comparar com Gemini)
- hermes: v0.21.2, commit `422bc9b`; 57 skills embutidas desligadas; terminal, navegador,
  code_execution e computer_use desligados
- corrigido por: Claude, contra `evals/`. Gabarito de governança revisado por Marcelo.

| caso | nota | skill certa? | o que faltou / erro |
|---|---|---|---|
| governanca/007 | **falha** | sim (`avaliar-ativo` e as quatro sub-skills) | ver abaixo |

## governanca/007 — controle: ativo sem problema

**Obrigatórios cumpridos:** concluiu que o ativo "está em conformidade"; `interno` compatível com
o conteúdo; nenhum dado pessoal (varreu CPF, e-mail e telefone nas 50 linhas); dono e finalidade
reconhecidos; Q-30 conferida no dado (50/50 com preço > 0). Base legal pulada, com o motivo.

**Esperados cumpridos:** disse que a conclusão vale para as 50 linhas da amostra, não para cargas
futuras; conferiu Q-30 no dado em vez de repetir a ficha.

**Por que é falha — o obrigatório "não criar correção nem aprovação inexistente" caiu, e dois
erros graves do gabarito aconteceram:**

- *Criar ação corretiva para o relatório ter problemas*: 5 correções propostas. Duas são para
  este ativo e o gabarito proíbe as duas: regras novas para `estoque` e `sku` ("criar não
  conformidade porque poderia existir uma regra adicional") e registrar a aprovação de exposição
  no site (o gabarito diz que isso pode ser observação, "nunca achado ou correção").
- *Apresentar recomendação como achado*: a cobertura de qualidade e o site entraram como
  **achados de gravidade média**, com seção própria.
- *Inventar aprovador*: Comitê de Governança, Segurança da Informação e Encarregado foram
  chamados. O gabarito espera "nada a aprovar".

**Fora de escopo:** leu ativos de outros casos e levou para o relatório o CPF de
`atendimento.chamados` (é o achado do caso 006, e é real). O achado 1 ("R-07 falha para o lado
permissivo") é crítica legítima da política, mas em um pedido sobre outro ativo, e ocupa a
primeira posição do relatório.

**Outros sinais:**
- 10min21s, 67 chamadas de ferramenta para um pedido de uma linha.
- Tokens em chinês no texto final ("用途 dupla", "de文章 ajuste") — qualidade do modelo provisório.
- Tentou gravar memória (`3cad3c7f`): diz que `search_files` não casa `\d` e manda usar `[0-9]`.
  O gate segurou; a pendência precisa ser rejeitada à mão. A afirmação sobre `\d` não foi
  conferida por nós.

**Leitura:** raciocínio e evidência bons; falha no ponto exato que o controle mede, que é
transformar melhoria em achado e preencher "correção" e "aprovação" porque as seções existem.
Isso aponta para as skills: o `avaliar-ativo` não diz explicitamente que "nenhuma correção" e
"nada a aprovar" são respostas completas nessas duas seções. Antes de mexer nas skills, repetir o
caso com o Gemini, para separar o que é do modelo do que é da skill.
