-- General options
vim.opt.hidden = true
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.ruler = false
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.breakindent = true
vim.opt.showbreak = "  "
vim.opt.linebreak = true
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.fillchars = { eob = " " }
vim.opt.winbl = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.foldmethod = "manual"
vim.opt.belloff = "all"
vim.opt.shell = "/bin/zsh"
vim.opt.title = true
vim.opt.titlestring = "%t"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 150
vim.cmd [[ set list lcs=trail:·,tab:\\u2591\\x20 ]]
vim.g.mapleader = ","
vim.opt.shortmess = {
	a = true,
	t = true,
	T = true, 
	o = true,
	O = true,
	F = true,
	c = true,
	I = true
}

-- Fix up/down behavior
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })

-- Other mappings
vim.api.nvim_set_keymap("n", "<space>", "8j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "-", "8k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<space>", "8j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "-", "8k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "8j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "8k", { noremap = true, silent = true })

-- Remap leader-y/p to use system buffer
vim.api.nvim_set_keymap("n", "<leader>y", "\"+y", {});
vim.api.nvim_set_keymap("v", "<leader>y", "\"+y", {});
vim.api.nvim_set_keymap("n", "<leader>p", "\"+p", {});
vim.api.nvim_set_keymap("v", "<leader>p", "\"+p", {});

-- Highlight on yank
vim.cmd "au TextYankPost * lua vim.highlight.on_yank {on_visual = false}"

-- Plugins
require('packer').startup(function()
	use "wbthomason/packer.nvim"
	use "nvim-lua/plenary.nvim"
	use "BurntSushi/ripgrep"
	use "nvim-telescope/telescope.nvim"
	use "nvim-telescope/telescope-file-browser.nvim"
	use "L3MON4D3/LuaSnip"
	use "neovim/nvim-lspconfig"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-path"
	use "hrsh7th/nvim-cmp"
	use "lewis6991/gitsigns.nvim"
	use "folke/trouble.nvim"
	use "sbdchd/neoformat"
	use "nvim-lualine/lualine.nvim"
	use "kyazdani42/nvim-web-devicons"
	use "kyazdani42/nvim-tree.lua"
	use "romgrk/barbar.nvim"
	use "windwp/nvim-autopairs"
	use "EdenEast/nightfox.nvim"
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate"
	}
end)

-- LSP setup
local lspconfig = require("lspconfig")
vim.fn.sign_define("DiagnosticSignError", {text = "", numhl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "", numhl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = "", numhl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", numhl = "DiagnosticSignHint"})

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

local on_attach = function(client, bufnr)
	vim.opt.formatoptions = "crnj"
	vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
	vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
	vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
	vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
	vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
	vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	vim.cmd("command! LspDiag lua vim.diagnostic.setqflist()")
	vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
	buf_map(bufnr, "n", "gd", ":LspDef<CR>")
	--buf_map(bufnr, "n", "gr", ":LspRefs<CR>") -- using Telescope instead
	--buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>") -- using Telescope instead
	--buf_map(bufnr, "n", "gy", ":LspDiag<CR>") -- using Trouble instead
	buf_map(bufnr, "n", "<leader>a", ":LspCodeAction<CR>")
	buf_map(bufnr, "n", "<leader>rr", ":LspRename<CR>")
	buf_map(bufnr, "n", "K", ":LspHover<CR>")
	buf_map(bufnr, "n", "<C-K>", ":LspHover<CR>")
	buf_map(bufnr, "i", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

	--Disable LSP format on save because using Prettier instead
	--if client.resolved_capabilities.document_formatting then
	--  vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	--end
end

require 'lspconfig'.tsserver.setup({ on_attach = on_attach })

-- Completion setup
local cmp = require("cmp")
cmp.setup({
	snippet = { 
		expand = function(args)
		  require('luasnip').lsp_expand(args.body)
		end
	},
	mapping = {
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-j>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
		['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
		['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
		['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
		['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
		['<tab>'] = cmp.mapping.confirm({ select = true })
	},
	sources = cmp.config.sources({{ name = 'nvim_lsp' }, { name = 'path' }}),
	experimental = { ghost_text = true }
})

-- NvimTree
require("nvim-tree").setup({
	view = {
		side = "right"
	}
})
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeFindFile<CR>:NvimTreeOpen<CR>", { silent = true })

-- Tree sitter (enable syntax highlighting)
require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
	},
	indent = { enable = true }
})

-- Color theme and status line
vim.cmd("colorscheme nightfox")
require("lualine").setup({
	options = {
		--theme = 'tokyonight',
		icons_enabled = false,
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
	},
	sections = {
		lualine_c = {
		  {
		    "filename",
		    file_status = true,
		    path = 1
		  }
		}
	}
})

-- Neoformat autocommand
vim.cmd("autocmd BufWritePre * undojoin | Neoformat prettierd")

-- Autopairs
require("nvim-autopairs").setup({})

-- Git signs
require('gitsigns').setup({
	signs = {
		add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
		change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
		delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		changedelete = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
	}
})
vim.api.nvim_set_keymap("n", "gn", ":Gitsigns next_hunk<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gN", ":Gitsigns prev_hunk<CR>", { silent = true })

-- Trouble
vim.api.nvim_set_keymap("n", "<leader>t", ":Trouble<CR>", { silent = true })

-- Telescope
require("telescope").setup({
	extensions = { file_browser = {} }
})
require("telescope").load_extension("file_browser")
filelist_theme = "theme=dropdown previewer=false<CR>"
grep_theme = "theme=dropdown previewer=false layout_config={mirror=true,height=0.5}<CR>"
greppreview_theme = "theme=dropdown layout_config={mirror=true}<CR>"
ref_theme = "theme=cursor layout_config={width=0.8,height=18}<CR>"

vim.api.nvim_set_keymap("n", "<leader><leader>", ":Telescope<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", ":Telescope resume<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files " .. filelist_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>o", ":Telescope oldfiles only_cwd=true " .. filelist_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>S", ":Telescope live_grep " .. greppreview_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>s", ":Telescope current_buffer_fuzzy_find " .. grep_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers " .. filelist_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope buffers " .. filelist_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope git_status " .. greppreview_theme, { silent = true })
vim.api.nvim_set_keymap("n", "gr", ":Telescope lsp_references " .. ref_theme, { silent = true })
vim.api.nvim_set_keymap("n", "gy", ":Telescope lsp_type_definitions " .. ref_theme, { silent = true })

-- In a bold move, remap '/' in normal mode to use Telescope instead...
-- (if want to highlight, ':/' seems to work fine)
vim.api.nvim_set_keymap('n', "/", "<leader>s", {})
