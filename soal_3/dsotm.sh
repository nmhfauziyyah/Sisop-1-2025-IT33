#!/bin/bash

clear

if [[ "$1" != --play=* ]]; then
    echo "Usage: ./coba5.sh --play=\"<Track>\""
    exit 1
fi

TRACK="${1#--play=}"

echo "Ready, set, go!"

if [[ "$TRACK" == "Speak to Me" ]]; then
    while true; do
        curl -s https://www.affirmations.dev | jq -r '.affirmation'
        sleep 1
    done
elif [[ "$TRACK" == "On the Run" ]]; then
    progress=0
    while [ $progress -lt 100 ]; do
        progress=$((progress + RANDOM % 10))
        [ $progress -gt 100 ] && progress=100
        echo -ne "\r[$(printf '#%.0s' $(seq 1 $((progress / 2))))$(printf ' %.0s' $(seq 1 $((50 - progress / 2))))] $progress%"
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
    done
    echo ""
elif [[ "$TRACK" == "Time" ]]; then
    while true; do
        echo -ne "\r$(date '+%Y-%m-%d %H:%M:%S')"
        sleep 1
    done
elif [[ "$TRACK" == "Money" ]]; then
    clear
    symbols=("$" "€" "£" "¥" "¢" "₹" "₩" "฿" "₣")
    GREEN="\e[32m"
    RESET="\e[0m"

    while true; do
        for ((i = 0; i < $(tput cols) / 2; i++)); do
            x=$(( RANDOM % $(tput cols) + 1 ))
            y=$(( RANDOM % $(tput lines) + 1 ))
            char="${symbols[RANDOM % ${#symbols[@]}]}"
            echo -e "\033[${y};${x}H${GREEN}${char}${RESET}"
        done
        sleep 0.1
        clear
    done
elif [[ "$TRACK" == "Brain Damage" ]]; then
    while true; do
        ps aux --sort=-%mem | head -5
        sleep 1
    done
else
    echo "Track tidak dikenali. Pilih: Speak to Me, On the Run, Time, Money, Brain Damage."
    exit 1
fi
