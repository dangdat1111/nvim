-- Theme Mac dinh cua IntelliJ IDEA ban DARK (New UI 2023+) la mac dinh.
-- Cac theme khac van duoc cai de switch duoc bang :colorscheme <ten>.

return {

    {
        "erikbackman/brightburn.vim",
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function()
            require("tokyonight").setup({
                style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
            })
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })
        end,
    },

    {
        -- IntelliJ Dark moi (New UI 2023+) cua JetBrains
        "vermdeep/darcula_dark.nvim",
        lazy = false,
        priority = 1002,
        dependencies = { "rktjmp/lush.nvim" },
        config = function()
            vim.cmd("set termguicolors")
            vim.cmd.colorscheme("darcula_dark")

            -- Nen trong suot: de nvim lay dung mau nen cua terminal (Ghostty:
            -- background #000000, opacity 0.85) thay vi nen dac #1d1e20 cua theme.
            -- Giu nguyen fg (mau chu) cua theme, chi bo nen.
            local function transparent(name)
                local hl = vim.api.nvim_get_hl(0, { name = name })
                hl.bg = "none"
                vim.api.nvim_set_hl(0, name, hl)
            end
            transparent("Normal")
            transparent("NormalFloat")
            transparent("NormalNC")
            -- Vung sau EOF cung trong suot (fg cua EndOfBuffer la mau do nen vung rong)
            vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "none", bg = "none" })
        end,
    },

}
