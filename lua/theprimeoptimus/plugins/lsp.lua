local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}


return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "github/copilot.vim",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()

        -- NOTE: mason-lspconfig v2 dropped `handlers`. Servers are enabled through
        -- `vim.lsp.enable()` (automatic_enable), so per-server tweaks live in
        -- `vim.lsp.config()` below. The "*" entry applies to every server.
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    format = {
                        enable = true,
                        -- Put format options here
                        -- NOTE: the value should be STRING!!
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        }
                    },
                }
            }
        })

        vim.lsp.config("gopls", {
            on_attach = function(client)
                client.server_capabilities.semanticTokensProvider = nil
            end,
        })

        vim.lsp.config("zls", {
            root_markers = { ".git", "build.zig", "zls.json" },
            settings = {
                zls = {
                    enable_inlay_hints = true,
                    enable_snippets = true,
                    warn_style = true,
                },
            },
        })
        vim.g.zig_fmt_parse_errors = 0
        vim.g.zig_fmt_autosave = 0

        -- Python: pyright = types/completion, ruff = lint + format.
        vim.lsp.config("pyright", {
            settings = {
                pyright = {
                    -- ruff handles import sorting
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFilesOnly",
                        typeCheckingMode = "basic",
                        diagnosticSeverityOverrides = {
                            -- ruff already reports these
                            reportUnusedImport = "none",
                            reportUnusedVariable = "none",
                        },
                    },
                },
            },
        })

        vim.lsp.config("ruff", {
            on_attach = function(client)
                -- let pyright own hover, ruff only lints/formats
                client.server_capabilities.hoverProvider = false
            end,
        })

        -- SQL: sqls (Go). Chose it over sqlls because sql-language-server v1.7.1
        -- crashes on Node >= 20 (ERR_PACKAGE_PATH_NOT_EXPORTED) and is unmaintained.
        -- Upstream only roots on config.yml, add .git so it starts in a repo.
        -- For DB-aware completion, drop a config.yml in the project root, see
        -- https://github.com/sqls-server/sqls#db-configuration
        vim.lsp.config("sqls", {
            root_markers = { "config.yml", ".sqls.yml", ".git" },
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "vtsls",
                "eslint",
                "lua_ls",
                "rust_analyzer",
                "tailwindcss",
                "gopls",
                "pyright",
                "ruff",
                "sqls",
            },
            automatic_enable = true,
        })

        -- Formatters/linters aren't LSP servers, so mason-lspconfig won't install them.
        local ensure_tools = { "sqlfluff" }
        local registry = require("mason-registry")
        registry.refresh(function()
            for _, name in ipairs(ensure_tools) do
                local ok, pkg = pcall(registry.get_package, name)
                if ok and not pkg:is_installed() then
                    pkg:install()
                end
            end
        end)



        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "copilot", group_index = 2 },
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            virtual_text = true,
            signs = true, -- Show signs in the sign column
            underline = true, -- Underline the diagnostic range
            update_in_insert = true, -- Update diagnostics even in insert mode (this was commented out in your config)
            severity_sort = true,
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
























