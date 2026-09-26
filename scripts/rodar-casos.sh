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
extrair_pedido() {
  python3 - "$1" <<'PY'
import sys, re
linhas = open(sys.argv[1], encoding="utf-8").read().splitlines()
try:
    i = next(n for n, l in enumerate(linhas) if l.strip() == "## Pedido ao agente")
except StopIteration:
    sys.exit(f"sem 'Pedido ao agente' em {sys.argv[1]}")
citadas = []
for l in linhas[i + 1:]:
    if l.startswith(">"):
        citadas.append(l[1:].strip())
    elif citadas or l.startswith("#"):
        break          # fim do bloco citado (ou próxima seção sem pedido)
pedido = " ".join(citadas).strip()
if not pedido:
    sys.exit(f"'Pedido ao agente' vazio em {sys.argv[1]}")
print(re.sub(r'^"|"$', "", pedido))
PY
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

  if ! docker exec -w /opt/oficio "$CONTAINER" hermes chat -q "$pedido" >> "$destino" 2>&1; then
    falhas=$((falhas+1))
    echo "  ✗ a chamada falhou — ver $destino" >&2
  fi
done

echo
echo "$total caso(s), $falhas chamada(s) com falha. Respostas em: ${SAIDA#$RAIZ/}"
echo "Corrija cada uma contra o gabarito em evals/ — ver docs/03-fase1-runbook.md."
