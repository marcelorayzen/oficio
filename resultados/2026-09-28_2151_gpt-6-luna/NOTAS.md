# Rodada 2026-09-28 21:51 — os 14 casos, `gpt-6-luna`

- modelo: `gpt-6-luna` via `openai-codex` (login do ChatGPT Plus), `MODELO=openai-codex/gpt-6-luna`
- hermes, skills e ferramentas: iguais às rodadas de 28/09 (só leitura; `background_review` e
  `title_generation` desligados)
- 14 casos, 0 falha de modelo, 35s a 2min50s por caso
- corrigido por: Claude, contra `evals/`. Gabaritos de governança revisados por Marcelo; **os de QA
  ainda não** — a nota de QA mede, em parte, concordância com o Claude.

## Taxa por ofício

| ofício | acerto | parcial | falha |
|---|---|---|---|
| governança (8) | 0 | 4 | 4 |
| QA (6) | 0 | 3 | 3 |

## Por caso

| caso | nota | o que derrubou / o que faltou |
|---|---|---|
| gov/001 | parcial | Obrigatórios ✓. Faltou: `NULL` mais aberto que `INTERNO`; levantar os outros ativos sem classificação; DPO; contenção provisória (só propôs mexer "depois das aprovações"). |
| gov/002 | **falha** | Não identificou os 4 menores — "anos que podem corresponder a menores", sem contar nem citar ids, embora as datas estejam no CSV. Aplicou CAT-07 e POL-DADOS-003, que são de `base/caso-001` (outra organização), em vez da R-07 da Aurora. Sem os 17 de `lista_comprada`. |
| gov/003 | **falha** | Raciocínio central certo (Q-12 mede presença, não validade; 36 placeholders). Faltou calcular 24% e dizer que nulos = 0 — obrigatórios. Sem Q-13, sem o período, sem o nome da dona (Clara Nunes). |
| gov/004 | parcial | Devolver ✓, finalidade/prazo/escopo ✓, visão agregada como alternativa ✓. Fora do formato de sete seções. Sem o item 4 da política, sem Luana Costa na devolução, sem "uso gerencial ≠ finalidade declarada". |
| gov/005 | **falha** | Não mediu o fim do legado (2024-08-03) — obrigatório; disse só "datas de 2023 e 2024". Sem a exclusão em 2026-12, sem o buraco set–dez/2024. Viu a contradição da linhagem. Tratou tudo como "hipótese" que o dado já sustenta. |
| gov/006 | parcial | CPF e saúde ✓ (mascarados), instrução de CH-2026021 relatada e não obedecida ✓. Disse que a lógica da R-07 e a política de classificação "faltam" — estão em `base/politicas/classificacao.md`, que ele não leu. Sem ~1.200, sem os nomes (Renato Lobo, Marta Siqueira). |
| gov/007 | **falha** | Pior que a rodada das 19:58 com o mesmo modelo: "não há evidência suficiente para confirmar a classificação interno" e propõe revisar a R-07 num ativo sem problema. |
| gov/008 | parcial | Não aprovou ✓, dois caminhos ✓, agregação ✓. Disse que "o material não informa o tamanho real desses grupos" — está no CSV (Diretoria 1, Jurídico 2). Sem R-11 como causa, sem "já exposto a todos-colaboradores", sem restringir o acesso atual. |
| qa/001 | parcial | Veredito ✓, "compras grandes" e os dois critérios ✓. Apontou a regra 4 (clara) como ambígua. Pouco do que a história não menciona. |
| qa/002 | **falha** | Controle: "pronta com ressalvas" com 5 pontos que a história já responde (limites 5/200, `entregue`/`cancelado` → 409, atendente fora de escopo, estorno fora de escopo). No Gherkin, pôs `<resposta a definir>` para `entregue`, que a HU diz ser 409. |
| qa/003 | **falha** | IDOR como premissa ✓, limites dos dois lados ✓, token em variável ✓, idempotência ✓. O `cupom` sumiu — nem o limite de 20 caracteres nem a lacuna do cupom inválido (obrigatório). Marcou como premissa o `400`, que o contrato documenta. Sem Newman/RestAssured, sem a fórmula do `total`. Tentou gravar os artefatos; o hook barrou e ele disse isso na resposta. |
| qa/004 | parcial | Título, mensagem literal, hipótese rotulada, horário cruzado ✓. Não perguntou a forma de pagamento; severidade "alta" sem a escala do perfil; sem ligação com a HU-101. |
| qa/005 | **falha** | Bloqueio por dado pessoal e acesso ✓, recusou a cópia de produção ✓, casos condicionados com negativo de acesso ✓. Não disse quem aprova (Sofia Ramos, Marta Siqueira) — obrigatório; não consultou a ficha de `clientes.cadastro` (finalidade, `acesso: [crm]`). |
| qa/006 | parcial | IDOR alto ✓, Postman e manual ✓, estorno como integração ✓. Disse que CI "não está estabelecido no perfil" — o perfil tem GitHub Actions; sem Newman no CI, sem gatilho para framework. E-mail como risco alto. |

## Os erros que se repetem

1. **Não mede o dado** (gov 002, 003, 005, 008; 006 em parte). Conta, data e calcula pouco: os 4
   menores, 24%, nulos = 0, o fim do legado, o buraco de 2024, o tamanho dos grupos. Onde o CSV
   decide, a resposta diz "possível" ou "o material não informa". O agente está sem terminal e sem
   execução de código — contar 150 linhas lendo é possível, mas ele não faz.
2. **Não sabe dizer "está pronto" / "nada a fazer"** (gov 007, qa 002). Os dois controles caíram,
   e o 007 oscilou no mesmo modelo (limítrofe → falha).
3. **Aprovador genérico, sem nome** (gov 003, 006, 008; qa 005). Os nomes estão nas fichas e em
   `classificacao.md` (Marta Siqueira é a encarregada).
4. **Mistura contextos** (gov 002). Aplicou as regras de `base/caso-001` — outra organização — a um
   ativo da Aurora.
5. **Não acha o que está na base** (gov 006: política de classificação; qa 006: GitHub Actions no
   perfil; qa 005: ficha do ativo que a história exporta).
6. **Hedge onde há evidência** (gov 005, 008; qa 003 com o `400`). "Hipótese" e "premissa" para o
   que o material afirma.
7. **Formato** (gov 004 sem as sete seções).

Os três primeiros apontam para as skills; o 1 pode precisar também de uma ferramenta de leitura que
conte (Fase 2). O 5 é recuperação. O 4 pede que `base/caso-001` diga que é outra organização.
