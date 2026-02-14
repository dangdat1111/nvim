return {
    "windwp/nvim-ts-autotag",
    -- Ép load ngay khi khởi động để kiểm tra
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-ts-autotag").setup({
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = true,
            }
        })
    end,
}
