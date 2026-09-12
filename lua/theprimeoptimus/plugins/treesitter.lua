return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = function()
            vim.cmd(":TSUpdate")
        end,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "query",
                    "markdown", "markdown_inline",
                    "go", "gomod", "gosum", "gowork",
                    "typescript", "javascript", "tsx",
                    "rust",
                    "zig",
                    "python",
                    "sql",
                    "bash",
                    "json", "yaml", "toml",
                    "css",
                    "templ",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = { "html" },
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
            })

            vim.treesitter.language.register("templ", "templ")
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        build = function() end,
        config = function()
            require("treesitter-context").setup({
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
                on_attach = nil,
            })
        end
    }
}
