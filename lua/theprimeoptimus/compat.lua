-- Neovim 0.12 compatibility patches for plugins that haven't updated their API usage.
-- Applied via lazy.nvim build hooks so they survive plugin updates.

local M = {}

local function patch(path, old, new)
    local f = io.open(path, "r")
    if not f then return end
    local content = f:read("*all")
    f:close()
    if not content:find(old, 1, true) then return end
    local patched = content:gsub(vim.pesc(old), (new:gsub("%%", "%%%%")), 1)
    local fw = io.open(path, "w")
    if fw then
        fw:write(patched)
        fw:close()
    end
end

function M.patch_telescope()
    local path = vim.fn.stdpath("data")
        .. "/lazy/telescope.nvim/lua/telescope/builtin/__files.lua"

    -- iter_captures: node can be nil for optional captures in Neovim 0.12
    patch(
        path,
        'if hl and type(hl) ~= "number" then\n          local row1, col1, row2, col2 = node:range()',
        'if node and hl and type(hl) ~= "number" then\n          local row1, col1, row2, col2 = node:range()'
    )
end

function M.apply_all()
    M.patch_telescope()
end

return M
