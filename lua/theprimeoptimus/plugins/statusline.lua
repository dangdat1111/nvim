return {
    'echasnovski/mini.statusline',
    version = false,
    config = function()
        require('mini.statusline').setup({})

        -- mini.statusline dat statusline GLOBAL qua mot bieu thuc `%{}`:
        --   nvim_get_current_win()==#g:actual_curwin || &laststatus==3
        -- Neu `g:actual_curwin` KHONG duoc dinh nghia, moi lan statusline duoc
        -- ve lai (xay ra moi lan di chuyen con tro vi co `%l/%c` trong noi dung)
        -- bieu thuc loi "E121: Undefined variable: g:actual_curwin" -> statusline
        -- bi nhay/nhap nhay. Theo doi cua so hien tai de bieu thuc luon hop le.
        vim.g.actual_curwin = vim.api.nvim_get_current_win()
        local curwin_grp = vim.api.nvim_create_augroup('MiniStatuslineCurwin', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
            group = curwin_grp,
            pattern = '*',
            callback = function()
                vim.g.actual_curwin = vim.api.nvim_get_current_win()
            end,
        })

        -- Mau mode theo bang mau rose-pine moon (moi mode mot mau rieng)
        local moon = {
            base = '#232136', -- text tren nen mau
            pine = '#3e8fb0', -- Normal  (xanh duong nhat rose-pine)
            love = '#eb6f92', -- Insert  (hong/do)
            gold = '#f6c177', -- Visual  (vang/cam)
            foam = '#9ccfd8', -- Replace (xanh nuoc bien nhat)
            iris = '#c4a7e7', -- Command (tim)
            subtle = '#908caa' -- Other   (xam tim)
        }

        local function mode_hl(name, bg)
            vim.api.nvim_set_hl(0, 'MiniStatuslineMode' .. name, {
                fg = moon.base,
                bg = bg,
                bold = true,
            })
        end

        mode_hl('Normal', moon.pine)
        mode_hl('Insert', moon.love)
        mode_hl('Visual', moon.gold)
        mode_hl('Replace', moon.foam)
        mode_hl('Command', moon.iris)
        mode_hl('Other', moon.subtle)

        -- Ghi chu: message/log gan nhat KHONG nam trong statusline nua. Ve sau
        -- khi user chot "muon o tren dong statusline" -> chuyen qua toast mot
        -- dong phia tren statusline, xem lua/theprimeoptimus/message_toast.lua.
    end,
}
