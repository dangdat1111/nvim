vim.wo.number = true -- Make line numbers default (default: false)
vim.o.relativenumber = true -- Set relative numbered lines (default: false)

-- Set custom colors for line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#888888" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#00FF00", bold = true })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#282828" })









