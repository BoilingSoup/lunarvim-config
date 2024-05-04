--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
--

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
vim.opt.cmdheight = 1
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.cursorline = false
-- lvim.colorscheme = "fruitypebbles"
vim.opt.relativenumber = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader>ss"] = ":SearchSession<CR>"
lvim.keys.normal_mode["<leader>t"] = "<cmd>ToggleTerm<CR>"
-- keybinds for .go
lvim.keys.normal_mode["<leader>ie"] = "iif err != nil {<Enter>}<Esc>:lua vim.lsp.buf.format()<CR>O"
lvim.keys.normal_mode["<leader>pm"] =
	"ipackage main<Enter><Enter>func main() {<Enter>}<Esc>:lua vim.lsp.buf.format()<CR>O"

-- whichkey + bindings
lvim.builtin.which_key.mappings["t"] = {
	"ToggleTerm",
}
lvim.builtin.which_key.mappings["s"]["s"] = {
	"Sessions",
}

-- shorten timeoutlen only for jk | kj <Esc> without effecting other keybinds
-- jk saves, kj does not
vim.cmd([[
  let g:esc_j_lasttime = 0
  let g:esc_k_lasttime = 0
  function! JKescape(key)
    if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
    if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
    let l:timediff = abs(g:esc_j_lasttime - g:esc_k_lasttime)
    return (l:timediff <= 0.1 && l:timediff >=0.001) ? a:key=='k' ? "\b\e:w\<CR>" : "\b\e" : a:key
  endfunction
  inoremap <expr> j JKescape('j')
  inoremap <expr> k JKescape('k')
]])

-- cmp autoselect first option
lvim.builtin.cmp.confirm_opts.select = true

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

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

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.filters.dotfiles = false
lvim.builtin.nvimtree.setup.filters.custom = {}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
	"go",
	"gomod",
	"html",
	"toml",
	"cpp",
	"svelte",
	"php",
	"markdown",
	"vim",
	"dockerfile",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- .git || node_modules marks project root    *** maybe add go.mod, composer.json later
lvim.lsp.null_ls.setup.root_dir = require("lspconfig.util").root_pattern(".git", "node_modules")

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
--

require("lvim.lsp.manager").setup("solidity", {
	cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
	filetypes = { "solidity" },
	root_dir = require("lspconfig.util").find_git_ancestor,
	single_file_support = true,
})

-- it's htmx time
require("lvim.lsp.manager").setup("htmx", {
	filetypes = { "html" },
})

require("lvim.lsp.manager").setup("tailwindcss", {
	filetypes = { "go" },
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					"Style\\s*:?=\\s*['\"`]([^'\"`]*)['\"`]",
					'Class\\("([\\w\\s\\-\\:\\[\\]/]*)"\\)',
					'Classes\\{"([\\w\\s\\-\\:\\[\\]/]*)":(.)*\\}',
				},
			},
		},
	},
})

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/prettier/.prettierrc.json")
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		command = "black",
		filetypes = { "python" },
	},
	--   { command = "isort", filetypes = { "python" } },
	{
		-- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "prettierd",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = {
			-- "template",
			-- "tmpl",
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"html", -- using set filetype html autocmd to get html highlight in template files (blade, tmpl, ejs, etc.)
			"blade",
			"css",
			"astro",
		},
	},
	{ command = "goimports", filetypes = { "go" } },
	-- { command = "gofumpt",   filetypes = { "go" } },
	{ command = "google_java_format", filetypes = { "java" } },
	{ command = "pint", filetypes = { "php" } },
	{ command = "forge_fmt", filetypes = { "solidity" } },
	{ command = "shfmt" },
	{ command = "stylua" },
	{ command = "buf", filetypes = { "proto" } },
})

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	-- { command = "solhint", extra_args = { "$FILENAME" }, filetypes = { "solidity" } }
	{ command = "solhint", extra_args = { "stdin" }, filetypes = { "solidity" } },
	{ command = "staticcheck", args = { "./..." }, filetypes = { "go" } },
	{ command = "eslint_d" },
	{ command = "protolint" },
	-- { command = "shellcheck" } *for some reason this is active automatically after installing*
	--
	-- {
	--   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
	--   command = "shellcheck",
	--   ---@usage arguments to pass to the formatter
	--   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
	--   extra_args = { "--severity", "warning" },
	-- },
	-- {
	--   command = "codespell",
	--   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
	--   filetypes = { "javascript", "python" },
	-- },
})

-- Additional Plugins
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }
lvim.plugins = {
	{ "karb94/neoscroll.nvim" },
	{ "BoilingSoup/fruitypebbles.nvim" },
	{ "folke/tokyonight.nvim" },
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = true,
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup(
				{ "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
				{
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					rgb_fn = true, -- CSS rgb() and rgba() functions
					hsl_fn = true, -- CSS hsl() and hsla() functions
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				}
			)
		end,
	},
	{
		"metakirby5/codi.vim",
		cmd = "Codi",
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_enable_last_session = false,
				auto_session_create_enabled = false,
				auto_save_enabled = false,
				auto_restore_enabled = false,
				auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
			})
		end,
	},
	{
		"rmagatti/session-lens",
		dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
		config = function()
			require("session-lens").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"tpope/vim-surround",

		-- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
		-- setup = function()
		--  vim.o.timeoutlen = 500
		-- end
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
	-- java
	{ "mfussenegger/nvim-jdtls", ft = "java" },
	-- { "rcarriga/nvim-dap-ui" },

	-- go
	{
		"olexsmir/gopher.nvim",
		config = function()
			require("gopher").setup({
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "gotests",
					impl = "impl",
					iferr = "iferr",
				},
			})
		end,
	},
	{ "leoluz/nvim-dap-go" },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- enable tailwind helper
lvim.builtin.cmp.formatting.format = require("tailwindcss-colorizer-cmp").formatter
-- set colorscheme
lvim.colorscheme = "fruitypebbles"

lvim.builtin.indentlines.options.show_current_context = false

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#2e2e2e", nocombine = true })
	end,
})

------------------------
-- Dap
------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
	return
end

dapgo.setup()

lvim.lsp.on_attach_callback = function(client, _)
	client.server_capabilities.semanticTokensProvider = nil
end
