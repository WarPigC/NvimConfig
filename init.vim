
"                                        NOTE: Copy text in clipboard using: <"+>{motion} command

set relativenumber                                              
set number
:set mouse=a
set clipboard="
set statusline=nvim_treesitter#statusline()
set foldexpr=nvim_treesitter#foldexpr()
set encoding=UTF-8
set termguicolors
set autoindent tabstop=4 shiftwidth=4 smarttab
:nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
:nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>

tnoremap <Esc> <C-\><C-n>      
" what? ^^^^^^

call plug#begin()    

" misc
Plug 'https://github.com/andweeb/presence.nvim'

" text processing / startup screen / logos
Plug 'altermo/ultimate-autopair.nvim'
Plug 'max397574/startup.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter',{'do':'TSUpdate'}
Plug 'folke/todo-comments.nvim'

" themes
Plug 'folke/tokyonight.nvim' 
Plug 'ficcdaf/ashen.nvim'
Plug 'kdheepak/monochrome.nvim'

" tabs and line
Plug 'akinsho/bufferline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim'

" file explorer
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

" lsp 
Plug 'williamboman/mason-lspconfig.nvim', { 'commit': '1a31f824b9cd5bc6f342fc29e9a53b60d74af245' }
Plug 'williamboman/mason.nvim', { 'commit': 'fc98833b6da5de5a9c5b1446ac541577059555be' }

" lsp config
Plug 'neovim/nvim-lspconfig', { 'commit': '4ea9083b6d3dff4ddc6da17c51334c3255b7eba5' }

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

:colorscheme ashen


lua << EOF

require('presence').setup()

require('ultimate-autopair').setup()

require('tokyonight').setup()

require('todo-comments').setup()

require("startup").setup({theme = "dashboard"})

require('lualine').setup({
options = {theme = 'auto'}
})


require("bufferline").setup{
	options= {
		separator_style = "slope"
	}
}



vim.cmd[[
nnoremap <silent> <TAB> :BufferLineCycleNext<CR>
nnoremap <silent> <S-TAB> :BufferLineCyclePrev<CR>
]]


require("mason").setup({
 ui = {
        icons = {
            package_installed = "✓",
            package_pending = "--",
            package_uninstalled = "X"
        }
    }
})


require("mason-lspconfig").setup()


-- install lsps
require("lspconfig").clangd.setup({})
require("lspconfig").jedi_language_server.setup({})


require'nvim-treesitter.configs'.setup {
   highlight = {
	 enable = true,
    disable = {},  -- list of language that will be disabled
    additional_vim_regex_highlighting = false ,
  },
}


 
-- NOTE: cmp setup

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

local capabilities = require('cmp_nvim_lsp').default_capabilities()
 
vim.diagnostic.config({ virtual_text = true })
    
EOF
