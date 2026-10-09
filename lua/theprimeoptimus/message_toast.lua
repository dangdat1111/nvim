-- Hien thi message/log gan nhat trong MOT KHUNG NOI (toast) nam ngay phia tren
-- dong statusline cua nvim — vien trang, bo goc, goc phai ben duoi.
--
-- Khung TU CO GIAN theo noi dung: message ngan -> khung 1 dong nho gon;
-- message dai -> khung phinh rong/ban nhieu dong de TOAN BO chu van nam trong khung
-- (khong cat, khong '...').
--
-- - Chi xuat hien KHI CO message; khong co thi khong co dong nao (ket hop
--   `cmdheight = 0` trong set.lua).
-- - Message lay tu lich su `:messages` (bat duoc loi, :echo/:echomsg, LSP,
--   plugin...) va tu `vim.notify`.
-- - Tu dong an sau ~6 giay, hoac an ngay khi thoat nvim.

local HIDEOUT_MS = 6000
-- Khoang cach tu vien DUOI cua khung den dong statusline (dang o `lines-1`).
-- 0 = khung sat ngay phia tren statusline; tang len de day khung len cao hon.
local GAP_ABOVE = 1
-- Mau khop giao dien Rosé Pine / nền terminal (xem them .tmux.conf)
local BORDER_FG = '#ffffff' -- vien trang
local BODY_FG = '#e0def4' -- chu (text)
local BODY_BG = '#1e1e2e' -- nen khung (trung nen terminal)

local M = {}

local win, timer, last_msg = nil, nil, ''

-- So dong toi da duoc ban de tranh che kin man hinh khi message cuc dai
local MAX_LINES = 8

local function ensure_hl()
  vim.api.nvim_set_hl(0, 'MsgToastBorder', { fg = BORDER_FG })
  vim.api.nvim_set_hl(0, 'MsgToastBody', { fg = BODY_FG, bg = BODY_BG })
end

local function hide()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
  win = nil
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

