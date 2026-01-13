#!/bin/bash

implement() {
    echo "Not implemented!"
}

process() {
    local choice=$1
    case "$choice" in
        0)
            echo "Farewell!"
            exit 0
            ;;
        1)
            implement
            ;;
        2)
            implement
            ;;
        3)
            implement
            ;;
        4)
            implement
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
}

echo "Hello $USER!"

while true; do
    echo "------------------------------"
    echo "| Hyper Commander            |"
    echo "| 0: Exit                    |"
    echo "| 1: OS info                 |"
    echo "| 2: User info               |"
    echo "| 3: File and Dir operations |"
    echo "| 4: Find Executables        |"
    echo "------------------------------"
    read -r choice
    process "$choice"
done