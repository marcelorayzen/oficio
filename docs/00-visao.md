# Visão

## O problema

Um agente generalista com mais skills continua sendo um generalista. O que faz alguém ser
profissional não é saber responder sobre o domínio — é saber **o que precisa ser feito, em que
ordem, com qual evidência, e o que não pode fazer sem aprovação**.

## As quatro camadas

```
            HUMANO
              │  conversa / tarefa
              ▼
   ┌──────────────────────┐
   │ 1. RUNTIME           │  Hermes: raciocínio, conversa, planejamento, execução
   │    (um perfil por    │  cada profissional = um perfil isolado
   │     profissional)    │
   └──────────┬───────────┘
              │
   ┌──────────▼───────────┐
   │ 2. CONTEXTO          │  conhecimento do domínio, experiências, histórico
   │                      │  (memória nativa do Hermes; OpenViking é candidato, não decisão)
   └──────────┬───────────┘
              │
   ┌──────────▼───────────┐
   │ 3. OFÍCIO            │  skills + workflows + regras do domínio
   │                      │  É AQUI que mora o valor deste projeto
   └──────────┬───────────┘
              │
   ┌──────────▼───────────┐
   │ 4. FERRAMENTAS       │  MCP · APIs · documentos · browser (por último)
   └──────────┬───────────┘
              ▼
       APROVAÇÃO HUMANA  (por risco da ação — nunca por rota)
```

A camada 3 é a única que ninguém entrega pronta. Runtime, memória e browser são peças de
mercado; o **workflow profissional** — os 14 passos de avaliar um dataset, o formato da
evidência, quem aprova o quê — é o que este projeto constrói.

## Anatomia de um profissional

| componente | Governança (piloto) |
|---|---|
| papel | avaliar, diagnosticar e propor — nunca decidir política |
| conhecimento | catálogo, metadados, classificação, qualidade, linhagem, LGPD |
| skills | `metadata-analysis` · `classification` · `data-quality` · `access-review` · `policy-analysis` · `impact-analysis` · `evidence-generation` |
| ferramentas | leitura de catálogo/documentos; escrita só em rascunho |
| **pode** | consultar · analisar · comparar · produzir proposta e evidência |
| **não pode** | alterar política · conceder acesso · publicar dado sensível · aprovar o próprio trabalho |
| avaliação | `evals/governanca/` — casos com resposta esperada |

### Formato de saída que o profissional deve produzir

```
O que encontrei → Qual regra está envolvida → Qual evidência sustenta
→ Qual o impacto → O que está faltando → Qual correção proponho → Quem precisa aprovar
```

Cada seção é obrigatória. "Não encontrei evidência" é uma resposta válida; preencher sem
evidência não é.

## Princípios que não se negociam

Vêm de falhas reais observadas em outro sistema. Cada um já custou caro uma vez.

1. **Avaliação antes do agente.** Os casos de `evals/` são escritos antes do primeiro prompt.
   Sem resposta esperada, "funciona" é opinião.
2. **Aprovação depende do risco da ação, nunca da porta de entrada.** Com vários profissionais,
   cada um é uma porta a mais. Se a regra de aprovação morar na rota, a mesma ação passa por uma
   porta e é barrada por outra.
3. **Skill escrita pelo agente entra em revisão.** Skill é procedimento: uma errada vira
   procedimento errado aplicado com confiança. `skills.write_approval: true` desde o dia 1, e o
   agente não consegue desligar o próprio gate (config montado somente-leitura).
4. **Isolamento de perfil não é fronteira de segurança.** Perfis do Hermes são diretórios sob o
   mesmo usuário do SO. Separam contexto; não impedem um processo de ler o outro. Onde o
   isolamento importar, é outro usuário/container.
5. **Proibição abstrata perde para instrução concreta.** "Não invente" num prompt que também diz
   "sempre apresente decisão, plano e checklist" produz decisões inventadas para preencher o
   formulário. O formato de saída acima tem "não encontrei" como resposta legítima por isso.
6. **Dado real de empregador/cliente não passa por LLM de terceiro.** Os casos são reconstruídos,
   com nomes e valores trocados.
7. **Upstream que muda sem avisar é pinado.** Hermes e as dependências entram por commit/versão
   fixa, e atualização é decisão.
8. **Economia se mede, não se presume.** Nenhuma peça entra com o argumento "vai economizar" sem
   um número medido contra a alternativa que já existe.
