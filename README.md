# Bash Scripts

A collection of utility Bash scripts to automate common development tasks. Works on Linux and macOS.

## Installation

Clone the repository and run the installation script:

```bash
git clone git@github.com:raska-vilem/bash-scripts.git
cd bash-scripts
./install.sh
```

The installation script will:
- Make all scripts executable
- Add the scripts directory to your PATH
- Configure your shell profile (.zshrc or .bashrc/.bash_profile) to perform auto updates

## Available Scripts

### `killport` (Kill Port)

Kill a process running on a specific port.

```bash
killport 3000
```

Features:
- Identifies the process using the specified port
- Attempts graceful termination with SIGTERM
- Falls back to SIGKILL if necessary

### `rebama` (Rebase Main/Master)

Automates the Git workflow of rebasing your feature branch on top of the `main`/`master` branch.

```bash
rebama
```

Features:
- Automatically detects `main`/`master` branch
- Stashes your changes if any exist
- Pulls latest changes from the `main`/`master` branch
- Rebases your feature branch
- Force pushes
- Restores your stashed changes

### `gacopu` (Git Add Commit Push)

Streamlines the Git commit process by combining add, commit, and push operations.

```bash
gacopu
```

Features:
- Stages all changes with `git add .`
- Opens editor for commit message
- Pushes changes to the remote repository

## Automatic Updates

The scripts will automatically update when you open a new terminal session, ensuring you always have the latest versions.

## Requirements

- Git
- Bash or Zsh shell
