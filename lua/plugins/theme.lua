return {

	{
		"ficcdaf/ashen.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {  }
	},

	{
		"rose-pine/neovim",
		lazy = false,
		priority = 10000,
		config = function()
			vim.cmd[[
			colorscheme rose-pine
			]]
		end
	}
}
