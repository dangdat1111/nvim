return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofmt" },
                python = { "ruff_organize_imports", "ruff_format" },
                -- sqlfluff needs a config file (.sqlfluff / pyproject.toml) for its
                -- dialect, conform skips it when there is none.
                sql = { "sqlfluff" },
                mysql = { "sqlfluff" },
            }
        })
    end
}
