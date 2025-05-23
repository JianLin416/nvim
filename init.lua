local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldenable = false

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

local opts              = { noremap = true, silent = true }

vim.g.barbar_auto_setup = false

-- space+e 打开nvim-tree
vim.g.mapleader         = " "
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- space+d 显示报错
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>',
	{ noremap = true, silent = true })

-- 添加 option+上下移动当前行
vim.api.nvim_set_keymap('n', '<A-Up>', ':m .-2<CR>==', opts)
vim.api.nvim_set_keymap('n', '<A-Down>', ':m .+1<CR>==', opts)
vim.api.nvim_set_keymap('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', opts)
vim.api.nvim_set_keymap('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', opts)
vim.api.nvim_set_keymap('v', '<A-Up>', ':m \'<-2<CR>gv=gv', opts)
vim.api.nvim_set_keymap('v', '<A-Down>', ':m \'>+1<CR>gv=gv', opts)

vim.opt.guicursor = {
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

require('lualine').setup({
	--使用lualine插件（底下的状态栏）
	options = { theme = 'auto' }
})

-- 使用mini.indentscope插件（缩进线）
require('mini.indentscope').setup()

require('barbar').setup({
	-- 配置缓冲区显示插件
	animation = false,
	auto_hide = true
})

--使用nvim-tree插件
require("nvim-tree").setup()

local lsps = {
	"volar",
	"ts_ls",
	"html",
	"cssls",
	"pyright",
	"gopls",
	"lua_ls"
}

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

lspconfig.pyright.setup({})

lspconfig.gopls.setup({})

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

vim.cmd('colorscheme onedark')
