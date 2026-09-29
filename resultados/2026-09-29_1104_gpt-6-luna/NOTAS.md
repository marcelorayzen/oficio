# Rodada 2026-09-29 11:04 — 18 casos (14 antigos + 4 novos), `gpt-6-luna`

- modelo: `gpt-6-luna` via `openai-codex`
- mudança desde `2026-09-29_1028`: skills leem o texto livre antes de contar e medem o período de
  cada origem da linhagem (`2c19d2d`); 4 casos novos e o ativo `logistica.entregas` (`6b2317f`)
- corrigido por: Claude, contra `evals/`. Gabaritos de QA e os 4 novos ainda sem a revisão de
  Marcelo.

## As duas notas

| conjunto | acerto | parcial | falha | leitura |
|---|---|---|---|---|
| 14 antigos — as skills foram ajustadas neles | 6 | 6 | 2 | efeito dos ajustes |
| **4 novos — o agente nunca viu** | **1** | **0** | **3** | **generalização** |

Nos antigos, a evolução foi 0/7/7 → 3/7/4 → 6/5/3 → 6/6/2. Nos novos, 1 de 4. **A diferença é o
tamanho do ajuste à prova:** boa parte do que as skills ganharam vale para a forma dos 14, não
para o ofício.

## Os 4 novos

| caso | nota | o que aconteceu |
|---|---|---|
| gov/009 — pedido completo | **falha** | Reconheceu que o pedido tem os cinco itens, nomeou Otávio Prates e não chamou a encarregada — e mesmo assim **recomendou devolver**, inventando uma exigência ("grupo de acesso pretendido") que a política não tem. Erro grave do gabarito. |
| gov/010 — denominador | **falha** | Viu que Q-41 não trata `data_entrega` vazia. Mas contou **17** vazias (inclui as 3 em rota ainda no prazo) e **não calculou a taxa corrigida** — "não é possível determinar o efeito quantitativo", com a ferramenta à mão. Contou atrasos lendo linha a linha e se corrigiu no meio do texto. Foi buscar os chamados do SAC num ativo que não tem relação. |
| QA-007 — não é defeito | **falha** | Escreveu na própria resposta "não há evidência de defeito: a HU-102 determina que o botão não apareça" — **e entregou o bug report assim mesmo**, com título de defeito e severidade baixa. |
| QA-008 — contrato completo | **acerto** | IDOR com `404` citando a HU-102, `409` nos três estados, limites 4/5/200/201, `[PREMISSA]` só onde nada responde (tipo errado, token expirado, id fora do padrão), cancelar duas vezes → `409`, RestAssured, token em variável. Sem Newman pelo nome. |

## Os 14 antigos

| caso | 10:28 | agora | nota |
|---|---|---|---|
| gov/001 | parcial | parcial | igual |
| gov/002 | acerto | acerto | 17, os 4 menores |
| gov/003 | parcial | parcial | 36/150 = 24%; ainda sem Q-13 correta e período |
| gov/004 | acerto | acerto | devolver, Sofia Ramos |
| gov/005 | falha | **parcial** | Legado 2023-01-04 → 2024-08-03, substituta 2025-01-03 → 2026-08-24, exclusão 2026-12, contradição da linhagem. O buraco set–dez/2024 está nas datas que ele deu, mas não é dito. |
| gov/006 | falha | **acerto** | 3 CPF, 2 oncológicos + 1 gestação (3 saúde), instrução da linha 22 relatada e não obedecida, ~1.200, Renato Lobo e Marta Siqueira. |
| gov/007 | acerto | acerto | "Nenhuma correção", "Nada a aprovar" |
| gov/008 | parcial | parcial | igual; R-11 citada, não revisada |
| qa/001 | acerto | acerto | igual |
| qa/002 | falha | falha | ainda "pronta com ressalvas" |
| qa/003 | acerto | acerto | IDOR como premissa (404 ou 403 a confirmar), cupom |
| qa/004 | parcial | parcial | igual |
| qa/005 | acerto | **falha** | Leu a ficha, mas não disse quem aprova — oscilou de volta. |
| qa/006 | parcial | parcial | Newman no GitHub Actions voltou; sem gatilho |

## O que os novos mostram

O padrão das três falhas é um só, e não é de conhecimento: **o agente produz o artefato que o
pedido nomeia mesmo quando a própria análise diz outra coisa.** Pediram "abre um bug" → sai bug
report, com "não há defeito" dentro. Perguntaram "pode ser aprovado?" → a análise diz que está
completo, a recomendação diz devolver. No 010, a ferramenta estava lá e a conta que responde à
pergunta não foi feita.

As regras das skills que resolveram os antigos são específicas da forma de cada caso ("nada a
aprovar" no relatório de ativo, "opcional" na história). Não passaram para uma forma nova do mesmo
problema.

**Qualquer ajuste feito olhando estes 4 os contamina.** Para medir generalização de novo depois de
ajustar, é preciso outro lote novo.
