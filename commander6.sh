#!/bin/bash

implement() {
    echo "Not implemented!"
}

os_info() {
    uname -o -n
}

user_info() {
    whoami
}


file_operations() {
    local item=$1
    while true; do
        echo -e "---------------------------------------------------------------------"
        echo -e "| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |"
        echo -e "---------------------------------------------------------------------"
        read -r choice
        
        if [[ "$choice" == "0" ]]; then
            break
        elif [[ "$choice" == "1" ]]; then
            rm "$item"
            echo "$item has been deleted."
            break
        elif [[ "$choice" == "2" ]]; then
            echo "Enter the new file name:"
            read -r new_name
            mv -i "$item" "$new_name"
            echo "$item has been renamed as $new_name."
            break
        elif [[ "$choice" == "3" ]]; then
            chmod a=rw "$item"
            echo "Permissions have been updated."
            ls -l "$item"
            break
        elif [[ "$choice" == "4" ]]; then
            chmod o-w "$item"
            echo "Permissions have been updated."
            ls -l "$item"
            break
        fi
    done
}

file_and_dir_operations() {
    while true; do
        echo -e "\nThe list of files and directories:"
        arr=(*)
        for item in "${arr[@]}"; do
            if [[ -f "$item" ]]; then
                echo "F $item"
            elif [[ -d "$item" ]]; then
                echo "D $item"
            fi
        done

        echo ""
        echo "----------------------------------------------------"
        echo "| 0 Main menu | 'up' To parent | 'name' To select |"
        echo "----------------------------------------------------"
        read -r choice

        if [[ "$choice" == "0" ]]; then
            break
        elif [[ "$choice" == "up" ]]; then
            cd ..
        elif [[ -f "$choice" ]]; then
            file_operations "$choice"
        elif [[ -d "$choice" ]]; then
            cd "$choice"
        else
            echo "Invalid input!"
        fi
    done
}

find_executables() {
    echo -e "\nEnter an executable name:"
    read -r exe_name
    path=$(which "$exe_name")
    if [[ -n $path ]]; then
        echo -e "\nLocated in: $path"
        echo -e "\nEnter arguments:"
        read -r args

        $exe_name $args
    else
        echo -e "\nThe executable with that name does not exist!"
    fi
}

process() {
    local choice=$1
    case "$choice" in
        0)
            echo "Farewell!"
            exit 0
            ;;
        1)
            os_info
            ;;
        2)
            user_info
            ;;
        3)
            file_and_dir_operations
            ;;
        4)
            find_executables
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