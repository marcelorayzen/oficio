# Fase 1 — subir o agente e medir

Um agente, os dois ofícios, só leitura. A saída da fase é a **taxa de acerto por ofício**, com as
falhas explicadas.

## O que já está pronto e o que falta confirmar

Os arquivos de `runtime/` reaproveitam a receita do Hermes que roda no Rayzen: o mesmo commit
fixado, o mesmo schema de config (44) e as mesmas lições (link em vez de bind de arquivo, Node fora
do volume, gates de escrita ligados). **Nada disso foi executado ainda neste repositório.** Cinco
pontos não puderam ser verificados sem subir, e o passo 3 existe para eles:

| ponto | por que é dúvida |
|---|---|
| o Hermes chega ao Gemini pelo endpoint compatível com OpenAI | no Rayzen ele passa pelo LiteLLM; aqui vai direto, sem dependência do Rayzen |
| o Hermes enxerga skills em subpasta por ofício (`skills/governanca/<skill>/`) | as skills foram ligadas por ofício para preservar `../referencias/` |
| como desligar as ferramentas de terminal e navegador | o plano pede o agente sem as duas, e a chave de config não foi conferida — escrever uma chave errada seria config que não vale sem nada acusar |
| `hermes chat -q` roda sem pedir confirmação para ler arquivos | o executor dos casos não é interativo |
| a identidade (`SOUL.md`) é carregada | no Rayzen foi provado com uma regra observável; aqui ainda não |

## Pré-requisitos

- Docker com Compose; **~6 GB** de disco para a imagem (o Hermes sozinho tem ~5 GB).
- Uma chave da API do Gemini (Google AI Studio). Os casos usam só dado sintético.
- Qualquer máquina serve. No servidor H81, o limite de 1,5 CPU e 2 GB do compose evita disputar
  com o Rayzen — e, antes de buildar, confira que nenhum deploy do Rayzen está rodando
  (`ps aux | grep rayzen-deploy.sh`), porque os dois builds juntos disputam a máquina.

## 1. Chave

```bash
cp runtime/.env.example runtime/.env
# preencha LM_API_KEY e OPENAI_API_KEY com a mesma chave
```

## 2. Subir

```bash
docker compose -f runtime/docker-compose.yml up -d --build
docker logs oficio-agente     # deve mostrar: [oficio] identidade … bytes; skills: governanca, qa
```

O entrypoint **se recusa a subir** se o SOUL, o config ou as skills não resolverem, e também se
`evals/` estiver visível ao agente.

## 3. Conferir antes de medir

```bash
# a) o agente só vê base, skills e perfil
docker exec oficio-agente ls /opt/oficio                    # base  perfil  skills

# b) config no schema certo
docker exec oficio-agente hermes config check

# c) o modelo responde
docker exec oficio-agente hermes chat -q "Responda só: ok"

# d) as skills dos dois ofícios aparecem
docker exec oficio-agente hermes skills list

# e) ferramentas disponíveis — terminal e navegador precisam sair
docker exec oficio-agente hermes tools --help

# f) a identidade foi carregada
docker exec oficio-agente hermes chat -q "Em uma frase: qual é o seu papel e quais são seus ofícios?"
```

**Me mande a saída de c, d, e, f.** Se algum falhar, o conserto vai em commit — nunca à mão no
container, porque ajuste manual em estado persistente é ajuste que ninguém sabe reconstruir.

Se (d) não listar as skills: o Hermes não lê subpasta, e o entrypoint passa a ligar skill a skill.
Se (e) mostrar terminal ou navegador: a forma de desligar entra no `config.yaml` com o nome
conferido na saída.

## 4. Rodar os casos

Comece pelo controle, que é barato e diz muito:

```bash
./scripts/rodar-casos.sh governanca/007
```

Depois tudo:

```bash
./scripts/rodar-casos.sh
```

As respostas vão para `resultados/<data>_<hora>/`, uma por caso. O agente recebe **só** o texto de
"Pedido ao agente"; o gabarito nunca sai do host.

**Entre rodadas**, confira que nada ficou pendente na memória ou nas skills — uma rodada não pode
ensinar a seguinte:

```bash
docker exec -it oficio-agente hermes chat     # e dentro: /memory pending  e  /skills pending
```

Rejeite o que houver e anote o que o agente tentou gravar: isso também é resultado.

## 5. Corrigir

Para cada resposta, contra o gabarito em `evals/`:

| nota | quando |
|---|---|
| **acerto** | todos os obrigatórios, nenhum erro grave |
| **parcial** | todos os obrigatórios, mas faltou esperado relevante |
| **falha** | faltou obrigatório **ou** houve erro grave |

Registre em `resultados/<data>_<hora>/NOTAS.md`: caso, nota, o que faltou, se escolheu a skill
certa. A taxa sai **por ofício** — governança e QA separadas.

> Os gabaritos de QA ainda não passaram pela revisão de Marcelo. A nota de QA desta rodada mede,
> em parte, concordância com o Claude — dizer isso junto com o número.

## Depois

Com a nota na mão, o plano segue: falhas de raciocínio → ajustar skills; falhas de recuperação
(o agente não achou o arquivo) → Fase 2, ferramentas de leitura. Nenhuma peça nova entra sem esse
número.
