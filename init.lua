local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

-- import packages
cmd("packadd packer.nvim")
require("plugins")
require("statusline")

-- use ripgrep for grep
opt.grepprg = "rg --vimgrep --hidden"

-- telescope settings
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<c-t>"] = trouble.open,
			},
			n = {
				["<c-t>"] = trouble.open,
			},
		},
	},
})
require("telescope").load_extension("fzf")
vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

-- general settings
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.smartcase = true
opt.termguicolors = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smarttab = true

-- Theming

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup()
vim.cmd([[colorscheme catppuccin]])

-- -- status line
local ctp_feline = require("catppuccin.groups.integrations.feline")
local ucolors = require("catppuccin.utils.colors")
local latte = require("catppuccin.palettes").get_palette("latte")
local frappe = require("catppuccin.palettes").get_palette("frappe")
local macchiato = require("catppuccin.palettes").get_palette("macchiato")
local mocha = require("catppuccin.palettes").get_palette("mocha")
local clrs = require("catppuccin.palettes").get_palette()

ctp_feline.setup({
	assets = {
		left_separator = "",
		right_separator = "",
		bar = "█",
		mode_icon = "",
		dir = "  ",
		file = "   ",
		lsp = {
			server = "  ",
			error = "  ",
			warning = "  ",
			info = "  ",
			hint = "  ",
		},
		git = {
			branch = "  ",
			added = "  ",
			changed = "  ",
			removed = "  ",
		},
	},
	sett = {
		text = ucolors.vary_color({ latte = latte.base }, clrs.surface0),
		bkg = ucolors.vary_color({ latte = latte.crust }, clrs.surface0),
		diffs = clrs.mauve,
		extras = clrs.overlay1,
		curr_file = clrs.maroon,
		curr_dir = clrs.flamingo,
		show_modified = true, -- show if the file has been modified
	},
	mode_colors = {
		["n"] = { "NORMAL", clrs.lavender },
		["no"] = { "N-PENDING", clrs.lavender },
		["i"] = { "INSERT", clrs.green },
		["ic"] = { "INSERT", clrs.green },
		["t"] = { "TERMINAL", clrs.green },
		["v"] = { "VISUAL", clrs.flamingo },
		["V"] = { "V-LINE", clrs.flamingo },
		["�"] = { "V-BLOCK", clrs.flamingo },
		["R"] = { "REPLACE", clrs.maroon },
		["Rv"] = { "V-REPLACE", clrs.maroon },
		["s"] = { "SELECT", clrs.maroon },
		["S"] = { "S-LINE", clrs.maroon },
		["�"] = { "S-BLOCK", clrs.maroon },
		["c"] = { "COMMAND", clrs.peach },
		["cv"] = { "COMMAND", clrs.peach },
		["ce"] = { "COMMAND", clrs.peach },
		["r"] = { "PROMPT", clrs.teal },
		["rm"] = { "MORE", clrs.teal },
		["r?"] = { "CONFIRM", clrs.mauve },
		["!"] = { "SHELL", clrs.green },
	},
})
require("feline").setup({
	components = ctp_feline.get(),
})

g.vim_markdown_auto_insert_bullets = 0
g.vim_markdown_new_list_item_indent = 0

-- Key bindings
g.mapleader = " "

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>g", ":Goyo<cr>")
-- generate uuids
map("n", "<leader>uuid", ':r !uuidgen|sed "s/.*/&,/"|tr "[A-Z]" "[a-z]"')
-- Edit the current configuration
map("n", "<leader>ve", ":Ex ~/.config/nvim<cr>")
-- Reload the current configuration
map("n", "<leader>vv", ":source ~/.config/nvim/init.lua<cr>")
-- Explore the current directory
map("n", "<C-b>", ":NvimTreeFindFileToggle<CR>")
-- Hide highlighted text
map("n", "<leader>n", "<cmd>noh<CR>")
-- Reload file
map("n", "<leader>r", "<cmd>edit<CR>")
-- Go to next quickfix
-- map("n", "gn", "<cmd><CR>")
-- Go to next quickfix
-- map("n", "gp", "<cmd>cprev<CR>")
-- Fuzzy find files in current directory
map("n", "<leader>t", "<cmd>Telescope find_files<cr>")
map("n", ";", ":")
map("n", ":", ";")
map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
map("n", "gq", "<cmd>cclose<cr>")
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true, expr = true })
map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>")
map("n", "<space>/", "<cmd>Telescope live_grep<CR>")
map("n", "<space>xq", "<cmd>TroubleToggle quickfix<CR>")

