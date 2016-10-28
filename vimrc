" VIM Configuration File

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set nocompatible

filetype plugin indent on

set autoindent  " use indentation of previous line
set smartindent  " use intelligent indentation for C
" Each new line will be automatically indented the correct amount according to
" the C indentation standard.
set cindent

" configure tabwidth and insert spaces instead of tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set foldmethod=marker


" plug-in management {{{
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim', { 'on':  ['CtrlP', 'CtrlPMixed', 'CtrlPMRU']}
Plug 'lilydjwg/colorizer', { 'on':  ['<Plug>Colorizer', 'ColorHighlight', 'ColorToggle']}
Plug 'majutsushi/tagbar'  " , { 'on':  'TagbarToggle'}
Plug 'kevinw/pyflakes-vim', { 'for': 'python'}


Plug 'chrisbra/vim-diff-enhanced'
Plug 'tpope/vim-fugitive'
Plug 'Konfekt/FastFold'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/TaskList.vim'

Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline' |  Plug 'vim-airline/vim-airline-themes'

" personal modified
Plug '~/.vim/plugged/papercolor-theme'

" Add plug-in to &runtimepath
call plug#end()
" }}}

" turn syntax highlighting on
set t_Co=256
syntax on


set background=light
colorscheme PaperColor
" Show whitespace
highlight ExtraWhitespace ctermbg=Magenta guibg=#ffafd7
au InsertLeave * match ExtraWhitespace /\s\+$/

" highlight matching braces
set showmatch

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
" display incomplete commands
set showcmd

set incsearch
set hlsearch
set ignorecase
set smartcase

"sometimes increases performance
set lazyredraw " can lead to problems with splits?
set ttyfast


"" store swapfiles in a central location
"set directory=~/.vim/tmp/swap//,.,/var/tmp//,/tmp//
"if !isdirectory(expand("~") . '/.vim' . '/tmp/swap')
"  call mkdir(expand("~") . '/.vim' . '/tmp/swap', 'p')
"endif

"" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
"" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
"" Load standard tag files
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4

" key mappings {{{

" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR><Space>i
" toggle paste mode for pasting code without intend
set pastetoggle=<F3>
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" Remove highlight from search results
map <C-n> :nohl<CR>

" Plug-in mapping{{{
nnoremap <silent> <C-p> :CtrlP<CR>
nmap <silent> <Leader>pd <Plug>(pydocstring)
nmap <leader>tc <Plug>Colorizer
map <F8> <Esc>:TagbarToggle<CR>
" }}}


" Move between windows with Ctrl+[h,j,k,l]
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Move between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Intending codeblocks
vmap < <gv
nmap < <gv
vmap > >gv
nmap > >gv

" goto definition with F12
map <F12> <C-]>
" in diff mode we use the spell check keys for merging
if &diff
  " diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
else
  " spell settings
  set spell
  :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  set spellfile=~/.vim/spellfile.add
  map <M-Down> ]s
  map <M-Up> [s
endif
"}}}

" go to last cursor position upon opening files
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,preview,longest




" colorize {{{
let g:colorizer_startup = 0
"let g:colorizer_maxlines = 800
" }}}

" easy motion {{{
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Move to line
map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
map  <Leader>n <Plug>(easymotion-next)
map  <Leader>N <Plug>(easymotion-prev)
" }}}

" indent guides setting {{{
let g:indent_guides_color_change_percent = 15
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar']
let g:indent_guides_default_mapping = 1
let g:indent_guides_start_level = 1
"}}}

" airline configuration {{{
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git"]
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_detect_spell=0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.paste = 'PASTE'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.spell = ''
"}}}

" TagBar{{{
let g:tagbar_sort = 0
" }}}
