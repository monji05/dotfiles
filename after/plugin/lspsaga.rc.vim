if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga()

EOF

nnoremap <silent><Space>j <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent>gs :Lspsaga signature_help<CR>
nnoremap <silent>gh <Cmd>Lspsaga lsp_finder<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>