vim.keymap.set("n", "gn", function()
	require("trouble").next({ skip_groups = true, jump = true })
end)
vim.keymap.set("n", "gp", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end)

-- lsp configuration
local nvm_lsp = require("lspconfig")

-- rust
nvm_lsp.rust_analyzer.setup({
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
	flags = {
		-- This will be the default in neovim 0.7+
		debounce_text_changes = 150,
	},
	settings = {
		["rust-analyzer"] = {
			server = {
				path = "~/.cargo/bin/rust-analyzer",
			},
			assist = {
				importGranularity = "module",
				importPrefix = "by_self",
			},
			diagnostics = {
				disabled = { "unresolved-proc-macro" },
			},
			cargo = {
				loadOutDirsFromCheck = true,
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

-- go
nvm_lsp.gopls.setup({
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
	flags = {
		-- This will be the default in neovim 0.7+
		debounce_text_changes = 150,
	},
})

-- Typescript
nvm_lsp.tsserver.setup({
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "project-relative",
			importModuleSpecifierEnding = "minimal",
		},
	},
	on_attach = function(client, bufnr)
		-- Disable tsserver formatting as prettier/eslint does that.
		client.server_capabilities.documentFormattingProvider = false
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
	root_dir = nvm_lsp.util.root_pattern("package.json"),
	single_file_support = false,
})

-- Deno
nvm_lsp.denols.setup({
	root_dir = nvm_lsp.util.root_pattern("deno.json", "deno.jsonc"),
})

-- Biome
nvm_lsp.biome.setup({})

-- XML
nvm_lsp.lemminx.setup({})

-- luasnip setup
local luasnip = require("luasnip")

-- Copilot
require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
require("copilot_cmp").setup()

local lspkind = require("lspkind")
-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	format = lspkind.cmp_format({
		mode = "symbol",
		max_width = 50,
		symbol_map = { Copilot = "" },
	}),
})

nvm_lsp.golangci_lint_ls.setup({})

nvm_lsp.diagnosticls.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"json",
		"typescript",
		"typescriptreact",
		"css",
		"less",
		"scss",
		"pandoc",
	},
	init_options = {
		linters = {
			eslint = {
				command = "eslint",
				rootPatterns = { ".git" },
				debounce = 100,
				args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
				sourceName = "eslint",
				parseJson = {
					errorsRoot = "[0].messages",
					line = "line",
					column = "column",
					endLine = "endLine",
					endColumn = "endColumn",
					message = "[eslint] ${message} [${ruleId}]",
					security = "severity",
				},
				securities = {
					[2] = "error",
					[1] = "warning",
				},
			},
		},
		filetypes = {
			javascript = "eslint",
			javascriptreact = "eslint",
			typescript = "eslint",
			typescriptreact = "eslint",
		},
	},
})

nvm_lsp.templ.setup({})

-- Disable folding in markdown
g.vim_markdown_folding_disabled = 1

require("nvim-treesitter.configs").setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = { "javascript", "typescript", "tsx", "json", "svelte", "rust", "go", "toml" },

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- List of parsers to ignore installing
	ignore_install = {},

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	formatting.prettier,
	formatting.eslint_d,
	formatting.stylua,
	formatting.golines,
	diagnostics.golangci_lint.with({
		extra_args = { "-c", "./backend/.golangci-lint" },
	}),
}

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = function(client)
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
		client.server_capabilities.documentFormattingProvider = true
	end,
})

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

require("nvim-tree").setup({})

require("neogen").setup({
	enabled = true, --if you want to disable Neogen
	input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
	languages = {
		typescript = {
			template = {
				annotation_convention = "tsdoc",
			},
		},
	},
})
