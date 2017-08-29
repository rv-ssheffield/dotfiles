call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
call plug#end()


" Map the leader key to SPACE
let mapleader="\<SPACE>"

" Path to python interpreter for neovim
let g:python3_host_prog = '/usr/local/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" Enable deoplete 
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = '~/gocode/bin'

" autocmd FileType go nmap <leader>r  <Plug>(go-run)
" run :GoBuild or :GoTestCompile based on the go file
" function! s:build_go_files()
"  let l:file = expand('%')
" if l:file =~# '^\f\+_test\.go$'
"    call go#test#Test(0, 1)
"  elseif l:file =~# '^\f\+\.go$'
"    call go#cmd#Build(0)
"  endif
"endfunction

" autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" leader shortcuts
" list buffer files
noremap <silent> <leader>l :ls<CR>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

"Use 24-bit (true-color) mode in Vim/Neovim 
if (has("termguicolors"))
  set termguicolors
endif

" colorscheme
let g:lightline = {
	\ 'colorscheme': 'onedark',
	\ }
syntax on
colorscheme onedark

set autowrite
set number
set splitbelow
set splitright
set noshowmode

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_fmt_command = "goimports"

" Error and warning signs.
" let g:ale_sign_error = '⤫'
" let g:ale_sign_warning = '⚠'
" Enable integration with airline.
" let g:airline#extensions#ale#enabled = 1

" let g:go_auto_type_info = 1

" let g:go_addtags_transform = "snakecase"
