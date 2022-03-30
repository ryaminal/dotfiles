--[[ lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- language environments- pyenv global 3.9.1 2.7.18 - this will setup python2 and python3
-- pyenv virtualenv 2.7.18 nvim2 - sets up an nvim-specific venv for python2
-- pyenv virtualenv 3.9.1 nvim - sets up an nvim-specific venv for python3
vim.g.python_host_prog = "$HOME/.pyenv/versions/nvim2/bin/python"
vim.g.python3_host_prog = "$HOME/.pyenv/versions/nvim/bin/python"
vim.g.ruby_host_prog = "$HOME/.rbenv/versions/3.0.2/bin/ruby"

-- settings
vim.opt.undofile = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "number"
vim.opt.guifont = "JetBrainMono Nerd Font Mono"
vim.opt.background = "dark"

-- general
-- lvim.log.level = "debug"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "solarized-high"
lvim.lsp.diagnostics.virtual_text = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = "<Plug>RestNvim"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }kk

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.notify.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.dap.active = true

lvim.builtin.bufferline.options = {
	always_show_bufferline = true,
	separator_style = "slant",
}

-- lvim.builtin.treesitter.rainbow = {
-- 	enable = true,
-- 	max_file_lines = nil,
-- 	extended_mode = true,
-- }

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"cpp",
	"css",
	"html",
	"http",
	"java",
	"javascript",
	"json",
	"lua",
	"python",
	"rust",
	"typescript",
	"yaml",
}

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ",\n"
		end
		return s .. "} \n"
	else
		return tostring(o)
	end
end

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.on_config_done = function(config)
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.zsh = {
		install_info = {
			url = "~/dev/tree-sitter-bash", -- local path or git repo
			files = { "src/parser.c" },
		},
		filetype = "zsh", -- if filetype does not agrees with parser name
		-- used_by = { "zsh" }, -- additional filetypes that use this parser
	}
end

-- none of the textobjects stuff appears to be having an effect. not certain what i'm doing wrong
-- lvim.builtin.treesitter.textobjects.select = {
-- 	enable = true,
-- 	lookahead = true,
-- }
-- lvim.builtin.treesitter.textobjects.swap = {
-- 	enable = true,
-- 	set_jumps = true,
-- 	goto_next_start = {
-- 		["]m"] = "@function.outer",
-- 		["]]"] = "@class.outer",
-- 	},
-- }
-- lvim.builtin.treesitter.textobjects.lsp_interop = {
-- 	enable = true,
-- 	peek_definition_code = {
-- 		["<leader>df"] = "@function.outer",
-- 		["<leader>dF"] = "@class.outer",
-- 	},
-- }

lvim.builtin.which_key.mappings["<space>"] = {
	name = "+more",
	g = { "1<C-g>", "FullPathCurrentFile" },
	P = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close all peeks" },
	p = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Peek Definition" },
	i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Peek Impl" },
	s = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" },
	z = {
		name = "zettel",
	},
}

-- lvim.builtin.which_key.mappings["da"] = {
-- 	"<cmd>lua require'dap'.run_last()<CR>",
-- 	"Rerun Again",
-- }

lvim.builtin.which_key.mappings["sn"] = {
	"<cmd>Telescope notify<CR>",
	"Notifications",
}
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	t = { "<cmd>TroubleToggle<cr>", "Toggle" },
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	T = { "<cmd>Trouble lsp_type_definitions<cr>", "Type Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics Document" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics Workspace" },
	p = { "<cmd>Trouble telescope<cr>", "Telescope" },
}

-- lvim.builtin.which_key.mappings["g"] = {
-- 	name = "+GotoPreview",
-- 	P = { "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", "Definition" },
-- }
-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end
local shells = { "sh", "bash", "zsh" }

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	-- python
	-- stole the config from software/.pyrproject for black and isort
	{ exe = "black", args = { "-l", 100, "-C" }, filetypes = { "python" } },
	{
		exe = "isort",
		args = {
			"--ca",
			"--fgw",
			0,
			"-p",
			"asic_test,bni,firmwareimage,hyperion,imaging,integration_test,xdr,dw",
			"--sd",
			"THIRDPARTY",
			"-l",
			100,
			"--tc",
			"--profile",
			"black",
			"-m",
			3,
		},
		filetypes = { "python" },
	},
	-- shell
	{ exe = "shfmt", args = { "-i", "2", "-bn", "-ci", "-sr", "-s" }, filetypes = shells },
	-- lua
	{ exe = "stylua", filetypes = { "lua" } },
	-- generic
	-- { exe = "prettier" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	-- python
	{ exe = "flake8", filetypes = { "python" } },
	-- { exe = "pyre", filetypes = { "python" } },
	-- shell
	{ exe = "shellcheck", args = { "-x" }, filetypes = shells },
	-- lua. disabled, because it's annoying atm
	--{ exe = "selene", filetypes = { "lua" } },
})

-- Additional Plugins
lvim.plugins = {
	{ "ishan9299/nvim-solarized-lua" },
	{ "ishan9299/modus-theme-vim" },
	{ "pearofducks/ansible-vim" },
	{ "nelstrom/vim-visual-star-search" },
	{ "NTBBloodbath/rest.nvim" },
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach({
				handler_opts = {
					border = "single",
				},
			})
		end,
		event = "BufRead",
	},
	{
		"folke/trouble.nvim",
	},
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			require("dap-python").setup("/home/me/.pyenv/versions/debugpy/bin/python")
		end,
	},
	{
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	},
	{
		"ruifm/gitlinker.nvim",
		event = "BufRead",
		config = function()
			require("gitlinker").setup({
				opts = {
					-- remote = "github", -- force the use of a specific remote
					-- adds current line nr in the url for normal mode
					add_current_line_on_normal_mode = true,
					-- callback for what to do with the url
					action_callback = require("gitlinker.actions").open_in_browser,
					-- print the url after performing the action
					print_url = true,
					-- mapping to call url generation
					mappings = "<leader>gy",
				},
			})
		end,
	},
	{
		"pwntester/octo.nvim",
		event = "BufRead",
	},
	{ "p00f/nvim-ts-rainbow" },
	{
		"folke/lsp-colors.nvim",
		event = "BufRead",
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 25, -- Height of the floating window
				debug = false, -- Print debug information
				default_mappings = false, -- Bind default mappings
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
	},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"oberblastmeister/neuron.nvim",
		config = function()
			-- these are all the default values
			require("neuron").setup({
				virtual_titles = true,
				mappings = true,
				run = nil, -- function to run when in neuron dir
				neuron_dir = "~/dev/dot/z", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
				leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
			})
		end,
	},
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.edit_command_line_ft = {
	{ "BufWinEnter", [[/tmp/zsh\w\+]], "setf sh" }, -- when using C-xC-e to edit the command line, set it to sh.
}
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
