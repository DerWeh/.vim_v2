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
" set noexpandtab
set expandtab


set foldmethod=marker

" turn syntax highlighting on
set t_Co=256
syntax on


set background=light
" colorscheme PaperColor
" Show whitespace
highlight ExtraWhitespace ctermbg=Magenta guibg=#ffafd7
au InsertLeave * match ExtraWhitespace /\s\+$/

" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
" display incomplete commands
set showcmd
" The Vim editor will start searching when you type the first character of the
" search string.
set incsearch
" Any search highlights the string matched by the search.
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
"" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
"let g:DoxygenToolkit_authorName="John Doe <john@doe.com>"

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
  setlocal spell spelllang=en
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

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes


" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Add plugins to &runtimepath
call plug#end()
