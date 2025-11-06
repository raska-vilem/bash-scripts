#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$REPO_DIR/scripts"
ALIASES_DIR="$REPO_DIR/aliases"
INIT_SCRIPT="rc.sh"

if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed. Please install Git and try again.${NC}"
    exit 1
fi

configure_shell_profile() {
    local shell_profile="$1"
    local shell_name="$2"

    touch "$shell_profile"

    SCRIPT_LOADER="source $REPO_DIR/rc.sh $REPO_DIR"

    if ! grep -q "$SCRIPT_LOADER" "$shell_profile"; then
        echo "$SCRIPT_LOADER" >> "$shell_profile"

        echo -e "${GREEN}Installation complete!${NC}"
        echo -e "${YELLOW}Please restart your terminal to apply changes.${NC}"
    else
        echo -e "${YELLOW}Script loader already configured in $shell_name profile${NC}"
    fi
}

chmod +x "$SCRIPTS_DIR"/*


if [[ "$SHELL" == *"zsh"* ]]; then
    configure_shell_profile "$HOME/.zshrc" "Zsh"
elif [[ "$SHELL" == *"bash"* ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        configure_shell_profile "$HOME/.bash_profile" "Bash"
    else
        configure_shell_profile "$HOME/.bashrc" "Bash"
    fi
else
    echo -e "${YELLOW}Unsupported shell: $SHELL${NC}"
    echo -e "${YELLOW}Please manually add $SCRIPTS_DIR to your PATH${NC}"
    exit 1
fi
