#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nvim_target="${HOME}/.config/nvim"
tmux_target="${HOME}/.tmux.conf"
tpm_target="${HOME}/.tmux/plugins/tpm"

link_path() {
    local source_path="$1"
    local target_path="$2"

    if [ -L "$target_path" ]; then
        local current_target
        current_target="$(readlink "$target_path")"
        if [ "$current_target" = "$source_path" ]; then
            printf '%s\n' "Already linked: $target_path"
            return
        fi

        printf '%s\n' "Refusing to replace existing symlink: $target_path -> $current_target" >&2
        return 1
    fi

    if [ -e "$target_path" ]; then
        printf '%s\n' "Refusing to overwrite existing path: $target_path" >&2
        printf '%s\n' "Move it away or back it up, then rerun setup.sh." >&2
        return 1
    fi

    mkdir -p "$(dirname "$target_path")"
    ln -s "$source_path" "$target_path"
    printf '%s\n' "Linked: $target_path -> $source_path"
}

link_path "$repo_dir" "$nvim_target"
link_path "$repo_dir/.tmux.conf" "$tmux_target"

if [ ! -d "$tpm_target" ]; then
    if command -v git >/dev/null 2>&1; then
        mkdir -p "$(dirname "$tpm_target")"
        git clone https://github.com/tmux-plugins/tpm "$tpm_target"
        printf '%s\n' "Installed TPM: $tpm_target"
    else
        printf '%s\n' "git not found; skipping TPM install." >&2
    fi
else
    printf '%s\n' "Already installed: $tpm_target"
fi

if command -v nvim >/dev/null 2>&1; then
    nvim --headless "+Lazy! sync" +qa
else
    printf '%s\n' "nvim not found; install Neovim, then run: nvim" >&2
fi

if command -v tmux >/dev/null 2>&1; then
    printf '%s\n' "tmux found. Start tmux and press prefix + I to install plugins."
else
    printf '%s\n' "tmux not found; install tmux before using .tmux.conf." >&2
fi
