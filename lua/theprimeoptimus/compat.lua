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

function M.patch_nvim_treesitter()
    local base = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/lua/nvim-treesitter/"

    -- iter_captures: node can be nil for optional captures in Neovim 0.12
    patch(
        base .. "indent.lua",
        'if query.captures[id]:sub(1, 1) ~= "_" then\n      map[query.captures[id]][node:id()]',
        'if node and query.captures[id]:sub(1, 1) ~= "_" then\n      map[query.captures[id]][node:id()]'
    )

    -- nvim_buf_get_option deprecated → vim.bo
    patch(
        base .. "parsers.lua",
        "return M.ft_to_lang(api.nvim_buf_get_option(bufnr, \"ft\"))",
        "return M.ft_to_lang(vim.bo[bufnr].filetype)"
    )

    -- nvim_buf_set_option deprecated → nvim_set_option_value
    patch(
        base .. "info.lua",
        'api.nvim_buf_set_option(curbuf, "modified", false)\n  api.nvim_buf_set_option(curbuf, "buftype", "nofile")',
        'vim.api.nvim_set_option_value("modified", false, { buf = curbuf })\n  vim.api.nvim_set_option_value("buftype", "nofile", { buf = curbuf })'
    )

    -- nvim_win_get_option deprecated → vim.wo
    patch(
        base .. "fold.lua",
        'api.nvim_win_get_option(0, "foldnestmax")',
        "vim.wo.foldnestmax"
    )
    patch(
        base .. "fold.lua",
        'api.nvim_win_get_option(0, "foldminlines")',
        "vim.wo.foldminlines"
    )
end

function M.patch_treesitter_context()
    local path = vim.fn.stdpath("data")
        .. "/lazy/nvim-treesitter-context/lua/treesitter-context/render.lua"

    -- iter_captures: node can be nil for optional captures in Neovim 0.12
    patch(
        path,
        "      do\n        local range = vim.treesitter.get_range(node, bufnr, metadata[capture])",
        "      do\n        if not node then goto continue end\n        local range = vim.treesitter.get_range(node, bufnr, metadata[capture])"
    )
    patch(
        path,
        "          pri_offset = pri_offset + 1\n        end\n      end\n      offset = offset + util.get_range_height(context)",
        "          pri_offset = pri_offset + 1\n        end\n        ::continue::\n      end\n      offset = offset + util.get_range_height(context)"
    )
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
    M.patch_nvim_treesitter()
    M.patch_treesitter_context()
    M.patch_telescope()
end

return M
