return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "󰍵" },
            topdelete = { text = "󰍵" },
            changedelete = { text = "▎" },
        },
        current_line_blame = true,
        current_line_blame_opts = { delay = 1000 },
    },
    config = function(_, opts)
        require("gitsigns").setup(opts)

        vim.keymap.set("n", "]c", function()
            require("gitsigns").next_hunk()
        end, { desc = "Next git hunk" })

        vim.keymap.set("n", "[c", function()
            require("gitsigns").prev_hunk()
        end, { desc = "Prev git hunk" })

        vim.keymap.set("n", "<leader>gd", function()
            require("gitsigns").diffthis()
        end, { desc = "Git diff this file" })

        vim.keymap.set("n", "<leader>gb", function()
            require("gitsigns").blame_line({ full = true })
        end, { desc = "Git blame line" })
    end,
}
