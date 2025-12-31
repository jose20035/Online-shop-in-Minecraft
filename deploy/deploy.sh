#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

SETTINGS_FILE="$SCRIPT_DIR/settings.env"

if [[ ! -f "$SETTINGS_FILE" ]]; then
  echo "ERROR: settings.env no encontrado en deploy/"
  echo "Copia settings.env.example y ajústalo a tu sistema."
  exit 1
fi

# Cargar configuración
# shellcheck disable=SC1090
source "$SETTINGS_FILE"

CC_PATH="$MINECRAFT_DIR/saves/$WORLD_NAME/$CC_SUBPATH"

for ENTRY in "${TARGETS[@]}"; do
  NAME="${ENTRY%%=*}"
  ID="${ENTRY##*=}"

  SRC="$ROOT_DIR/computers/$NAME"
  DST="$CC_PATH/$ID"

  if [[ ! -d "$SRC" ]]; then
    echo "WARNING: no existe computers/$NAME, se omite"
    continue
  fi

  echo "Deploying $NAME -> computer/$ID"

  mkdir -p "$DST"

  rsync -av --delete \
    "$SRC/" "$DST/"
done

echo "Deploy completed successfully."
