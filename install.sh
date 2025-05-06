#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$REPO_DIR/scripts"

if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed. Please install Git and try again.${NC}"
    exit 1
fi

configure_shell_profile() {
    local shell_profile="$1"
    local shell_name="$2"

    touch "$shell_profile"

    if ! grep -q "# START VILEM SCRIPTS" "$shell_profile"; then
        echo "" >> "$shell_profile"
        echo "# START VILEM SCRIPTS" >> "$shell_profile"
        echo "if [ -d \"$SCRIPTS_DIR\" ]; then" >> "$shell_profile"
        echo "    if [[ \":\$PATH:\" != *\":$SCRIPTS_DIR:\"* ]]; then" >> "$shell_profile"
        echo "        export PATH=\"\$PATH:$SCRIPTS_DIR\"" >> "$shell_profile"
        echo "    fi" >> "$shell_profile"
        echo "    (cd \"$REPO_DIR\" && git pull -q >/dev/null 2>&1 &)" >> "$shell_profile"
        echo "fi" >> "$shell_profile"
        echo "# END VILEM SCRIPTS" >> "$shell_profile"
        echo -e "${GREEN}Successfully configured $shell_name profile at $shell_profile${NC}"
    else
        echo -e "${YELLOW}Scripts path already configured in $shell_name profile${NC}"
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

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}Please restart your terminal or run 'source ~/.bashrc' or 'source ~/.zshrc' to apply changes.${NC}"

export PATH="$PATH:$SCRIPTS_DIR"
echo -e "${GREEN}Scripts are available in the current session.${NC}"