-- Cat chuoi thanh nhieu dong, moi dong rong <= max_width (do theo displaywidth).
local function wrap(text, max_width)
  local lines = {}
  local remaining = text
  while remaining ~= '' do
    if vim.fn.strdisplaywidth(remaining) <= max_width then
      lines[#lines + 1] = remaining
      remaining = ''
    else
      -- Tim diem cat gan max_width nhat theo tung ky tu; uu tien cat tai
      -- khoang trang de khong be giua tu.
      local n = vim.fn.strchars(remaining)
      local best = n
      local last_space = 0
      for i = 1, n do
        local part = vim.fn.strcharpart(remaining, 0, i)
        if vim.fn.strdisplaywidth(part) > max_width then
          best = i - 1
          break
        end
        if part:sub(-1) == ' ' then last_space = i end
      end
      if last_space > 0 then best = last_space end
      if best < 1 then best = 1 end
      lines[#lines + 1] = vim.fn.strcharpart(remaining, 0, best)
      remaining = vim.fn.strcharpart(remaining, best):gsub('^%s+', '')
    end
  end
  return lines
end

-- Mo/thay doi toast: khung bo goc vien trang, tu do rong theo message.
local function show()
  if last_msg == '' then
    hide()
    return
  end

  local columns, lines = vim.o.columns, vim.o.lines
  local text = last_msg:gsub('%s+', ' ')

  -- Chieu rong noi dung toi da (chua ca vien 1 o moi ben).
  local max_content = math.max(10, columns - 4)

  -- Neu message dai hon mot hang -> ban nhieu dong, khung cao them.
  local body = {}
  local total_width = vim.fn.strdisplaywidth(text)
  if total_width <= max_content then
    body = { text }
  else
    body = wrap(text, max_content)
    if #body > MAX_LINES then
      body = vim.list_slice(body, 1, MAX_LINES)
      body[#body] = body[#body] .. '…'
    end
  end

  local width = 0
  for _, ln in ipairs(body) do
    local w = vim.fn.strdisplaywidth(ln)
    if w > width then width = w end
  end
  width = math.min(width + 2, columns - 2) -- +2 la hai vien trai/phai
  local height = #body
  -- Neo vi tri: vien DUOI cua khung cach dong statusline (`lines-1`) dung
  -- `GAP_ABOVE` dong; voi border rounded, vien duoi nam o `row + height`.
  local row = math.max(0, lines - 2 - GAP_ABOVE - height)
  -- Canh phai: mep phai cua khung sat cot cuoi man hinh.
  local col = math.max(0, columns - width - 1)

  local buf = nil
  if win and vim.api.nvim_win_is_valid(win) then
    buf = vim.api.nvim_win_get_buf(win)
  else
    buf = vim.api.nvim_create_buf(false, true)
    win = vim.api.nvim_open_win(buf, false, {
      relative = 'editor',
      row = row,
      col = col,
      width = width,
      height = height,
      style = 'minimal',
      border = 'rounded', -- bo goc (╭─╮)
      focusable = false,
      zindex = 60,
    })
    -- Vien trang + nen khung: nvim_open_win khong nhan key highlight, phai set
    -- option `winhl` cua cua so sau khi tao (nvim_set_option_value).
    pcall(vim.api.nvim_set_option_value, 'winhl',
      'Normal:MsgToastBody,FloatBorder:MsgToastBorder', { win = win })
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, body)

  -- Cap nhat lai vi tri/kich thuoc sau khi thay doi noi dung hoac kich thuoc man hinh.
  -- (winhl chi set o luc tao, set_config khong nhan winhl bei moi ban.)
  pcall(vim.api.nvim_win_set_config, win, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
  })

  if timer then
    timer:stop()
    timer:close()
  end
  timer = vim.uv.new_timer()
  timer:start(HIDEOUT_MS, 0, function()
    vim.schedule(hide)
  end)
end

local function cache_set(msg)
  if type(msg) ~= 'string' or msg == '' then return end
  last_msg = msg
  vim.schedule(show)
end

-- Doc dong message gan nhat tu lich su :messages VAO cache (thoi diem an toan).
local function refresh_msgs()
  vim.schedule(function()
    if vim.g._mini_toast_reading then return end
    vim.g._mini_toast_reading = true
    local ok, res = pcall(vim.api.nvim_exec2, 'messages', { output = true })
    vim.g._mini_toast_reading = false
    if not ok then return end

    local out = res.output or ''
    local last = ''
    for _, line in ipairs(vim.split(out, '\n')) do
      line = line:gsub('^%s+', ''):gsub('%s+$', '')
      if line ~= '' then last = line end
    end
    if last ~= last_msg then
      cache_set(last)
    end
  end)
end

-- Bat ca thong bao qua `vim.notify` (LSP/plugin) cung cho vao toast.
local function install_notify_hook()
  local orig = vim.notify
  vim.notify = function(msg, level, opts)
    if type(msg) == 'string' and msg ~= '' then
      last_msg = msg:gsub('\n', ' '):gsub('%s+', ' ')
      vim.schedule(show)
    end
    return orig(msg, level, opts)
  end
end

local function setup()
  ensure_hl()
  install_notify_hook()

  local grp = vim.api.nvim_create_augroup('NvimMessageToast', { clear = true })
  vim.api.nvim_create_autocmd(
    { 'CmdlineLeave', 'CmdlineEnter', 'ModeChanged', 'InsertLeave',
      'CursorMoved', 'CursorMovedI', 'WinEnter', 'BufEnter', 'VimResized' },
    { group = grp, callback = refresh_msgs }
  )
  vim.api.nvim_create_autocmd('VimLeavePre', { group = grp, callback = hide })
  vim.api.nvim_create_autocmd('VimResized', { group = grp, callback = hide })
end

M.setup = setup
M.hide = hide

return M
