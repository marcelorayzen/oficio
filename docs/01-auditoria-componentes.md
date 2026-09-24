# Auditoria dos componentes candidatos (24/09/2026)

Fonte: documentação e READMEs públicos, lidos em 24/09. **Nada foi instalado nem executado.**
Cada linha diz se o fato é **confirmado** (lido na doc/código do próprio projeto), **declarado**
(o projeto afirma, ninguém mediu) ou **desmentido** (a premissa da ideia original não se sustenta).

## Resumo

| peça | premissa da ideia original | o que a leitura mostra | veredito |
|---|---|---|---|
| Hermes **perfis** | "cada profissional com memória própria" | confirmado — é a base real | **usar** |
| Hermes **Bot Mode** | "a camada de equipe" | é plugin do **app desktop (Electron)**; roda sobre perfis | opcional, não é fundação |
| **OpenViking** | "memória + conhecimento + skills para o Hermes" | integração com Hermes é **só memória**; AGPLv3; exige embedding + VLM | adiar |
| **Laya** | "roteamento barato, economiza LLM" | base é **quase aleatória zero-shot** nas decisões tipadas; precisa fine-tuning | adiar, medir antes |
| **Browser Use** | "as mãos do agente" | Hermes já tem browser nativo; Browser Use é backend de **nuvem** | último a entrar |
| Scientific Skills | "exemplo de especialização" | confirmado como referência de formato | referência |
| Cybersecurity Skills | "da Anthropic" | **desmentido** — comunitário, sem afiliação | referência |
| skills de governança/LGPD | não estava no Reel | **existem** — DataHub, LGPD, privacidade | **ler antes de escrever as nossas** |

---

## Hermes — perfis (a fundação)

**Confirmado:**
- Cada perfil tem diretório próprio com `config.yaml`, `.env`, `SOUL.md`, memórias, sessões,
  skills, cron e `state.db`.
- Toolsets são configurados por perfil no `config.yaml` → dá para dar ferramentas diferentes a
  cada profissional.
- Rodam em paralelo: `hermes -p <perfil> chat`, um gateway por perfil, e o dashboard alterna entre
  perfis.
- O mecanismo é `HERMES_HOME=~/.hermes/profiles/<nome>`.

**O que isso NÃO é:** fronteira de segurança. Mesmo usuário do SO, mesmo disco. Um perfil com
ferramenta de terminal lê o `.env` do outro. Separação de **contexto**, não de **privilégio**.

**Atenção:** `hermes update` sincroniza skills *bundled* para **todos** os perfis
automaticamente — um perfil de governança pode ganhar skill que ninguém escolheu. Verificar se há
como desligar; senão, conferir após cada update.

## Hermes — Bot Mode

**Confirmado:**
- Lançado em ago/2026. Hoje embutido no Hermes Desktop (repositório original arquivado,
  desenvolvimento em `apps/desktop/src/plugins/hermes-bots/`).
- "This is a desktop plugin — it must be installed on the machine running the Hermes desktop
  app, not on the gateway."
- Cada bot = um perfil. Sem armazenamento próprio ("no extra storage").
- Bot-para-bot é **invocação de CLI**: `hermes -p <bot> chat ... -q "Message from ..."`.
- Salas de 2–6 bots, até 3 rodadas seriais por mensagem.
- Rotinas = cron do Hermes por perfil.
- Limitação declarada: entrega bot-a-bot é por invocação; interromper um bot no meio é trabalho
  futuro.

**Consequência:** Bot Mode é **interface** sobre perfis, não arquitetura. Não aparece no
`hermes dashboard` web nem num servidor headless. A fundação são os perfis; Bot Mode é uma
forma de usá-los no desktop. Bot conversando com bot **não tem gate de aprovação próprio** —
é o problema do princípio 2 (aprovação por risco, não por rota) na forma mais pura.

## OpenViking

**Confirmado:**
- Licença **AGPLv3** (CLI/exemplos Apache 2.0). Relevante se isto virar produto oferecido a
  terceiros por rede.
- Exige Python 3.10+, **modelo de embedding e um VLM** (Volcengine, OpenAI, Kimi, GLM, Ollama
  local).
- Hierarquia `viking://resources/`, `viking://user/{id}/{memories,resources,skills,peers}`;
  camadas L0 (resumo de uma frase) / L1 (visão geral) / L2 (original).
- Servidor com contas, isolamento de usuário e ACL opcional de recurso.
- Versão 0.3.x — pré-1.0.
- Integração com Hermes: provedor de **memória** nativo, por HTTP (porta padrão 1933).

**Desmentido em parte:** a ideia original dizia "combina memória, conhecimento e skills para o
Hermes". A integração documentada com o Hermes é **só memória** — skills continuam sendo as do
Hermes.

**Declarado, não medido:** "reduz consumo de tokens em até 91%". A extração de memória chama
LLM/VLM; o custo real por sessão não está documentado.

**Veredito:** adiar. A memória nativa do Hermes basta para o piloto. OpenViking entra se, com os
casos de avaliação rodando, faltar recuperação de conhecimento — e aí com número na mão.

