# Rodada 2026-09-28 19:58 — notas

- modelo: `gpt-6-luna` via `openai-codex` (login do ChatGPT Plus), só nesta rodada
  (`MODELO=openai-codex/gpt-6-luna`); o padrão do config segue `gemini-3.8-flash`
- hermes, skills e ferramentas: iguais à rodada `2026-09-28_1912`
- corrigido por: Claude, contra `evals/`. Gabarito de governança revisado por Marcelo.

| caso | nota | skill certa? | o que faltou / erro |
|---|---|---|---|
| governanca/007 | **acerto (limítrofe)** | sim (`avaliar-ativo` e as quatro sub-skills) | "Quem precisa aprovar" preenchido com aprovadores condicionais — ver abaixo |

## governanca/007 — controle: ativo sem problema

**Obrigatórios:**
- Sem problema relevante — ✓ "não há evidência de exposição indevida nem de dado pessoal";
  "não identifico correção obrigatória".
- `interno` compatível — ✓ "coerentes com a política para ativos sem dado pessoal", citando o
  acesso `todos-colaboradores` como o que a política autoriza. (O Gemini tratou o mesmo acesso como
  problema.)
- Sem dado pessoal — ✓ colunas e conteúdo (`descricao` são rótulos como "Item 1").
- Dono, finalidade e Q-30 verde — ✓, Q-30 conferida nos preços da amostra.
- Não criar correção nem aprovação inexistente — correção ✓ ("nenhuma obrigatória"; o resto vem
  rotulado como melhoria). Aprovação **limítrofe**: a seção lista dono, Comitê e Encarregado, todos
  condicionados ("se propostas", "se a verificação identificar dado pessoal"). Não afirma que haja
  algo a aprovar, mas o gabarito espera "nada a aprovar" e proíbe "inventar necessidade de
  encarregado, Comitê". O item do dono vai além do condicional: pede que ele "confirme finalidade,
  conteúdo real, qualidade e linhagem" — trabalho que nada no caso exige.

**Esperados:** ✓ os três — "isso não prova ausência de dados em toda a tabela"; achado separado de
melhoria ("Como melhoria de governança, proponho…"); Q-30 conferida no dado ("sustenta a regra para
a amostra, não valida a execução registrada").

**Erros graves:** nenhum.

**Ressalvas menores:**
- "O que está faltando" lista cinco itens (amostra maior, execução de Q-30, linhagem, logs, origem
  de `descricao`). O gabarito: "nada que mude a conclusão". Nenhum dos cinco é apresentado como
  lacuna do ativo, mas o tom é de dossiê incompleto.
- Leu `normas-lgpd.md` e o README da base; não leu ativo de outro caso.

**Outros sinais:** 1min07s, 19 chamadas de ferramenta em **5 requisições ao modelo** (Gemini: 14;
provisório: ~67 chamadas). Não tentou gravar memória.

**Leitura:** o GPT passa no ponto que o controle mede — conclui "sem problema" e separa melhoria de
achado —, onde o Gemini e o provisório falharam. Então a falha do 007 não é só da skill: depende
do modelo. Mas os três preenchem "Quem precisa aprovar" porque a seção existe, o que continua
apontando para o `avaliar-ativo` dizer que "nada a aprovar" é resposta completa.

**Para Marcelo decidir:** aprovadores condicionais contam como "aprovação inexistente"? Se sim,
este caso vira **falha** e o critério deveria dizer isso explicitamente.
