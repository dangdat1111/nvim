return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            require("nvim-treesitter").install({
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
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "lua", "go", "gomod", "gosum", "gowork",
                    "typescript", "javascript", "tsx", "jsx",
                    "rust", "zig", "python", "sql", "bash",
                    "json", "yaml", "toml", "css", "templ",
                    "c", "vim", "vimdoc", "query",
                    "markdown", "markdown_inline" },
                callback = function(args)
                    vim.treesitter.start(args.buf)
                end,
            })

            vim.treesitter.language.register("templ", "templ")
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
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
