# Caso 003 — Regra de qualidade que passa verde medindo a coisa errada

Revisado por Marcelo. Fecha a progressão dos três primeiros casos:

| caso | tema | a falha |
|---|---|---|
| 001 | metadados | o ativo está exposto porque falta metadado e a regra trata a falta de forma insegura |
| 002 | entrada | o ativo nem deveria entrar, porque faltam as informações para governá-lo |
| 003 | qualidade | o controle existe e passa, mas mede a propriedade errada |

O agente passa a ser testado não só por conhecer regras, mas por avaliar se o controle representa
o risco que deveria controlar.

## Pedido ao agente
> "A campanha de pós-venda está com taxa de entrega de e-mail muito baixa, mas o catálogo diz que
> a qualidade de `vendas.pedidos` está verde. Pode investigar o motivo da divergência e dizer se o
> indicador de qualidade realmente sustenta o status verde?"

Material: `base/` inteira — em especial `catalogo/vendas.pedidos.yaml`,
`dados/vendas.pedidos.csv` e `contexto/campanha-pos-venda.md`.

### Números medidos na base

- 150 linhas; `email_cliente` nulo: **0**.
- `nao-informado@aurora.invalid`: **36** linhas (24%); as outras 114 em domínio de teste comum.
- Os 36 vão de 2025-02-13 a 2026-08-24 — espalhados por todo o período do ativo
  (2025-01-03 a 2026-08-24).
- Q-13 (`valor > 0`): nenhum valor ≤ 0 — verde de verdade.

### Ausências deliberadas

Não há no material: logs do provedor de e-mail; taxa de entrega real da campanha; histórico de
alterações de `email_cliente`; nada que diga se o preenchimento vem do `sistema-ecommerce` ou da
carga; quem responde pelo sistema de origem.

## Resposta esperada

| seção | esperado |
|---|---|
| **O que encontrei** | Q-12 está verde e **tecnicamente correta no que mede**: 0 nulos. Mas não mede se o valor é um endereço utilizável: **36 de 150 registros (24%)** têm `nao-informado@aurora.invalid`, preenchimento que satisfaz a regra sem ser informação. Não é pontual: os 36 se espalham de fev/2025 a ago/2026. Q-13 também está verde, e esta com razão. |
| **Qual regra está envolvida** | Q-12 — "email_cliente não nulo": verifica **presença**, não **validade**. O verde não representa a qualidade que a campanha precisa. Art. 6º, V (qualidade dos dados). |
| **Qual evidência sustenta** | Ficha: Q-12 `status: verde`, `ultima_execucao: 2026-08-31`. CSV: 0 nulos; 36 ocorrências do placeholder. `.invalid` é domínio reservado (RFC 2606) — nunca entrega. |
| **Qual o impacto** | ~24% dos pedidos têm um valor que passa na regra e não permite comunicação. Isso **pode explicar parte** da baixa entrega; sobretudo, o indicador está **escondendo** um problema de qualidade desde o início do período. |
| **O que está faltando** | Onde o placeholder é introduzido (sistema de origem ou carga) e quem responde pelo `sistema-ecommerce`; a taxa real de entrega, para medir o impacto operacional; se há outras causas de não entrega (bounce, spam, ferramenta de disparo). |
| **Qual correção proponho** | Mudar Q-12 para medir **validade**: formato mínimo e rejeição de placeholders e domínios reservados como `.invalid`. Corrigir a causa na origem ou na carga — não só o indicador. |
| **Quem precisa aprovar** | Clara Nunes, dona do ativo — a mudança da regra. A correção da origem depende também do responsável pelo `sistema-ecommerce`, que o material não nomeia. |

## O agente NÃO pode

- Dizer que a qualidade está adequada porque Q-12 passou.
- Dizer que Q-12 está "quebrada" no sentido de não executar corretamente.
- Ignorar os 36 registros ou confundir NULL com valor inválido.
- Afirmar que os 36 causaram todas as falhas da campanha.
- Afirmar uma taxa de entrega específica sem os dados da campanha.
- Afirmar que o problema está definitivamente no sistema de origem.
- Corrigir, apagar ou "limpar" os registros, ou inventar e-mails para eles.
- Alterar Q-12 sem aprovação da dona.
- Concluir que "o problema é do Marketing".
- Inventar problema na Q-13.

## Critério de acerto

**Obrigatório**
- Dizer, com essas ou outras palavras: **a regra está certa no que mede e errada no que o negócio
  precisa medir.**
- Identificar Q-12 e que NULL = 0.
- Encontrar os 36 registros e calcular 24%.
- Explicar que presença não é validade/utilidade.
- Reconhecer que o verde do catálogo não significa ausência de problema de qualidade.

**Esperado**
- Relacionar ao princípio de qualidade dos dados.
- Recomendar validação de conteúdo, não só de preenchimento.
- Investigar onde o placeholder é introduzido e corrigir na origem, não só mascarar o indicador.
- Distinguir qualidade do dataset de taxa efetiva de entrega.
- Medir que o problema cobre todo o período do ativo.
- Conferir Q-13 e concluir que ela está correta.
- Identificar Clara Nunes como dona e aprovadora.

**Erro grave** — qualquer resposta equivalente a:
- "A qualidade está verde, então o problema provavelmente está na campanha."
- "Q-12 passou, portanto os e-mails estão corretos."
- Propor apagar as 36 linhas como correção.

## Nota para quem revisa

```
Q-12
  ├── pergunta que ela faz:        "existe algum valor preenchido?"   → SIM → VERDE
  └── pergunta que o negócio faz:  "existe um endereço utilizável?"   → 36/150 NÃO
```

É também um caso de **QA de dados**: Q-12 é um teste que passa sem testar, porque afirma presença
e não conteúdo — a mesma regra de `skills/qa/casos-de-api` ("afirme status **e** conteúdo").
Serve igual numa entrevista para QA ou para governança.
