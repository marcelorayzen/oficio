# Rodada 2026-09-29 08:08 — os 14 casos, `gpt-6-luna`, skills refinadas

- modelo: `gpt-6-luna` via `openai-codex`, como a rodada `2026-09-28_2151`
- mudança desde lá: só as skills e o SOUL (commit `a58b3a9`)
- corrigido por: Claude, contra `evals/`. Gabaritos de QA ainda sem a revisão de Marcelo.
- **ressalva:** as skills foram ajustadas olhando os erros destes mesmos 14 casos. Parte da melhora
  pode ser ajuste à prova; só um caso novo mostra se generalizou.

## Taxa por ofício

| ofício | acerto | parcial | falha | antes (28/09 21:51) |
|---|---|---|---|---|
| governança (8) | 2 | 5 | 1 | 0 / 4 / 4 |
| QA (6) | 1 | 2 | 3 | 0 / 3 / 3 |

## Por caso

| caso | antes | agora | o que mudou |
|---|---|---|---|
| gov/001 | parcial | parcial | Igual. Ainda sem "NULL mais aberto que INTERNO", impacto sistêmico, DPO, contenção. Recusou recomendar RESTRITO ao Owner — o gabarito espera a recomendação. |
| gov/002 | falha | **acerto** | Achou os 4 menores (linhas 6, 23, 39, 52 = ids 5, 22, 38, 51), R-07 → `interno` e nenhuma regra para menores, Marta Siqueira. Sem o `caso-001`. **Contou 18 `lista_comprada`; são 17** — listou as 17 linhas e errou a soma. |
| gov/003 | falha | parcial | 36/150 = 24% ✓, Clara Nunes ✓. Sem Q-13 como correta, sem o período coberto (disse que não dá para determinar — as datas estão no CSV), sem corrigir na origem. |
| gov/004 | parcial | parcial | **Regrediu na evidência:** usou a ficha `CAT-004821` do `caso-001` (outra organização) como se fosse `clientes.cadastro`, "divergência de identificação" inventada, Sofia Ramos sumiu. Obrigatórios de pé (devolver, finalidade, prazo, todas as colunas). Ainda fora das sete seções. |
| gov/005 | falha | **falha** | Não abriu os CSVs de pedidos: sem 2024-08-03, sem exclusão em 2026-12, sem o buraco de 2024. Novo achado inventado: relatório `interno` "incoerente" porque a origem tem dado pessoal — o relatório tem só `mes` e `receita`. |
| gov/006 | parcial | parcial | Leu a política desta vez (R-07 como causa ✓), nomes ✓. **Contou 39 chamados; são 40.** Disse que as linhas 13 e 27 têm CPF **e** saúde — falso, são chamados diferentes (o caso proíbe juntar os dois). |
| gov/007 | falha | **acerto** | "Nenhum problema relevante", "Nenhuma correção necessária", "Nada a aprovar", observação rotulada, limite da amostra. **Contou 49 linhas; são 50.** |
| gov/008 | parcial | parcial | Contagem por setor certa (22/18/15/2/1), ~1.200, Beatriz Leal e Marta Siqueira. **Disse que a resposta da Diretoria é "F"; é "M".** Sem R-11 como causa, sem restringir o acesso atual. |
| qa/001 | parcial | **acerto** | Regra 4 fora da tabela, pontos não mencionados, Gherkin com `< >`. Nomeou o PO. |
| qa/002 | falha | **falha** | Ainda "pronta com ressalvas": `entregue`/`cancelado` → 409 como ponto (a regra da linha 12 responde — e ele mesmo escreve 409 no Gherkin), falha de e-mail e de estorno, concorrência. Os limites 5/200 viraram opcionais ✓. |
| qa/003 | falha | **falha** | **Não achou o contrato:** a busca `find pedido\|POST /pedidos…` não bateu em `base/qa/api/pedidos-openapi.yaml`, e ele respondeu que não há OpenAPI. 21s. |
| qa/004 | parcial | parcial | Ligou à HU-101 e ao PO ✓. Ainda sem perguntar a forma de pagamento; disse que o perfil não tem escala de severidade — tem (linha 26: bloqueante/crítica/alta/média/baixa). |
| qa/005 | falha | **falha** | Não leu a ficha de `clientes.cadastro` apesar da regra 9 nova: sem quem aprova, sem a finalidade declarada. Bloqueios de dado pessoal, acesso e cópia de produção ✓. |
| qa/006 | parcial | parcial | Postman no GitHub Actions ✓, IDOR alto ✓. Sem gatilho para o framework (nem RestAssured). |

## O que as skills resolveram

- Dizer "nada a fazer" na governança (007) e parar de inventar achado lá.
- Nomear o aprovador quando o material nomeia (002, 003, 005, 006, 008).
- Achar os menores e as proporções (002, 003).

## O que apareceu agora

1. **Mede, mas conta errado.** Mandado medir, o agente passou a dar números — e 4 de 14 respostas
   trazem contagem ou atributo errado, com confiança: 39/40, 49/50, 18/17, "F"/"M", "linhas com
   CPF e saúde" que não existem. Contar lendo o arquivo não é confiável neste modelo. Número errado
   afirmado como medido é pior que "não medi". **Pede a ferramenta de leitura que conta (Fase 2)**
   — skill não resolve.
2. **Recuperação ainda falha, e às vezes pior.** qa/003 não achou o contrato; gov/004 pegou a ficha
   da outra organização; gov/005 não abriu os CSVs da linhagem; qa/005 não abriu a ficha. O mapa
   da base (`base/README.md`) não lista as subpastas de `qa/`, e nada manda lê-lo primeiro.
3. **O controle de QA (002) resiste.** A regra "procure a resposta na história" não bastou: ele
   ainda trata falha de dependência e concorrência como bloqueio.
