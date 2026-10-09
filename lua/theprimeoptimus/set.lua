vim.wo.number = true
vim.o.relativenumber = true

-- De colorscheme tu quan ly mau LineNr/CursorLineNr/SignColumn
-- (bo cac override cu: LineNr #888888, CursorLineNr xanh #00FF00, SignColumn #282828)

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

-- An hang dong lenh khong o day. `cmdheight = 0` (nvim >= 0.9) lam dong nay
-- chi hien ra khi that su can go lenh `:` hoac co thong bao, het thi bien mat.
-- Nhu vay khong con hinh "1 dong trong" lo lung giua noi dung va thanh trang
-- thai tmux. Message/log gan nhat duoc dua len MOT DONG ngay PHIA TREN dong
-- statusline (toast goc phai), xem lua/theprimeoptimus/message_toast.lua.
vim.o.cmdheight = 0



