#!/bin/bash

# If no arguments are provided, prompt the user for input
if [ $# -eq 0 ]; then
    printf "Enter the github project path (i.e. username/project):\n"
    read PROJECT_PATH
else
    PROJECT_PATH=$1
fi

# Exit if no path is given
if [ -z $PROJECT_PATH ]; then
    printf "No plugin given"
    exit 0
fi


# Parse the username and project name from the input
if [[ $PROJECT_PATH =~ github.com/([^/]+)/([^/]+) ]]; then
    PROJECT_PATH="${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
    PLUGIN=$(basename $PROJECT_PATH | tr '[:upper:]' '[:lower:]')
    FILENAME=$HOME/.config/nvim/lua/ricotta/plugins/${PLUGIN%%.*}.lua
elif [[ $PROJECT_PATH =~ ([^/]+)/([^/.]+) ]]; then
    PLUGIN=$(basename $PROJECT_PATH | tr '[:upper:]' '[:lower:]')
    FILENAME=$HOME/.config/nvim/lua/ricotta/plugins/${PLUGIN%%.*}.lua
else
    printf "Please enter the project path in the correct format (i.e. username/project)\n"
    exit 1
fi

# How to configure plugin
SETUP=("Complex" "Simple" "Default" "None")
printf "How do you want to configure the plugin?\n"
select opt in "${SETUP[@]}"; do
    case $opt in
        "Complex")
            # Create file with config function and open in neovim
            nvim -c "normal! ireturn {\"${PROJECT_PATH}\",config = function()require(\"${PLUGIN%%.*}\").setup({})end,}gg=G" -c "normal! :4A" $FILENAME
            break
            ;;
        "Simple")
            # Create file with opts table and open in neovim
            nvim -c "normal! ireturn {\"${PROJECT_PATH}\",opts = {}}gg=G" -c "normal! :3A" $FILENAME
            break
            ;;
        "Default")
            # Create file with config=true
            nvim --headless -c "normal! ireturn {\"${PROJECT_PATH}\",config = true}gg=G" -c "wq" $FILENAME
            # echo "File $FILENAME created successfully."
            break
            ;;
        "None")
            # Create file just calling the plugin
            nvim --headless -c "normal! ireturn {\"${PROJECT_PATH}\"}gg=G" -c "wq" $FILENAME
            # echo "File $FILENAME created successfully."
            break
            ;;
        *) echo "$REPLY is not a valid choice";;
    esac
done

