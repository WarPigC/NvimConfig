
"                                        NOTE: Copy text in clipboard using: <"+>{motion} command
    
"                                       BUG: fix jdtls

set relativenumber                                              
set number
:set mouse=a
set clipboard="
set statusline=nvim_treesitter#statusline()
set foldexpr=nvim_treesitter#foldexpr()
set encoding=UTF-8
set termguicolors
set autoindent expandtab tabstop=4 shiftwidth=4
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
Plug 'mfussenegger/nvim-jdtls'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'williamboman/mason.nvim'

" lsp config
Plug 'neovim/nvim-lspconfig'
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

require("mason-lspconfig").setup({})

-- install lsps
require("lspconfig").clangd.setup({})
require("lspconfig").jedi_language_server.setup({})


-- jdtls config
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/path/to/workspace-root/' .. project_name


local config = {
    -- starts server
  cmd = {

    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', 'C:\\Users\\callm\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\plugins\\org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version
    '-configuration', 'C:\\Users\\callm\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\config_win',
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.
    '-data', workspace_dir,
  },
  root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
  settings = {
    java = {
    }
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

require'nvim-treesitter.configs'.setup {
   highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
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
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

    
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
require('lspconfig')['jedi_language_server'].setup {
    capabilities = capabilities
  }

EOF
