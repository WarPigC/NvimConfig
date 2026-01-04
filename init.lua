require("config.lazy")

require("lualine").setup{}

require("bufferline").setup{
	options = {
		separator_style = "slant",
	}
}

require("mason-lspconfig").setup{}

vim.cmd[[
nnoremap <silent> <TAB> :BufferLineCycleNext<CR>
nnoremap <silent> <S-TAB> :BufferLineCyclePrev<CR>

:nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
:nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
]]
