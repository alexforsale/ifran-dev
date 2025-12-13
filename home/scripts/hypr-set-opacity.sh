#!/usr/bin/env bash
MEMORY_FILE="/tmp/hypr_alpha_memory.json"
OPACITY_STEP=0.05
MIN_OPACITY=0.1
MAX_OPACITY=1.0
DEFAULT_ALPHA=1.0

touch $MEMORY_FILE
[[ ! -s $MEMORY_FILE ]] && echo "{}" > "$MEMORY_FILE"

ADDR=$(hyprctl activewindow -j | jq -r '.address')

DIRECTION="$1"
[[ -z "$ADDR" || "$ADDR" == "null" ]] && exit 1

[[ -z "$ADDR" || "$ADDR" == "null" ]] && exit 1

CURRENT_ALPHA=$(cat "$MEMORY_FILE" | jq -r --arg addr "$ADDR" '.[$addr] // 1.0')
case "$DIRECTION" in
    --increase)
        NEW_ALPHA=$(echo "$CURRENT_ALPHA + $OPACITY_STEP" | bc)
        (( $(echo "$NEW_ALPHA > $MAX_OPACITY" | bc -l) )) && NEW_ALPHA=$MAX_OPACITY
        ;;
    --decrease)
        NEW_ALPHA=$(echo "$CURRENT_ALPHA - $OPACITY_STEP" | bc)
        (( $(echo "$NEW_ALPHA < $MIN_OPACITY" | bc -l) )) && NEW_ALPHA=$MIN_OPACITY
        ;;
    --reset)
        NEW_ALPHA=$DEFAULT_ALPHA
        ;;
    *)
        exit 1
        ;;
esac

for PROP in alpha alphainactive alphafullscreen alphaoverride; do
    hyprctl dispatch setprop "address:$ADDR" "$PROP" "$NEW_ALPHA"
done

TMP=$(mktemp)
cat "$MEMORY_FILE" | jq --arg addr "$ADDR" --argjson val "$NEW_ALPHA" '. + {($addr): $val}' > "$TMP" && mv "$TMP" "$MEMORY_FILE"
