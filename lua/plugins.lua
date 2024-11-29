return require("packer").startup(function()
	use("ayu-theme/ayu-vim") -- theme

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	use("neovim/nvim-lspconfig")

	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin

	use("tpope/vim-surround") -- changing surrounding brackets and quotes
	use("tpope/vim-commentary") -- commenting using `gcc`

	use("tpope/vim-fugitive") -- git integration

	-- use("github/copilot.vim")
	use({ "zbirenbaum/copilot.lua" })

	use("godlygeek/tabular")
	-- use("preservim/vim-markdown")

	use("junegunn/goyo.vim")

	-- use("mhartington/formatter.nvim")
	use("jose-elias-alvarez/null-ls.nvim")

	use("nvim-treesitter/nvim-treesitter")

	-- additional markdown file tools
	use("SidOfc/mkdx")

	-- theme
	use({ "catppuccin/nvim", as = "catppuccin" })

	use("kyazdani42/nvim-web-devicons")

	use({ "feline-nvim/feline.nvim" })

	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	})

	use({ "CopilotC-Nvim/CopilotChat.nvim", branch = "canary" })

	use({
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	})

  use({"onsails/lspkind.nvim"})
end)
