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
" regular colorscheme
Plug 'fenetikm/falcon'
" high contrast colorscheme
Plug 'agude/vim-eldar'
Plug 'itchyny/lightline.vim'
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
" Plug 'sheerun/vim-polyglot'
Plug 'hashivim/vim-terraform'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
" Note taking
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc' " required for vim-notes
" Autocompletion
Plug 'Shougo/deoplete.nvim',
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'Shougo/neosnippet.vim' " Snippets
call plug#end()

" Map the leader key to SPACE
let mapleader="\<SPACE>"

let g:falcon_lightline = 1
let g:lightline = {
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
colorscheme falcon
" high contrast colorscheme
" colorscheme eldar 

" Enables italics
highlight Comment cterm=italic

" Hides regular status bar
set noshowmode
set noruler
set noshowcmd

" Autosave
set autowrite

" Shows line numbers
set number
set relativenumber

" Use 24-bit (true-color) mode in Vim/Neovim 
set termguicolors

" Makes stuff open to the right and below
set splitright
set splitbelow

" Tab settings - tabs converted to 4 spaces
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Go tab settings
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" ignore case when search is lowercase
set smartcase
set ignorecase

" Show type info after 250ms (default 800 ms)
set updatetime=250

" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect
" don't open the preview window
set completeopt-=preview

" Path to python interpreter for neovim
let g:python3_host_prog = '/usr/local/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" Enable deoplete 
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" fzf 
nmap ; :Buffers<CR>
nmap <leader>t :Files<CR>
nmap <leader>fl :BLines<CR>
nmap <leader>fal :Lines<CR>

let NERDTreeWinPos='right'
"
" Close NerDTREE and quit if it is the last thing open when :q
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
" Yank to clipboard
noremap <leader>yc "*y
" Yank a page
noremap <leader>yp <ESC>gg<bar><S-v><bar>G<bar>"*y
" close a buffer and keep split window open
noremap <leader>cb :b#<bar>bd#<bar>bn<bar>b#<CR>
" close buffer
nnoremap + :bd <CR>
" Play macro from q
noremap <leader>q @q
" syntax json
noremap <leader>json :set syntax=json<CR>:%!python -m json.tool<CR>
" syntax xml
noremap <leader>xml :set syntax=xml<CR>:%!xmllint --format -<CR>
" syntax html
noremap <leader>html :call FormatHTML()<CR>
" jump to the end of yank or paste
noremap <leader>' ']
" jump to next / previous error
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprev<CR>
" Wrap a WORD with the previous values e.g. quotes
inoremap <leader>r <ESC>lldWP

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
au FileType go noremap <leader>gr :only<CR> :GoRun<CR>
au FileType go noremap <leader>gn :GoRename<CR>
au FileType go noremap <leader>gef :GoReferrers<CR>
au FileType go noremap <leader>gt :GoTest<CR>
au FileType go noremap <leader>gl :GoLint<CR>
au FileType go noremap <leader>gi :GoInfo<CR>

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_fmt_command = "goimports"
let g:go_gocode_autobuild = 0 "disable vim-go autocompletion
" these might be causing issues with ale 
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_deadline = "5s"
let g:go_addtags_transform = "snakecase"

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

" Save folding
" augroup remember_folds
"   autocmd!
"   autocmd BufWinLeave *.* mkview
"   autocmd BufWinEnter *.* silent! loadview
" augroup END

" Snippets
let g:neosnippet#snippets_directory='~/dotfiles/vimsnippets'	
imap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <C-e> <Plug>(neosnippet_expand_or_jump)
xmap <C-e> <Plug>(neosnippet_expand_target)

" disable the neosnippet defaults - vim-go has it's own snippets
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }

" Notes
let g:notes_directories = ['~/OneDrive\ -\ Red\ Ventures/notes']

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" Converts Fuse routing group results down to CSV format with routingGroupId
" and routingGroupName
function! CleanFuse()
  :v/\(.*"name".*\|.*routingGroupId.*\)/d
  :%s/.*"routingGroupId": \(.*\),\n.*"name": "\(.*\)",/\1, \2/g
  :g/[0-9]\{1,5\}, [0-9]\{0,5\}-[0-9]\{6,7\}.*/d
  :g/[0-9]\{1,5\}, companyID=[0-9]\{0,7\}.*/d
endfunction

function! FormatHTML()
  :normal ggVGgJ 
  :%s/>\s*</>\r</g
  :set ft=html
  :normal ggVG=
endfunction
