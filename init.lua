local opt = vim.opt
opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldenable = false

require("keyMaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4

vim.g.barbar_auto_setup = false

vim.opt.guicursor       = {
	--配置nvim的光标样式
	"i:ver25",
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
}

require("lazy").setup("plugins")

require('nightfox').setup({
	--设置nightfox配色主题
	options = {
		transparent = true
	}
})

require('onedark').setup({
	-- 设置ondark配色主题
	style = 'dark',
	transparent = true
})

require('catppuccin').setup({
	-- 设置catppuccin配色主题
	flavour = "frappe",
	transparent_background = true
})

require('lualine').setup({
	--使用lualine插件（底下的状态栏）
	options = { theme = 'auto' }
})

-- 使用注释插件
require('Comment').setup()

-- 使用mini.indentscope插件（缩进线）
require('mini.indentscope').setup()

require('barbar').setup({
	-- 配置缓冲区显示插件
	animation = false,
	auto_hide = true
})

-- 使用nvim-tree插件
require("nvim-tree").setup()

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({})

lspconfig.ts_ls.setup({
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/Users/lijianlin/Library/pnpm/global/5/node_modules/@vue/typescript-plugin",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue"
	},
	single_file_support = true
})

lspconfig.volar.setup({})

lspconfig.cssls.setup({})

lspconfig.html.setup({})

lspconfig.gopls.setup({})

lspconfig.clangd.setup({})

require('conform').setup({ --使用conform插件 保存自动格式化
	formatters_by_ft = {
		html = {
			"html",
			formatter_on_save = true,
		},
		css = {
			"cssls",
			formatter_on_save = true,
		},
		javascript = {
			formatters = { "volar", "ts_ls" },
			run_all_formatters = true,
			formatter_on_save = true,
		},
		typescript = {
			formatters = { "volar", "ts_ls" },
			run_all_formatters = true,
			formatter_on_save = true,
		},
		vue = {
			formatters = { "volar", "ts_ls" },
			run_all_formatters = true,
			formatter_on_save = true,
		},
		go = {
			"gopls",
			format_on_save = true
		},
		lua = {
			"lua_ls",
			format_on_save = true
		},
		c = {
			"clangd",
			format_on_save = true
		},
		cpp = {
			"clangd",
			format_on_save = true
		}
	},
	format_on_save = function(bufnr)
		local ignore_filetypes = { "oil" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end

		return { timeout_ms = 500, lsp_fallback = true }
	end,
	log_level = vim.log.levels.ERROR,
})

--使用autopairs插件（自动补全括号）
require("nvim-autopairs").setup()

vim.cmd('colorscheme catppuccin')
