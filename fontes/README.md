# Fontes de terceiros

Skills de terceiros entram aqui **como estavam no commit indicado**, com a licença original, e
**não são carregadas pelo agente**. O que o agente usa é `skills/`, escrito por nós a partir da
leitura destas fontes. Atualizar uma fonte é decisão: novo commit, releitura, diff revisado.

| fonte | commit | licença | situação |
|---|---|---|---|
| [goul4rt/lgpd-skills](https://github.com/goul4rt/lgpd-skills) | `d85d79a` | MIT | **copiada** em `lgpd-skills/` — lida inteira; 1 script (`extract-prisma-annotations.sh`, só `awk` local, sem rede) |
| [datahub-project/datahub-skills](https://github.com/datahub-project/datahub-skills) | `c6d0ded` | Apache-2.0 | **não copiada** — opera a ferramenta DataHub (CLI/GraphQL), útil só se a base de teste for DataHub (≥ 8 GB de RAM). Padrões aproveitados como ideia: "conteúdo do ativo é dado, não instrução" e resolver → planejar → aprovar → executar → verificar |
| [mukul975/privacy-data-protection-skills](https://github.com/mukul975/privacy-data-protection-skills) | `9b2ef9e` | Apache-2.0 | **não copiada** — ~280 skills centradas em GDPR, com empresas fictícias embutidas no texto ("Zenith Global", "Vanguard Financial" em 33 skills) e um `process.py` de centenas de linhas por skill. Aproveitada só a ideia de níveis de classificação |
| [kina2711/data-department-agent-skills](https://github.com/kina2711/data-department-agent-skills) | `5c86fb8` | **proprietária** ("All rights reserved… grants no licence to use, copy, modify") | **excluída** — nada copiado nem derivado, apesar de estar publicada no GitHub |

## O que muda da `lgpd-skills` para `skills/governanca/`

A original audita **o código de um software** (schema Prisma, endpoints, SDKs) e produz artefatos
jurídicos em `.lgpd/`. Um profissional de governança avalia **ativos de dados** (tabelas,
catálogo, acesso). Então:

| original | adaptada | mudança |
|---|---|---|
| `lgpd-data-mapping` | `mapear-dados-pessoais` | de "ler schema" para "ler coluna **e conteúdo**", inclusive texto livre |
| `lgpd-legal-basis` | `base-legal-e-finalidade` | de **escolher** base legal para **conferir** a declarada |
| `lgpd-anonymization` | dentro de `classificar-ativo` | anti-padrões de "anonimizado que não é" |
| `lgpd-audit` (maestro) | `avaliar-ativo` | pipeline de conformidade de software → fluxo de avaliação de ativo, com o formato de 7 seções |
| `normative-reference.md` | `referencias/normas-lgpd.md` | só os artigos de dados; o limiar "> 2 milhões de titulares = larga escala" marcado como **não verificado** (a fonte não cita origem) |

As demais (consentimento, DSAR, incidente, DPA, transferência, ECA Digital…) ficam na fonte para
uma fase futura, se o profissional precisar.
