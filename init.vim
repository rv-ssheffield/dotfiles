" something to do with linting
" set rtp+=~/gocode/src/github.com/golang/lint/misc/vim

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
" high contrast colorscheme
" Plug 'agude/vim-eldar'
" regular colorscheme
Plug 'itchyny/lightline.vim'
" tabs for buffers
Plug 'ap/vim-buftabline'
" Linting
Plug 'w0rp/ale'
" Other stuff
Plug 'scrooloose/nerdtree' " File explorer 
" Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'airblade/vim-gitgutter' " Git diffs in gutter
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'jiangmiao/auto-pairs' " Helps with { } stuff
Plug 'nathanaelkane/vim-indent-guides' " Indent lines
Plug 'easymotion/vim-easymotion' " Makes motion commands better 
" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': ':UpdateRemotePlugins' }
" Language specific
Plug 'fatih/vim-go', { 'do': ':InstallRemoteBinaries' }
" Plug 'sheerun/vim-polyglot'
Plug 'hashivim/vim-terraform'
" Plug 'pangloss/vim-javascript'
" Plug 'posva/vim-vue'
" Note taking
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc' " required for vim-notes
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
" high contrast colorscheme
" colorscheme eldar 

" hides regular status bar
set noshowmode
set noruler
set noshowcmd

set autowrite

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
set updatetime=250

" neocomplete like
" set completeopt+=noinsert
" deoplete.nvim recommend
" set completeopt+=noselect
" don't open the preview window
set completeopt-=preview

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
" Horizontal split
noremap <leader>hs :split<CR>
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
" Switch windows
nnoremap <leader><Tab> <C-W><C-W>
" Redraws the screen and removes any search highlighting.
nnoremap <leader>ch :nohl<CR>
" Close bottom window (quickfix window usually)
nnoremap <leader>cq <C-w><C-j>:close<CR>

inoremap jk <ESC>

" Go shortcuts
au FileType go noremap <leader>gb :GoBuild<CR>
au FileType go noremap <leader>gr :GoRun<CR>
au FileType go noremap <leader>gn :GoRename<CR>
au FileType go noremap <leader>gef :GoReferrers<CR>
au FileType go noremap <leader>gt :GoTest<CR>
au FileType go noremap <leader>gl :GoLint<CR>
au FileType go noremap <leader>gi :GoInfo<CR>

" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_types = 1
let g:go_fmt_command = "goimports"
" these might be causing issues with ale
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_deadline = "5s"
let g:go_addtags_transform = "snakecase"

" Close NerDTREE and quit if it is the last thing open when :q
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" indentation
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" :ALEFix will try and fix JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint']
\}

let g:ale_linters = { 'go': ['go build', 'golint', 'gofmt', 'go vet', 'go'] }

" Error and warning signs.
let g:ale_sign_error = '⍭'"
let g:ale_sign_warning = '⌽'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_column_always = 1

" buftabline settings
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1 
let g:buftabline_separators = 1
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
hi link BufTabLineCurrent PmenuSel
hi link BufTabLineActive TablineSel

" Save folding
" augroup remember_folds
"   autocmd!
"   autocmd BufWinLeave *.* mkview
"   autocmd BufWinEnter *.* silent! loadview
" augroup END

" Notes
let g:notes_directories = ['~/Documents/notes']

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
