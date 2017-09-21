" for markdown-composer plugin
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin('~/.config/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'w0rp/ale'
Plug 'posva/vim-vue'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'pangloss/vim-javascript'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
call plug#end()

" Map the leader key to SPACE
let mapleader="\<SPACE>"

" colorscheme
let g:lightline = {
	\ 'colorscheme': 'onedark',
	\ }
syntax on
colorscheme onedark

set autowrite
set number
set splitbelow
"Use 24-bit (true-color) mode in Vim/Neovim 
set termguicolors
set splitright
set noshowmode

set noexpandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" ignore case when search is lowercase
set smartcase
set ignorecase

" Path to python interpreter for neovim
let g:python3_host_prog = '/usr/local/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" Enable deoplete 
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = '/Users/zjohnson/gocode/bin/gocode'

" Ctrl-P settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|vendor\|git'

" :ALEFix will try and fix JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" leader shortcuts
" Explore
noremap <leader>ex :Explore<CR>
" Close
noremap <leader>cl :close<CR>
" list buffer files
noremap <silent> <leader>l :ls<CR>
" close a buffer and keep split window open
noremap <leader>cb :b#<bar>bd#<CR>
" syntax json
noremap <leader>json :set syntax=json<CR>:%!python -m json.tool<CR>
" syntax xml
noremap <leader>xml :set syntax=xml<CR>:%!xmllint --format -<CR>

" Go shortcuts
noremap <leader>gb :GoBuild<CR>

" next and previous buffer
noremap <Tab> :bnext<CR>
noremap <S-Tab> :bprevious<CR>
" <Ctrl-opt-l> redraws the screen and removes any search highlighting.
nnoremap <C-l> :nohl<CR><C-l>

inoremap jk <ESC>

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_fmt_command = "goimports"

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" shows type information
let g:go_auto_type_info = 1

" let g:go_addtags_transform = "snakecase"