## Laya (Convai Innovations)

Repositório original: `NandhaKishorM/laya` (há muitos forks idênticos — cuidado com a origem).
Modelos no Hugging Face em `convaiinnovations/`.

**Confirmado:**
- Apache 2.0.
- Três checkpoints: inglês (ModernBERT-large, 421M, 512 tokens), multilíngue (mmBERT-base, 322M,
  1024 tokens, 100+ idiomas — **o único que serve para português**), e `typed-decisions`.
- Não gera texto: responde `choice` (probabilidade por opção), `score` (distribuição numa
  rubrica) e `noul` (P(verdadeiro)).
- Latência **em GPU T4**: 33–40 ms por pergunta.
- **Latência em CPU: ~193–464 ms** por requisição (modo preload). O servidor alvo não tem GPU.
- Tem servidor MCP (stdio) e runtimes ONNX em Go, Node e Ruby.

**O achado que muda a conta:**
> "Base checkpoints are near chance on typed-decisions zero-shot... 0.766 figure comes from the
> checkpoint fine-tuned on that benchmark's own training split."

Ou seja: com rótulos nossos (`governance` / `qa` / `security`, "precisa aprovação?"), o modelo
**de prateleira não acerta melhor que o acaso**. O 0.766 exige treinar com dados do próprio
domínio — que ainda não existem.

**Veredito:** adiar. Para rotear entre 2–3 profissionais, a pessoa escolher o perfil, ou um LLM
local pequeno, resolve. Laya passa a fazer sentido quando houver (a) volume que justifique e (b)
centenas de decisões rotuladas — que os próprios `evals/` e o uso real vão produzir. A comparação
justa é contra um LLM local pequeno, no mesmo hardware, com as mesmas decisões.

## Browser Use

**Confirmado:**
- O Hermes **já tem** ferramentas de browser (`browser_navigate`, `browser_click`,
  `browser_snapshot`) sobre Chromium local.
- Browser Use entra como **backend de nuvem** (perfis anti-detecção, proxies residenciais) ou
  CLI que o Hermes dirige.

**Veredito:** último a entrar. Para o piloto, o browser nativo basta — e mesmo ele fica
desligado até os casos de só-leitura estarem verdes. Browser em sistema corporativo significa
credencial na mão do agente; e browser na nuvem significa a tela do sistema passando por
terceiro.

## Bibliotecas de skills

| repositório | o que é | status |
|---|---|---|
| `K-Dense-AI/scientific-agent-skills` | 165–166 skills científicas, padrão Agent Skills | confirmado; referência de formato |
| `mukul975/Anthropic-Cybersecurity-Skills` | ~818 skills, mapeadas a ATT&CK/NIST | **comunitário, sem afiliação à Anthropic** apesar do nome |
| `datahub-project/datahub-skills` | busca, enriquecimento, linhagem e qualidade no DataHub | **relevante para o piloto** |
| `goul4rt/lgpd-skills` | 1 maestro (`lgpd-audit`) + 18 sub-skills LGPD/ANPD | **relevante para o piloto** |
| `mukul975/privacy-data-protection-skills` | 282+ skills de privacidade (inclui LGPD) | relevante; mesmo autor do "Anthropic-Cybersecurity" |
| `kina2711/data-department-agent-skills` | 32 papéis, "evidence gates" | ler pelo desenho de gates |
| `agentskills/agentskills` | especificação do formato `SKILL.md` | o formato a seguir |

**Regra para skill de terceiro:** ler inteira antes de instalar. Skill é instrução que o agente
segue — uma skill de terceiro é código de terceiro rodando com as permissões do profissional.
Nenhuma entra por `install` em lote.

## Não verificado nesta rodada

- Os 7 repositórios exatos do Reel original (a lista não estava disponível; auditados os
  nomeados).
- "Harness Engineering" e "Diagram workflows" — citados sem link.
- Se `hermes update` permite não sincronizar skills bundled num perfil.
- Se o gate `skills.write_approval` vale por perfil ou é global.

## Fontes

- Hermes Bot Mode — https://github.com/NousResearch/Hermes-Bot-Mode
- Hermes perfis — https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/profiles.md
- Hermes browser — https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/browser.md
- OpenViking — https://github.com/volcengine/OpenViking
- OpenViking × Hermes — https://github.com/volcengine/OpenViking/blob/main/docs/en/agent-integrations/05-hermes.md
- Laya — https://github.com/NandhaKishorM/laya · https://huggingface.co/convaiinnovations/laya
- Browser Use × Hermes — https://docs.browser-use.com/cloud/tutorials/integrations/hermes-agent
- Scientific skills — https://github.com/K-Dense-AI/scientific-agent-skills
- Cybersecurity skills — https://github.com/mukul975/anthropic-cybersecurity-skills
- DataHub skills — https://github.com/datahub-project/datahub-skills
- LGPD skills — https://github.com/goul4rt/lgpd-skills
- Privacy skills — https://github.com/mukul975/privacy-data-protection-skills
- Data department skills — https://github.com/kina2711/data-department-agent-skills
- Agent Skills spec — https://github.com/agentskills/agentskills
