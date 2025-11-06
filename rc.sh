#!/bin/bash

REPO_DIR=$1

# Load all aliases
for file in "$REPO_DIR"/aliases/*.sh; do
    [ -f "$file" ] && source "$file"
done

# Add scripts folder to path
export PATH="$PATH:$REPO_DIR/scripts"
