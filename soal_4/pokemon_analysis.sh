#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <file_name> <command> [options]"
    echo "Use '$0 <file_name> -h or --help' to view the list of commands."
    exit 1
fi

file=$1
command=$2
option=$3

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
    echo "  -h, --help               Display this help screen"
    echo "  -i, --info               Display highest adjusted and raw usage"
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
    echo "Summary of $file"
    echo "==============================================================="
    echo "Highest Adjusted Usage:"
    tail -n +2 "$file" | sort -t, -k2 -nr | head -1
    echo "---------------------------------------------------------------"
    echo "Highest Raw Usage:"
    tail -n +2 "$file" | sort -t, -k3 -nr | head -1
    echo "---------------------------------------------------------------"
}

sort_function() {
    header=$(head -1 "$file")
    echo "$header"

    if [ -z "$option" ]; then
        echo "Error: No sorting column provided."
        echo "Use '$0 <file_name> -h or --help' to view the list of commands."
        exit 1
    fi

    if ! echo "$header" | grep -q -w "$option"; then
        echo "Error: Column '$option' not found in file."
        echo "Use '$0 <file_name> -h or --help' to view the list of commands."
        exit 1
    fi

    COLUMN=$(echo "$header" | tr ',' '\n' | grep -n -w "$option" | cut -d: -f1 | head -1)
    if [ "$option" == "Pokemon" ]; then
        tail -n +2 "$file" | sort -t, -k1,1
    else
        tail -n +2 "$file" | sort -t, -k"$COLUMN" -nr
    fi
}

search_function() {
    header=$(head -1 "$file")
    echo "$header"

    if [ -z "$option" ]; then
        echo "Error: No search term provided"
        echo "Use '$0 <file_name> -h or --help' to view the list of commands."
        exit 1
    fi 

    search=$(grep -i "^$option" "$file")
    echo "$search"

    if [ -z "$search" ]; then
        echo "Error: '$option' not found in file."
        echo "Use '$0 <file_name> -h or --help' to view the list of commands."
        exit 1
    fi
}

filter_function() {
    header=$(head -1 "$file")
    echo "$header"

    if [ -z "$option" ]; then
        echo "Error: No filter type provided"
        echo "Use '$0 <file_name> -h or --help' to view the list of commands."
        exit 1
    fi

    filter=$(awk -F, -v type="$option" '$4 == type || $5 == type' "$file" | sort -t, -k2 -nr)
    echo "$filter"

    if [ -z "$filter" ]; then
        echo "Error: '$option' not found in file."
        echo "Use '$0 <file_name> -h or --help' to view the list of commands."
        exit 1
    fi
}

case "$command" in
    -h|--help)
        help_function
        ;;
    -i|--info)
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
