-- Vá lỗi cho Telescope trên Neovim v0.11+
--if not vim.treesitter.language.ft_to_lang then
--    vim.treesitter.language.ft_to_lang = function(ft)
--        local success, result = pcall(vim.treesitter.language.get_lang, ft)
--        return success and result or ft
--    end
--end




-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
	spec = "theprimeoptimus.plugins" ,
    rocks = {enabled = false, hererocks = false},
	change_detection = { notify = false },
})

