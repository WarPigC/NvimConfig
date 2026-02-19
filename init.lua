require("config.lazy")

--NOTE: work on it
-- require("lspconfig").jedi_language_server.setup({})
-- require("lspconfig").clangd.setup({})

vim.opt.termguicolors = true

vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.tabstop = 4

vim.opt.smarttab = true
vim.opt.autoindent = true

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp', 'c', 'html', 'typescript', 'javascript', 'css', 'python' },
  callback = function() vim.treesitter.start() end,
})

vim.cmd[[
colorscheme ashen

nnoremap <silent> <TAB> :BufferLineCycleNext<CR>
nnoremap <silent> <S-TAB> :BufferLineCyclePrev<CR>

nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader>d "+d

:nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
:nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
]]
