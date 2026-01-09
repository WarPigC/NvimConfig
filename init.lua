require("config.lazy")

--NOTE: work on it
-- require("lspconfig").jedi_language_server.setup({})
-- require("lspconfig").clangd.setup({})

vim.cmd[[
nnoremap <silent> <TAB> :BufferLineCycleNext<CR>
nnoremap <silent> <S-TAB> :BufferLineCyclePrev<CR>

nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader>d "+d

:nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
:nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
]]
