return {
    {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
        local status, treesitter = pcall(require, "nvim-treesitter")
        if not status then
            return
        end
        treesitter.setup({})

        local max_filesize = 100 * 1024 -- 100 KB
        local highlight_group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true })

        vim.api.nvim_create_autocmd("FileType", {
            group = highlight_group,
            callback = function(args)
                local filetype = vim.bo[args.buf].filetype
                local lang = vim.treesitter.language.get_lang(filetype) or filetype

                if lang == "html" then
                    return
                end

                local ok_stat, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                if ok_stat and stats and stats.size > max_filesize then
                    return
                end

                pcall(vim.treesitter.start, args.buf, lang)
            end,
        })

        vim.treesitter.language.register("templ", "templ")
    end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
            require'treesitter-context'.setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                multiwindow = false, -- Enable multiwindow support.
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end
    }
}
