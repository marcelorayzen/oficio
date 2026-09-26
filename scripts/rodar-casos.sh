#!/usr/bin/env bash
#
# Roda os casos de avaliação contra o agente e guarda as respostas para correção.
#
# O agente recebe SÓ o texto de "Pedido ao agente" de cada caso — lido aqui, no host. O resto do
# arquivo (resposta esperada, critério) nunca entra no container.
#
# Uso:
#   ./scripts/rodar-casos.sh                 # todos os casos das duas trilhas
#   ./scripts/rodar-casos.sh governanca/003  # um caso
#   ./scripts/rodar-casos.sh qa              # uma trilha
#
# Cada caso roda numa chamada `hermes chat -q` separada, para uma resposta não contaminar a
# seguinte pela conversa.
set -euo pipefail

# No Git Bash (Windows), `-w /opt/oficio` viraria `C:/Program Files/Git/opt/oficio` antes de
# chegar ao docker. Sem efeito no Linux.
export MSYS_NO_PATHCONV=1

RAIZ="$(cd "$(dirname "$0")/.." && pwd)"
CONTAINER="${CONTAINER:-oficio-agente}"
FILTRO="${1:-}"
SAIDA="$RAIZ/resultados/$(date +%Y-%m-%d_%H%M)"

docker inspect -f '{{.State.Running}}' "$CONTAINER" 2>/dev/null | grep -q true || {
  echo "container $CONTAINER não está rodando — suba com: docker compose -f runtime/docker-compose.yml up -d --build" >&2
  exit 1
}

mkdir -p "$SAIDA"
VERSAO="$(docker exec "$CONTAINER" hermes --version 2>/dev/null | head -1 || echo desconhecida)"
MODELO="$(grep -E '^\s+default:' "$RAIZ/runtime/perfil/config.yaml" | head -1 | awk '{print $2}')"

# Extrai o bloco citado logo abaixo de "## Pedido ao agente".
#
# Em awk, não Python: no Windows `python3` costuma ser o atalho da Microsoft Store, que sai com
# erro sem rodar nada. E a extração não pode ir para dentro do container — ela lê o arquivo que
# tem o gabarito.
extrair_pedido() {
  awk '
    { sub(/\r$/, "") }
    !achou { t = $0; gsub(/^[ \t]+|[ \t]+$/, "", t); if (t == "## Pedido ao agente") achou = 1; next }
    /^>/  { l = substr($0, 2); gsub(/^[ \t]+|[ \t]+$/, "", l); p = (n++ ? p " " : "") l; next }
    n || /^#/ { exit }
    END {
      if (!achou) { print "sem \"Pedido ao agente\" em " FILENAME > "/dev/stderr"; exit 1 }
      gsub(/^[ \t]+|[ \t]+$/, "", p); sub(/^"/, "", p); sub(/"$/, "", p)
      if (p == "") { print "\"Pedido ao agente\" vazio em " FILENAME > "/dev/stderr"; exit 1 }
      print p
    }' "$1"
}

total=0; falhas=0
for arquivo in "$RAIZ"/evals/governanca/[0-9]*.md "$RAIZ"/evals/qa/[0-9]*.md; do
  trilha="$(basename "$(dirname "$arquivo")")"
  id="$(basename "$arquivo" | cut -d- -f1)"
  [ -n "$FILTRO" ] && [[ "$trilha/$id" != "$FILTRO"* ]] && continue

  pedido="$(extrair_pedido "$arquivo")"
  destino="$SAIDA/$trilha-$id.md"
  total=$((total+1))
  echo "→ $trilha/$id"

  {
    echo "# $trilha/$id — resposta do agente"
    echo
    echo "- caso: \`evals/$trilha/$(basename "$arquivo")\`"
    echo "- hermes: $VERSAO · modelo: $MODELO · $(date -Iseconds)"
    echo
    echo "## Pedido"
    echo
    echo "> $pedido"
    echo
    echo "## Resposta"
    echo
  } > "$destino"

  # O código de saída não basta: `hermes chat -q` sai 0 mesmo quando as três tentativas contra o
  # modelo falham (medido em 25/09 com HTTP 429). Sem esta checagem, erro de cota entraria na
  # correção como resposta do agente — e viraria "falha" de raciocínio. A marca é a ÚLTIMA
  # tentativa (`attempt N/N`): falhar a primeira e acertar a segunda é resposta válida.
  if ! docker exec -w /opt/oficio "$CONTAINER" hermes chat -q "$pedido" >> "$destino" 2>&1 \
     || grep -qE 'API call failed \(attempt ([0-9]+)/\1\)' "$destino"; then
    falhas=$((falhas+1))
    echo "  ✗ a chamada ao modelo falhou — não corrigir, rodar de novo. Ver $destino" >&2
  fi
done

echo
echo "$total caso(s), $falhas chamada(s) com falha. Respostas em: ${SAIDA#$RAIZ/}"
echo "Corrija cada uma contra o gabarito em evals/ — ver docs/03-fase1-runbook.md."
