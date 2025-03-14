#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <file_name> <command> [options]"
    echo "Use '$0 <file_name> -h or --help' to view the list of commands."
    exit 1
fi

FILE=$1
COMMAND=$2
OPTION=$3

help_function() {
    RED='\033[1;31m'          
    YELLOW='\033[1;33m'   
    ORANGE='\033[38;5;214m' 
    NC='\033[0m'         

    echo "==========================================================================================================="
    echo -e "${YELLOW}    ____        __                                 ___                __           _                ${NC}"
    echo -e "${YELLOW}   / __ \____  / /_____  ____ ___  ____  ____     /   |  ____  ____ _/ /_  _______(_)___  ___  _____${NC}"
    echo -e "${ORANGE}  / /_/ / __ \/ //_/ _ \/ __ \`__ \/ __ \/ __ \   / /| | / __ \/ __ \`/ / / / / ___/ /_  / / _ \/ ___/${NC}"
    echo -e "${RED} / ____/ /_/ / ,< /  __/ / / / / / /_/ / / / /  / ___ |/ / / / /_/ / / /_/ (__  ) / / /_/  __/ /    ${NC}"
    echo -e "${RED}/_/    \____/_/|_|\___/_/ /_/ /_/\____/_/ /_/  /_/  |_/_/ /_/\__,_/_/\__, /____/_/ /___/\___/_/     ${NC}"
    echo -e "${YELLOW}                                                                    /____/                          ${NC}"
    echo "==========================================================================================================="
    echo "Usage: $0 <file_name> <command> [options]"
    echo "Commands:"
    echo "  --h, --help              Display this help screen"
    echo "  --i, --info              Display highest adjusted and raw usage"
    echo "  --sort <column>          Sort data by the specified column"
    echo "    Pokemon                Sort data by Pokemon name"
    echo "    Usage%                 Sort data by Usage%"
    echo "    RawUsage               Sort data by Raw Usage"
    echo "    HP                     Sort data by HP"
    echo "    Atk                    Sort data by Atk"
    echo "    Def                    Sort data by Def"
    echo "    SpAtk                  Sort data by Special Attack"
    echo "    SpDef                  Sort data by Special Defense"
    echo "    Speed                  Sort data by Special Speed"
    echo "  --grep <pokemon_name>    Search for specific Pokemon"
    echo "  --filter <type>          Filter Pokemon by type and sort by Usage"
    echo "------------------------------------------------------------------------------------------------------------"
    echo "Examples:"
    echo "  $0 pokemon_usage.csv --info"
    echo "  $0 pokemon_usage.csv --sort Usage%"
    echo "  $0 pokemon_usage.csv --grep rotom"
    echo "  $0 pokemon_usage.csv --filter Dark"
    echo "============================================================================================================="
    exit 0
}

info_function() {
    echo "==============================================================="
    echo "Summary of $FILE"
    echo "==============================================================="
    echo "Highest Adjusted Usage:"
    tail -n +2 "$FILE" | sort -t, -k2 -nr | head -1
    echo "---------------------------------------------------------------"
    echo "Highest Raw Usage:"
    tail -n +2 "$FILE" | sort -t, -k3 -nr | head -1
    echo "---------------------------------------------------------------"
}

sort_function() {
    HEADER=$(head -1 "$FILE")
    echo "$HEADER"

    if [ -z "$OPTION" ]; then
        echo "Error: No sorting column provided"
        exit 1
    fi

    if ! echo "$HEADER" | grep -q -w "$OPTION"; then
        echo "Error: Column '$OPTION' not found in file."
        exit 1
    fi

    COLUMN=$(echo "$HEADER" | tr ',' '\n' | grep -n -w "$OPTION" | cut -d: -f1 | head -1)
    if [ "$OPTION" == "Pokemon" ]; then
        tail -n +2 "$FILE" | sort -t, -k1,1
    else
        tail -n +2 "$FILE" | sort -t, -k"$COLUMN" -nr
    fi
}

search_function() {
    HEADER=$(head -1 "$FILE")
    echo "$HEADER"

    if [ -z "$OPTION" ]; then
        echo "Error: No search term provided"
        exit 1
    fi 

    grep -i "^$OPTION" "$FILE"   
}

filter_function() {
    HEADER=$(head -1 "$FILE")
    echo "$HEADER"

    if [ -z "$OPTION" ]; then
        echo "Error: No filter type provided"
        exit 1
    fi

    awk -F, -v type="$OPTION" '$4 == type || $5 == type' "$FILE" | sort -t, -k2 -nr
}

case "$COMMAND" in
    --h|--help)
        help_function
        ;;
    --i|--info)
        info_function
        ;;
    --sort)
        sort_function
        ;;
    --grep)
        search_function
        ;;
    --filter)
        filter_function
        ;;
    *)
        echo "Error: Invalid command"
        echo "Use '$0 <file_name> -h or --help' to view the list of commands."
        exit 1
        ;;
esac
