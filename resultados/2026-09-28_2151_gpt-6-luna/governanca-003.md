# governanca/003 — resposta do agente

- caso: `evals/governanca/003-regra-de-qualidade-verde.md`
- hermes: Hermes Agent v0.21.2 (2026.9.11) · upstream 9fc7f179 · local 422bc9bd (+34303 carried commits) · modelo: openai-codex/gpt-6-luna · 2026-09-28T21:54:15-03:00

## Pedido

> A campanha de pós-venda está com taxa de entrega de e-mail muito baixa, mas o catálogo diz que a qualidade de `vendas.pedidos` está verde. Pode investigar o motivo da divergência e dizer se o indicador de qualidade realmente sustenta o status verde?

## Resposta

Query: A campanha de pós-venda está com taxa de entrega de e-mail muito baixa, 
mas o catálogo diz que a qualidade de `vendas.pedidos` está verde. Pode 
investigar o motivo da divergência e dizer se o indicador de qualidade realmente
sustenta o status verde?
Initializing agent...
────────────────────────────────────────

  ┊ 📚 skill     governanca:avaliar-ativo  0.2s
  ┊ 🔎 find      *  0.6s
  ┊ 📖 read      vendas.pedidos.yaml  0.1s
  ┊ 📖 read      vendas.pedidos.csv  0.1s
  ┊ 📖 read      campanha-pos-venda.md  0.1s
  ┊ 📖 read      README.md  0.1s
  ┊ 📖 read      regra-CAT-07.md  0.1s
  ┊ 📖 read      POL-DADOS-003.md  0.1s
  ┊ 📖 read      evidencia-catalogo.md  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking computation options**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ ⚡ tool_sear   0.0s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking placeholder count**
└──────────────────────────────────────────────────────────────────────────────┘
  ┊ 🔎 grep      nao-informado@aurora\.invalid  0.1s
  ┊ 📖 read      vendas.pedidos_legado.yaml  0.1s
  ┊ 🔎 grep      @exemplo\.test  0.1s

┌─ Reasoning ──────────────────────────────────────────────────────────────────┐
**Checking validity-count divergence**
└──────────────────────────────────────────────────────────────────────────────┘

╭─ ☤ Hermes ───────────────────────────────────────────────────────────────────╮
O que encontrei

A divergência é explicada, ao menos em parte, por um descompasso entre o que a regra mede e o que a campanha precisa. A regra Q-12 verifica apenas se email_cliente não está nulo; na amostra, há 36 registros preenchidos com o endereço literal nao-informado@aurora.invalid. Esse valor passa no teste de “não nulo”, mas não é um endereço de contato utilizável. Portanto, o status verde pode refletir o cumprimento da regra estreita, não a aptidão dos e-mails para entrega.

Qual regra está envolvida

Na ficha do catálogo, Q-12 está descrita como “email_cliente não nulo” e marcada como verde, com última execução em 2026-08-31 (base/catalogo/vendas.pedidos.yaml, linhas 17–19). A mesma ficha lista campanha_pos_venda como consumidora do ativo (base/catalogo/vendas.pedidos.yaml, linhas 20–22).

Qual evidência sustenta

- A campanha usa vendas.pedidos.email_cliente como fonte dos contatos e relata taxa de entrega abaixo do esperado (base/contexto/campanha-pos-venda.md, linhas 5–10).
- Q-12 testa somente se o e-mail não é nulo; a ficha não descreve validação de formato, endereço substituto ou entrega (base/catalogo/vendas.pedidos.yaml, linhas 17–19).
- A amostra tem 150 registros de dados, nas linhas 2–151. Em 36 deles, email_cliente contém nao-informado@aurora.invalid; exemplos estão nas linhas 6, 8 e 11, e há ocorrências adicionais ao longo do arquivo (base/dados/vendas.pedidos.csv, linhas 2–151; campo email_cliente).
- A amostra também tem endereços no domínio exemplo.test, por exemplo na linha 2 (base/dados/vendas.pedidos.csv, linha 2; campo email_cliente). O material não demonstra se esses endereços são entregáveis ou se representam endereços de teste.

Qual o impacto

A campanha pode receber registros que passam em Q-12, mas não fornecem um endereço de contato utilizável. Isso é compatível com o relato de baixa entrega, mas não prova que os 36 registros explicam toda a taxa baixa. O material disponível não informa o período e o denominador da métrica operacional, nem traz logs de envio ou rejeição (base/contexto/campanha-pos-venda.md, linhas 8–10).

O que está faltando

- Definição do critério de “verde” e resultados detalhados da execução de Q-12.
- Métrica de entrega com período, quantidade de mensagens tentadas, entregues e rejeitadas, e motivos de rejeição.
- Evidência sobre se os endereços exemplo.test são dados sintéticos de amostra ou endereços válidos no fluxo real.
- Regra de negócio para distinguir e-mail ausente, inválido, substituto e apto a receber cada tipo de comunicação.

Qual correção proponho

Proponho que o dono do dado e a área consumidora revisem se Q-12 deve continuar sendo apresentada como indicador suficiente de qualidade para a campanha. Como proposta para aprovação humana, separar a verificação de preenchimento de uma regra que detecte o endereço substituto nao-informado@aurora.invalid e de critérios de validade/aptidão definidos para o uso. Também proporia acompanhar a taxa operacional de entrega separadamente da regra estrutural de nulidade. Não alterei a ficha nem os dados.

Quem precisa aprovar

- Gerência de E-commerce, como dona indicada na ficha: aprovar a definição e a correção das regras de qualidade do ativo (base/catalogo/vendas.pedidos.yaml, linha 4).
- Marketing, como responsável pela campanha relatada: validar os critérios necessários ao uso dos contatos (base/contexto/campanha-pos-venda.md, linhas 3–10).
- Governança de Dados: validar a adequação do indicador no catálogo e sua comunicação como status de qualidade.

Relatório pronto. Quer que eu (1) detalhe algum achado, (2) prepare o rascunho da correção para o aprovador, ou (3) pare aqui?
╰──────────────────────────────────────────────────────────────────────────────╯

Resume this session with:
  hermes --resume 20260929_005418_7484eb

Session:        20260929_005418_7484eb
Duration:       53s
Messages:       20 (1 user, 18 tool calls)
