return {
    {
	"altermo/ultimate-autopair.nvim",
	event={'InsertEnter','CmdlineEnter'},
	branch='v0.6',
	opts = {}
    },

    {
      "startup-nvim/startup.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
      config = function()
	require "startup".setup()
      end
    },

    {
	"nvim-treesitter/nvim-treesitter",
	opts = {}
    },

    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = { }
    },

    {
	"nvim-tree/nvim-web-devicons",
    },

}
