# Fase 1 — subir o agente e medir

Um agente, os dois ofícios, só leitura. A saída da fase é a **taxa de acerto por ofício**, com as
falhas explicadas.

## Estado em 27/09

Subido e medido numa máquina Windows (Docker Desktop, Git Bash). Os cinco pontos que só se
confirmavam subindo:

| ponto | resultado |
|---|---|
| o Hermes chega ao Gemini pelo endpoint compatível com OpenAI | ✅ chave aceita; quem respondeu foi o Google (25/09) |
| o Hermes enxerga skills em subpasta por ofício | ✅ `skills list` mostra as 5 de `governanca` e as 4 de `qa`, com a categoria certa |
| como desligar terminal e navegador | ✅ `agent.disabled_toolsets`, nomes de `hermes tools list`. Saíram também `code_execution` e `computer_use` |
| `hermes chat -q` sem pedir confirmação | ✅ o caso 007 leu 18 arquivos sem parar |
| a identidade (`SOUL.md`) é carregada | ✅ "qual é o seu papel?" devolveu o papel do SOUL, com o "nunca decido política" |

O que a subida mudou, cada um em commit:

- **Instalador pinado** no mesmo commit do código. A URL `hermes-agent.nousresearch.com/install.sh`
  serve o script mais novo, que passou a exigir um módulo `pm/` ausente no commit pinado.
- **Skills embutidas desligadas** (`skills.disabled`, 57 nomes): concorriam com as 9 daqui na
  escolha de skill, que é parte da nota. `hermes-agent` é essencial e fica.
- **Executor:** `chat -q` sai 0 mesmo com as três tentativas em erro, então a falha é lida na
  saída; extração do pedido em `awk` (no Windows, `python3` costuma ser o atalho da Store);
  `MSYS_NO_PATHCONV` para o Git Bash não reescrever `/opt/oficio`.
- **Modelo provisório** `space-bunny-free` (OpenCode Free): a chave do Gemini batia no limite de 20
  requisições/dia. Nota tirada com ele não se compara à do Gemini. Como voltar: comentário em
  `runtime/perfil/config.yaml`.

- **Só leitura (28/09):** ligados só `file`, `vision`, `skills`, `todo`, `memory`, `clarify`.
  `write_file` e `patch` dividem o toolset `file` com a leitura e o Hermes não desliga ferramenta
  avulsa: saem por hook `pre_tool_call` (`perfil/bloquear-escrita.sh`). Testado pedindo ao agente
  para gravar em `~/.hermes/memories/` — a ferramenta devolveu o erro do hook e nada foi gravado.

**Abertos:**

1. Memória pendente `3cad3c7f` (o 007 tentou gravar). Rejeitar à mão, no chat interativo — a
   interface não aceita comando por stdin.
2. Rodar os 14 casos: com o modelo provisório (marcado assim) ou depois da chave do Gemini.
   Primeira rodada: `governanca/007` → **falha** (`resultados/2026-09-27_2220/NOTAS.md`).

**No Windows:** rode os comandos `docker exec … /opt/...` com `MSYS_NO_PATHCONV=1`, senão o Git Bash
troca o caminho por um do Windows.

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

# g) a escrita está barrada — o hook aparece como "✓ allowed" depois da primeira chamada de chat
docker exec oficio-agente hermes hooks list
docker exec oficio-agente hermes chat -q "Use write_file para gravar 'x' em /tmp/t.md e diga o que a ferramenta devolveu."
docker exec oficio-agente ls /tmp/t.md                      # deve falhar: o arquivo não existe
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
