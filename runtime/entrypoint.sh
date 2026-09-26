#!/usr/bin/env bash
#
# Liga identidade, config e skills do repositório ao `$HERMES_HOME` a cada subida.
#
# Por LINK, nunca por bind de arquivo: bind de arquivo aponta para o inode, e `git pull` troca o
# inode (escreve outro arquivo e renomeia por cima). O container seguiria lendo a versão antiga,
# sem erro. Medido no Rayzen em 15/09. Diretório montado + link resolve pelo caminho a cada leitura.
set -euo pipefail

HERMES_HOME="${HERMES_HOME:-/home/oficio/.hermes}"
mkdir -p "$HERMES_HOME/skills"

ln -sfn /opt/oficio/perfil/SOUL.md     "$HERMES_HOME/SOUL.md"
ln -sfn /opt/oficio/perfil/config.yaml "$HERMES_HOME/config.yaml"

# Uma pasta por ofício, com a estrutura intacta: as skills citam `../referencias/`, e isso só
# resolve se o diretório do ofício inteiro estiver ligado, não skill a skill.
for oficio in governanca qa; do
  ln -sfn "/opt/oficio/skills/$oficio" "$HERMES_HOME/skills/$oficio"
done

# Falhar é melhor que subir sem identidade: sem SOUL o modelo responde com a personalidade base,
# indistinguível de "está funcionando" para quem olha de fora.
for alvo in "$HERMES_HOME/SOUL.md" "$HERMES_HOME/config.yaml" \
            "$HERMES_HOME/skills/governanca/avaliar-ativo/SKILL.md" \
            "$HERMES_HOME/skills/qa/analisar-testabilidade/SKILL.md"; do
  if [ ! -r "$alvo" ]; then
    echo "[oficio] FATAL: $alvo não resolve — o repositório foi montado?" >&2
    exit 1
  fi
done

# O agente NUNCA pode ver os gabaritos. A montagem do compose não os inclui; isto confere.
if [ -e /opt/oficio/evals ] || [ -e /opt/oficio/ferramentas ]; then
  echo "[oficio] FATAL: evals/ ou ferramentas/ visíveis ao agente — ver o gabarito invalida a medição" >&2
  exit 1
fi

echo "[oficio] identidade $(wc -c < "$HERMES_HOME/SOUL.md") bytes; skills: governanca, qa"
exec "$@"
