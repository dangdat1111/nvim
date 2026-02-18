return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                preview = {
                    treesitter = false,
                },
                layout_strategy = 'horizontal',
                layout_config = {
                  horizontal = {
                    prompt_position = "top",
                    preview_width = 0.7, -- Chiều rộng phần preview (55%)
                    results_width = 0.8,
                  },
                  vertical = {
                    mirror = false,
                  },
                  width = 0.95, -- Toàn bộ khung chiếm 90% chiều ngang màn hình
                  height = 0.95, -- Toàn bộ khung chiếm 85% chiều dọc màn hình
                  preview_cutoff = 120,
                },
            },
        })
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}







