#!/usr/bin/env bash
set -e

WORLD="MiMundo"
CC_PATH="$HOME/.minecraft/saves/$WORLD/computercraft/computer"

declare -A TARGETS=(
  [base_station]=3
  [tablet_miner]=5
  [turtle_builder]=12
)

for NAME in "${!TARGETS[@]}"; do
  ID="${TARGETS[$NAME]}"
  TARGET="$CC_PATH/$ID"

  echo "Deploying $NAME -> computer/$ID"

  mkdir -p "$TARGET"

  rsync -av --delete \
    $NAME/ "$TARGET/"
done

echo "Deploy completed."
