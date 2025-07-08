# Neovim Keymap Configuration

This document summarizes all keymaps defined in ThePrimeagen's Neovim configuration (`https://github.com/ThePrimeagen/init.lua`). The keymaps are organized by mode and associated plugin/functionality. The leader key is set to `<Space>`.

## Keymap Overview

| Mode   | Keymap            | Command/Plugin                              | Description                                                                 |
|--------|-------------------|---------------------------------------------|-----------------------------------------------------------------------------|
| Normal | `<leader>pv`      | `vim.cmd.Ex`                                | Open Netrw (Neovim's file explorer).                                        |
| Normal | `<C-h>`           | `<C-w>h`                                    | Move cursor to the window on the left.                                      |
| Normal | `<C-j>`           | `<C-w>j`                                    | Move cursor to the window below.                                            |
| Normal | `<C-k>`           | `<C-w>k`                                    | Move cursor to the window above.                                            |
| Normal | `<C-l>`           | `<C-w>l`                                    | Move cursor to the window on the right.                                     |
| Visual | `J`               | `:m '>+1<CR>gv=gv`                          | Move selected line(s) down and maintain selection.                           |
| Visual | `K`               | `:m '<-2<CR>gv=gv`                          | Move selected line(s) up and maintain selection.                             |
| Normal | `<leader>y`       | `"+y`                                       | Copy to system clipboard.                                                   |
| Visual | `<leader>y`       | `"+y`                                       | Copy selected text to system clipboard.                                     |
| Normal | `<leader>Y`       | `"+Y`                                       | Copy entire line to system clipboard.                                       |
| Normal | `<leader>d`       | `"_d`                                       | Delete without saving to register (clean delete).                           |
| Visual | `<leader>d`       | `"_d`                                       | Delete selected text without saving to register (clean delete).             |
| Normal | `<C-c>`           | `<cmd> %y+ <CR>`                            | Copy entire file content to system clipboard.                               |
| Normal | `Q`               | `<nop>`                                     | Disable `Q` key to prevent entering Ex mode.                                |
| Normal | `<C-f>`           | `<cmd>silent !tmux neww tmux-sessionizer<CR>` | Open a new tmux session using `tmux-sessionizer`.                           |
| Normal | `<leader>f`       | `vim.lsp.buf.format`                        | Format code using LSP.                                                      |
| Normal | `<C-k>`           | `<cmd>cnext<CR>zz`                          | Go to next quickfix list item and center the screen.                        |
| Normal | `<C-j>`           | `<cmd>cprev<CR>zz`                          | Go to previous quickfix list item and center the screen.                    |
| Normal | `<leader>k`       | `<cmd>lnext<CR>zz`                          | Go to next location list item and center the screen.                        |
| Normal | `<leader>j`       | `<cmd>lprev<CR>zz`                          | Go to previous location list item and center the screen.                    |
| Normal | `<leader>s`       | `:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>` | Replace word under cursor globally (supports entering replacement).         |
| Normal | `<leader>x`       | `<cmd>!chmod +x %<CR>`                      | Make current file executable.                                               |
| Normal | `<leader><leader>`| `<cmd>so<CR>`                               | Source the current Neovim configuration file.                               |
| Normal | `<leader>mr`      | `TSJSX`                                     | Run `TSJSX` (related to Treesitter or custom plugin).                       |

## LSP Keymaps

Keymaps related to the Language Server Protocol (LSP) defined in `lsp.lua`.

| Mode   | Keymap            | Command/Plugin                              | Description                                                                 |
|--------|-------------------|---------------------------------------------|-----------------------------------------------------------------------------|
| Normal | `gd`              | `vim.lsp.buf.definition`                    | Jump to the definition of the symbol under the cursor.                      |
| Normal | `gD`              | `vim.lsp.buf.declaration`                   | Jump to the declaration of the symbol under the cursor.                     |
| Normal | `K`               | `vim.lsp.buf.hover`                         | Show hover information for the symbol under the cursor.                     |
| Normal | `gi`              | `vim.lsp.buf.implementation`                | Jump to the implementation of the symbol under the cursor.                  |
| Normal | `<C-k>`           | `vim.lsp.buf.signature_help`                | Show signature help for the function under the cursor.                      |
| Normal | `<leader>rn`      | `vim.lsp.buf.rename`                        | Rename the symbol under the cursor.                                         |
| Normal | `gr`              | `vim.lsp.buf.references`                    | Find all references to the symbol under the cursor.                         |
| Normal | `<leader>ca`      | `vim.lsp.buf.code_action`                   | Open code action menu for the symbol under the cursor.                      |
| Normal | `[d`              | `vim.diagnostic.goto_prev`                  | Jump to the previous diagnostic (error/warning).                            |
| Normal | `]d`              | `vim.diagnostic.goto_next`                  | Jump to the next diagnostic (error/warning).                                |
| Normal | `<leader>e`       | `vim.diagnostic.open_float`                 | Show diagnostic details in a floating window.                               |
| Normal | `<leader>q`       | `vim.diagnostic.setloclist`                 | Add diagnostics to the location list.                                       |

## Telescope Keymaps

Keymaps related to the `telescope.nvim` plugin defined in `telescope.lua`.

| Mode   | Keymap            | Command/Plugin                              | Description                                                                 |
|--------|-------------------|---------------------------------------------|-----------------------------------------------------------------------------|
| Normal | `<leader>ps`      | `Telescope grep_string`                     | Search for the word under the cursor in the project.                        |
| Normal | `<C-p>`           | `Telescope git_files`                       | Search for files in the Git repository.                                     |
| Normal | `<leader>pf`      | `Telescope find_files`                      | Search for all files in the working directory.                              |
| Normal | `<leader>sh`      | `Telescope help_tags`                       | Search through Neovim help tags.                                            |
| Normal | `<leader>sw`      | `Telescope grep_string`                     | Search for a string in the entire project (same as `<leader>ps`).           |
| Normal | `<leader>sg`      | `Telescope live_grep`                       | Live grep search in the entire project.                                     |
| Normal | `<leader>sd`      | `Telescope diagnostics`                     | Show LSP diagnostics (errors/warnings).                                     |
| Normal | `<leader>?`       | `Telescope oldfiles`                        | Show recently opened files.                                                 |
| Normal | `<leader><space>` | `Telescope buffers`                         | Show open buffers.                                                          |
| Normal | `<leader>/`       | `Telescope current_buffer_fuzzy_find`       | Fuzzy find in the current buffer.                                           |

## Harpoon Keymaps

Keymaps related to the `harpoon` plugin defined in `harpoon.lua`.

| Mode   | Keymap            | Command/Plugin                              | Description                                                                 |
|--------|-------------------|---------------------------------------------|-----------------------------------------------------------------------------|
| Normal | `<leader>a`       | `harpoon:list():append()`                   | Add the current file to Harpoon's list.                                     |
| Normal | `<C-e>`           | `harpoon.ui:toggle_quick_menu()`            | Toggle Harpoon's quick menu.                                                |
| Normal | `<C-1>`           | `harpoon:list():select(1)`                  | Switch to the 1st file in Harpoon's list.                                   |
| Normal | `<C-2>`           | `harpoon:list():select(2)`                  | Switch to the 2nd file in Harpoon's list.                                   |
| Normal | `<C-3>`           | `harpoon:list():select(3)`                  | Switch to the 3rd file in Harpoon's list.                                   |
| Normal | `<C-4>`           | `harpoon:list():select(4)`                  | Switch to the 4th file in Harpoon's list.                                   |

## Fugitive Keymaps

Keymaps related to the `vim-fugitive` plugin defined in `fugitive.lua`.

| Mode   | Keymap            | Command/Plugin                              | Description                                                                 |
|--------|-------------------|---------------------------------------------|-----------------------------------------------------------------------------|
| Normal | `<leader>gs`      | `vim.cmd.Git`                               | Open Fugitive's Git interface.                                              |

## Undotree Keymaps

Keymaps related to the `undotree` plugin defined in `undotree.lua`.

| Mode   | Keymap            | Command/Plugin                              | Description                                                                 |
|--------|-------------------|---------------------------------------------|-----------------------------------------------------------------------------|
| Normal | `<leader>u`       | `vim.cmd.UndotreeToggle`                    | Toggle the Undotree window (shows edit history).                             |

## Notes
- **Leader Key**: Set to `<Space>` in the configuration.
- **Modes**:
  - **Normal**: Normal mode in Neovim.
  - **Visual**: Visual (selection) mode in Neovim.
- **Sources**: Keymaps are extracted from `remap.lua`, `lsp.lua`, `telescope.lua`, `harpoon.lua`, `fugitive.lua`, and `undotree.lua` in the `lua/theprimeagen/lazy/` directory.
- This configuration is optimized for a fast and efficient development workflow, leveraging plugins like Telescope, LSP, Harpoon, and Fugitive.

