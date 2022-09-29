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
vim.opt.mouse = "ar"
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.breakindent = true
vim.opt.showbreak = "  "
vim.opt.linebreak = true
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.fillchars = { eob = " " }
vim.opt.winbl = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.number = true
vim.opt.relativenumber = true;
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

-- Fix basic VIM bindings
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })

-- Scroll mappings
vim.api.nvim_set_keymap("n", "<space>", "8j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "-", "8k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<space>", "8j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "-", "8k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "Lzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "Hzz", { noremap = true, silent = true })

-- JS-specific shortcuts
vim.api.nvim_set_keymap("v", "<leader>c", "0<C-v>I//<esc>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", "0<C-v>I//<esc>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", "O/***/<left><left><space><left><space>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>J", "O/***/<left><left><CR><esc>d0==I<space><esc>kA<CR>", { noremap = true, silent = true })

-- Visual mode enhancements
vim.api.nvim_set_keymap("v", "v", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "(", "<esc>`>a)<esc>`<i(<esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "{", "<esc>`>a}<esc>`<i{<esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "`", "<esc>`>a`<esc>`<i`<esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "\"", "<esc>`>a\"<esc>`<i\"<esc>", { noremap = true, silent = true })

-- List mappings
vim.api.nvim_set_keymap("n", "<leader>q", ":copen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]Q", ":clast<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[Q", ":cfirst<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":lopen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]L", ":llast<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[L", ":lfirst<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]l", ":lnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[l", ":lprev<CR>", { noremap = true, silent = true })

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
	use "sbdchd/neoformat"
	use "nvim-lualine/lualine.nvim"
	use "kyazdani42/nvim-web-devicons"
	use "kyazdani42/nvim-tree.lua"
	use "romgrk/barbar.nvim"
	use "windwp/nvim-autopairs"
	use "EdenEast/nightfox.nvim"
	--use {
	--	"nvim-treesitter/nvim-treesitter",
	--	run = ":TSUpdate"
	--}
end)

-- LSP/diagnostics setup
local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({
	on_attach = function (client, bufnr)
		vim.cmd [[ set formatoptions=crnj ]]
		vim.api.nvim_buf_set_option(bufnr, 'formatexpr',
			'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})')
	end
})

vim.fn.sign_define("DiagnosticSignError", {text = "", numhl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "", numhl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = "", numhl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", numhl = "DiagnosticSignHint"})
vim.api.nvim_set_keymap("n", "]x", ":lua vim.diagnostic.goto_next()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "[x", ":lua vim.diagnostic.goto_prev()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>x", ":lua vim.diagnostic.setqflist()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", ":lua vim.lsp.buf.code_action()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>rr", ":lua vim.lsp.buf.rename()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-K>", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
vim.api.nvim_create_user_command("LspSignature", "lua vim.lsp.buf.signature_help()", {})
vim.api.nvim_set_keymap("i", "<C-K>", "<cmd>LspSignature<CR>", { silent = true })

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
	},
	renderer = {
		root_folder_modifier = ":t",
		indent_markers = {
			enable = true
		}
	}
})
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeFindFile<CR>:NvimTreeOpen<CR>", { silent = true })

-- Tree sitter (enable syntax highlighting)
-- DISABLED BECAUSE OF TERRIBLE PERFORMANCE WITH > 1000 LINE TS FILES
--require("nvim-treesitter.configs").setup({
--	ensure_installed = "all",
--	highlight = {
--		enable = true,
--		additional_vim_regex_highlighting = true
--	},
--	indent = { enable = true }
--})

-- Color theme and status line
require('nightfox').setup({
  options = {
		styles = { comments = "italic" }
	},
	specs = {
		all = {
			syntax = { comment = "orange" }
		}
	}
})
vim.cmd("colorscheme nightfox")
require("lualine").setup({
	options = {
		icons_enabled = true,
		component_separators = { left = "", right = ""},
		section_separators = { left = "", right = ""},
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

-- Buffer (barbar) mappings
vim.api.nvim_set_keymap("n", "]b", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[b", ":BufferPrev<CR>", { noremap = true, silent = true })

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
vim.api.nvim_set_keymap("n", "]g", ":Gitsigns next_hunk<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "[g", ":Gitsigns prev_hunk<CR>", { silent = true })

-- Telescope
require("telescope").setup({
	extensions = { file_browser = {} }
})
require("telescope").load_extension("file_browser")
filelist_theme = "theme=dropdown previewer=false<CR>"
grep_theme = "theme=dropdown previewer=false layout_config={mirror=true,height=0.5}<CR>"
greppreview_theme = "theme=dropdown layout_config={mirror=true}<CR>"
ref_theme = "theme=cursor layout_config={width=0.8,height=20}<CR>"

vim.api.nvim_set_keymap("n", "<leader><leader>", ":Telescope<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", ":Telescope resume<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files " .. filelist_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>o", ":Telescope oldfiles only_cwd=true " .. filelist_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>S", ":Telescope live_grep " .. greppreview_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>s", ":Telescope current_buffer_fuzzy_find " .. grep_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers " .. filelist_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope buffers " .. filelist_theme, { silent = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope git_status " .. greppreview_theme, { silent = true })
vim.api.nvim_set_keymap("n", "gd", ":Telescope lsp_definitions " .. ref_theme, { silent = true })
vim.api.nvim_set_keymap("n", "gr", ":Telescope lsp_references " .. ref_theme, { silent = true })
vim.api.nvim_set_keymap("n", "gy", ":Telescope lsp_type_definitions " .. ref_theme, { silent = true })

-- In a bold move, remap '/' in normal mode to use Telescope instead...
-- (if want to highlight, ':/' seems to work fine)
vim.api.nvim_set_keymap('n', "/", "<leader>s", {})
