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
" Theme
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
" Autocompletion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
" Linting
Plug 'w0rp/ale'
" Other stuff
Plug 'scrooloose/nerdtree' " File explorer 
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'airblade/vim-gitgutter' " Git diffs in gutter
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'jiangmiao/auto-pairs' " Helps with { } stuff
Plug 'nathanaelkane/vim-indent-guides' " Indent lines
Plug 'easymotion/vim-easymotion' " Makes motion commands better 
" Language specific
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" Plug 'pangloss/vim-javascript'
" Plug 'posva/vim-vue'
Plug 'sheerun/vim-polyglot'
Plug 'hashivim/vim-terraform'
call plug#end()

" Map the leader key to SPACE
let mapleader="\<SPACE>"

let g:lightline = {
   \ 'colorscheme': 'onedark',
   \ 'active': {
   \   'left': [ [ 'mode', 'paste' ],
   \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
	 \   'right': [ [ 'filetype' ] ]
   \ },
   \ 'inactive': {
	 \    'left': [['filename']],
	 \    'right': [['filetype']] 
   \  },
   \ 'component_function': {
   \   'gitbranch': 'fugitive#head'
   \ },
   \ }
let g:lightline.separator = { 'left': '', 'right': '' }
syntax on
colorscheme onedark

" hides regular status bar
set noshowmode
set noruler
set noshowcmd

" Shows line numbers
set number
set relativenumber
" Use 24-bit (true-color) mode in Vim/Neovim 
set termguicolors
" Makes stuff open to the right and below
set splitright
set splitbelow

" Tab settings - tabs converted to 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" Go tab settings
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" ignore case when search is lowercase
set smartcase
set ignorecase

" Show type info after 400s (default 800 ms)
set updatetime=400

" Path to python interpreter for neovim
let g:python3_host_prog = '/usr/local/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" Enable deoplete 
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = '/Users/zjohnson/gocode/bin/gocode'

" fzf 
nmap ; :Buffers<CR>
nmap <leader>t :Files<CR>
nmap <leader>fl :BLines<CR>
nmap <leader>fal :Lines<CR>

" :ALEFix will try and fix JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint']
\}

let g:ale_linters = {'go': ['gometalinter', 'gofmt']}

" Error and warning signs.
let g:ale_sign_error = '⍭'
let g:ale_sign_warning = '⌽'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_column_always = 1

let NERDTreeWinPos='right'

" leader shortcuts
" Source config
noremap <leader>so :so ~/.config/nvim/init.vim<CR>
" Write
noremap <leader>w :w<CR>
" Explore
noremap <leader>e :NERDTreeFind<CR>
noremap <leader>m :NERDTreeToggle<CR>
" Close
noremap <leader>cl :close<CR>
" Vertical split
noremap <leader>vs :vsp<CR><C-W><C-h>
" Only 
noremap <leader>o :only<CR>
" list buffer files
noremap <silent> <leader>l :ls<CR>
" Yank to clipboard
noremap <leader>yc "*y
" Yank a page
noremap <leader>yp <ESC>gg<bar><S-v><bar>G<bar>"*y
" close a buffer and keep split window open
noremap <leader>cb :b#<bar>bd#<bar>bn<bar>b#<CR>
" Play macro from q
noremap <leader>q @q
" syntax json
noremap <leader>json :set syntax=json<CR>:%!python -m json.tool<CR>
" syntax xml
noremap <leader>xml :set syntax=xml<CR>:%!xmllint --format -<CR>

" search for a character
nmap s <Plug>(easymotion-overwin-f)

" next and previous buffer
noremap <Tab> :bnext<CR>
noremap <S-Tab> :bprevious<CR>
" <Ctrl-opt-l> redraws the screen and removes any search highlighting.
nnoremap <C-l> :nohl<CR><C-l>
" Close bottom window (quickfix window usually)
nnoremap <leader>cq <C-w><C-j>:close<CR>

inoremap jk <ESC>

" Go shortcuts
au FileType go noremap <leader>gb :GoBuild<CR>
au FileType go noremap <leader>gr :GoRun<CR>
au FileType go noremap <leader>gn :GoRename<CR>
au FileType go noremap <leader>gef :GoReferrers<CR>
au FileType go noremap <leader>gt :GoTest<CR>

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_fmt_command = "goimports"
" these might be causing issues with ale
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_deadline = "5s"

" shows type information
let g:go_auto_type_info = 1

" let g:go_addtags_transform = "snakecase"

" Close NerDTREE and quit if it is the last thing open when :q
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" indentation
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" Save folding
" augroup remember_folds
"   autocmd!
"   autocmd BufWinLeave *.* mkview
"   autocmd BufWinEnter *.* silent! loadview
" augroup END
