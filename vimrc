" VIM Configuration File

" set UTF-8 encoding
set enc=utf-8 fenc=utf-8 termencoding=utf-8
set nocompatible


" ================ General Config ====================
set showcmd                     "Show incomplete cmds down the bottom
set noshowmode                  "Don't show current mode down the bottom
set autoread                    "Reload files changed outside vim
set visualbell
set noerrorbells
set diffopt+=vertical

let mapleader=","

set clipboard+=unnamedplus
filetype plugin indent on


set backspace=2


" ================ Backup Settings===================
set writebackup
if !isdirectory(expand('~').'/.vim/.backup')
  silent !mkdir ~/.vim/.backup > /dev/null 2>&1
endif
let &bex = '~' . substitute(expand('%:p'), '/', '%', 'g')
set backup backupdir=~/.vim/.backup//
if !isdirectory(expand('~').'/.vim/.undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
endif
set undofile undodir=~/.vim/.undo//  " ending with `//` creates unique names


" ================ Caps Lock ========================
au VimEnter,FocusGained * :silent exec "!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"
au VimLeave,FocusLost * :silent exec "!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'"


" ================ Indentation ======================
set autoindent
set smartindent                 " use indentation of previous line
set cindent                     " Each new line will be automatically indented the correct amount according to
                                " the C indentation standard.
set smarttab
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab


" ================ Completion =======================
set wildmenu
set wildmode=longest,full
set wildignore+=*.pyc,__cache__,*.o,*.obj


" ================ Search ===========================
set incsearch
set hlsearch
set ignorecase
set smartcase

set omnifunc=syntaxcomplete#Complete
set completeopt=menu,preview,longest

"sometimes increases performance
set lazyredraw " can lead to problems with splits?
set ttyfast

let &colorcolumn="80,".join(range(120,999),",")


" =============== Plug-in Management =================={{{
call plug#begin('~/.vim/plugged')
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Make sure you use single quotes
" --------------- On-demand loading -------------------
Plug 'lilydjwg/colorizer', { 'on':  ['<Plug>Colorizer', 'ColorHighlight', 'ColorToggle']}
Plug 'chrisbra/vim-diff-enhanced', { 'on': ['PatienceDiff', 'EnhancedDiff']}
let neocomplete = !(v:version < 703 || !has('lua') || (v:version == 703 && !has('patch885')))
Plug 'Shougo/neocomplete.vim', Cond(neocomplete) | Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets' " | Plug 'Shougo/echodoc.vim'
Plug 'vim-scripts/vimwiki', { 'on': ['<Plug>VimwikiIndex','<Plug>VimwikiTabIndex', '<Plug>VimwikiUISelect']}
Plug 'wkentaro/conque.vim', {'on': ['ConqueTerm', 'ConqueTermSplit', 'ConqueTermVSplit', 'ConqueTermTab']}
Plug 'roman/golden-ratio', { 'on': ['<Plug>(golden_ratio_resize)']}
Plug 'junegunn/limelight.vim', {'on': ['Limelight',]}

Plug 'tpope/vim-speeddating'
Plug 'dhruvasagar/vim-table-mode'

" ------------------- Python --------------------------
Plug 'kevinw/pyflakes-vim', { 'for': 'python'}
Plug 'heavenshell/vim-pydocstring', { 'for': 'python', 'on':  '<Plug>pydocstring'}
Plug 'alfredodeza/pytest.vim', { 'for': 'python', 'on': 'Pytest'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'tmhedberg/SimpylFold', {'for': 'python'}


" ------------------- rst -----------------------------
Plug 'Rykka/riv.vim' ", {'for': ['rst', 'python']}
Plug 'Rykka/InstantRst', {'on': 'InstantRst', 'do': 'pip install https://github.com/Rykka/instant-rst.py/archive/master.zip --user'}

" ------------------- Unite --------------------------
Plug 'Shougo/unite.vim'
      \ | Plug 'Shougo/unite-outline' | Plug 'Shougo/unite-session' | Plug 'ujihisa/unite-colorscheme'
      \ | Plug 'Shougo/unite-help' | Plug 'osyo-manga/unite-quickfix' | Plug 'Shougo/neomru.vim'
      \ | Plug 'kmnk/vim-unite-giti'
Plug 'thinca/vim-qfreplace'
Plug 'Shougo/vimfiler.vim' | Plug 'romgrk/vimfiler-prompt', { 'on' : 'VimFilerPrompt', 'for' : 'vimfiler'}

Plug 'majutsushi/tagbar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'spiiph/vim-space'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-fugitive' | Plug 'gregsexton/gitv', { 'on': ['Gitv']}
Plug 'Konfekt/FastFold'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/TaskList.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'google/vim-searchindex'
"Plug 'DerWeh/SearchComplete'  " doesn't work with \v
"Plug 'xolox/vim-easytags'| Plug 'xolox/vim-misc'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neomake/neomake'

Plug 'easymotion/vim-easymotion'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline' |  Plug 'vim-airline/vim-airline-themes'

" ------------------- text objects -------------------
Plug 'kana/vim-textobj-user'
Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'glts/vim-textobj-comment'

" personal modified
Plug 'DerWeh/papercolor-theme'
Plug 'DerWeh/vim-ipython', {'for': 'python', 'on': ['IPython', 'IPythonNew']}

" Add plug-in to &runtimepath
call plug#end()
" }}}


" ===================== Color Settings ==============={{{
set t_Co=256                       " turn syntax highlighting on
set background=light
colorscheme PaperColor
syntax enable                      " keeps highlighting  ;
highlight ExtraWhitespace ctermbg=LightRed guibg=#:ffafd7
au InsertLeave * match ExtraWhitespace /\s\+$/
                                   " Show whitespace
set showmatch                      " highlight matching braces
set nocursorcolumn
syntax sync minlines=100 maxlines=260
set synmaxcol=800                  " Don't try to highlight lines longer than 800 characters,
                                   "in order to speed up the view port.
" }}}


" ==================== Folding ======================={{{
set foldmethod=marker
fu! CustomFoldText()
  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  "strip foldmarkers
  let markexpr = escape(substitute(&foldmarker, ',', '|', 'g'),'{')
  " TODO: check comment sign for filetype, add first line if comment
  let whitespace = '(\w\s*)?["|#]\s*|\s*$'
  let strip_line = substitute(line, '\v'.markexpr.'|'.whitespace, "", 'g')
  let strip_line = substitute(strip_line, '\v'.whitespace, "", 'g')
  let strip_line = substitute(strip_line, '\v^(\s*)', '\1<', '').'>'
  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let lineCount = line("$")
  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(".", w - strwidth(foldSizeStr.strip_line.foldLevelStr.foldPercentage))
  return strip_line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
set foldtext=CustomFoldText()
"}}}


" ===================== Key Mappings ================={{{
nnoremap ; :|                       " faster `commands` using ;
vnoremap ; :|                       " faster `commands` using ;

nnoremap / /\v|                     " use Python regular expressions
vnoremap / /\v|                     " use Python regular expressions

nnoremap p p=`]<C-o>|               " Auto indent pasted text
nnoremap P P=`]<C-o>|

cnoremap w!! w !sudo tee % >/dev/null
nmap Q <Nop>|  " Remove mapping for `Ex` mode

nmap <F2> :w<CR>|  " in normal mode F2 will save the file
imap <F2> <C-o>:w<CR>|  " in insert mode F2 will exit insert, save, enters insert again
set pastetoggle=<F3>|  " toggle paste mode for pasting code without intend
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>|  " switch between header/source with F4
map <leader>h :nohl<CR>|  " Remove highlight from search results

" -------------------- Plugin Mappings ---------------
" Plug-in mapping{{{
nmap <leader>fe :VimFilerExplorer<CR>
nmap <leader>ct <Plug>Colorizer
map <F8> <Esc>:TagbarToggle<CR>
nnoremap <silent> <F10> :YRShow<CR>
nmap <silent> <Leader>pd <Plug>(pydocstring)
nmap <Leader>ww <Plug>VimwikiIndex
nmap <Leader>wt <Plug>VimwikiTabIndex
nmap <Leader>ws <Plug>VimwikiUISelect
nmap <C-w>r <Plug>(golden_ratio_resize)
nmap <C-w>f <C-w><Bar><C-w>_

"Unite mappings
" generate unite prefix, nmap ? [unite] can use it then
nmap <F1> :Unite -buffer-name=help -start-insert help<CR>
nnoremap [unite] <Nop>
nmap <leader>u [unite]
nmap [unite] :Unite |
nmap [unite]b :Unite -buffer-name=bookmark bookmark<cr>
nmap [unite]/ :Unite -buffer-name=search line:forward -start-insert -no-quit -custom-line-enable-highlight<CR>
nnoremap <silent> <space>f :Unite -buffer-name=files -start-insert
      \ file_rec/async file_mru bookmark:!<cr>
nnoremap <space>/ :Unite -buffer-name=grep -no-empty -no-resize grep<cr>
nnoremap <space>s :Unite -buffer-name=buffers -quick-match buffer<cr>
" }}}


" -------------------- Window Movement ---------------
map <C-h> <C-w>h|                     " move with <C-?>
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap c<C-j> :bel sp new<cr>       " creat new split with c<C-?>
nnoremap c<C-k> :abo sp new<cr>
nnoremap c<C-h> :lefta vsp new<cr>
nnoremap c<C-l> :rightb vsp new<cr>
nnoremap g<C-j> <C-w>j:let &winheight = &lines * 7 / 10<cr>
nnoremap g<C-k> <C-w>k:let &winheight = &lines * 7 / 10<cr>
onoremap g<C-h> <C-w>h<C-w>_|         " move and focus (resize) with g<C-?>
nnoremap g<C-l> <C-w>l<C-w>_
nnoremap d<C-j> <C-w>j<C-w>c|         " delete window with d<C-?>
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c

" Move between tabs
map <Leader><TAB> <esc>:tabprevious<CR>
map <Leader><S-TAB> <esc>:tabnext<CR>

" Intending codeblocks
vmap < <gv
vmap > >gv
"}}}

" go to last cursor position upon opening files
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif


if has("autocmd")
  au BufAdd,BufNewFile,BufRead * call s:diff_lang_settings()
endif
function! s:diff_lang_settings() "{{{
  if &diff
    nmap <M-Down> ]c
    nmap <M-Up> [c
    setl nospell
  elseif &readonly || !&modifiable
    setl nospell
  else
    setl spell spelllang=en_us
    nmap <M-Down> ]s
    nmap <M-Up> [s
  endif
endfunction "}}}

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit# | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

" format options{{{
set textwidth=0
set linebreak  " Break line without break the word.

let &showbreak='➣➣\'
set formatoptions+=n
set formatoptions+=2
set formatoptions+=w
set formatoptions+=t
set formatoptions+=q
set formatoptions+=l
set formatoptions+=j
au FileType vim setlocal fo-=r fo-=o
set formatoptions-=r
set formatoptions-=o
"}}}

" Plug-ins {{{

" neocomplete {{{
if neocomplete
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_camel_case = 1
  let g:neocomplete#auto_completion_start_length = 2

  " increase limit for tag cache files
  let g:neocomplete#sources#tags#cache_limit_size = 16777216 " 16MB
  " default: 100, more to get more methods (e.g. np.<TAB>)
  let g:neocomplete#max_list = 500

  "" <TAB>: completion.
  "inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
  " For smart TAB completion.
  "inoremap <expr><TAB>  pumvisible() ? '\<C-n>' :
  "        \ <SID>check_back_space() ? '\<TAB>' :
  "        \ neocomplete#start_manual_complete()

  inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' :
          \ <SID>check_back_space() ? '<S-TAB>' :
          \ neocomplete#start_manual_complete()

  function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction"}}}
  let g:neocomplete#enable_auto_delimiter = 1
  " let g:neocomplete#enable_auto_select = 1
  " Search from neocomplete, omni candidates, vim keywords.
  let g:neocomplete#fallback_mappings =
    \ ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]

  let g:neocomplete#use_vimproc = 1
  let g:neosnippet#enable_completed_snippet = 1
  " enable neosnippet
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  imap <expr><TAB>
   \ pumvisible() ? '<C-n>' :
   \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
   \ ! <SID>check_back_space() ? neocomplete#start_manual_complete() :
   \ "\<TAB>"

  imap <c-j> <Plug>(neosnippet_expand_or_jump)
  smap <c-j> <Plug>(neosnippet_expand_or_jump)
  xmap <c-j> <Plug>(neosnippet_expand_target)

  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=n
  endif
endif
"}}}

" YankRing {{{
" don't populate yank ring with singe elements
let g:yankring_min_element_length = 2
" let g:yankring_record_insert = 1
" only works if you have Vim with clipboard support
let g:yankring_manual_clipboard_check = 1
let g:yankring_replace_n_nkey = '<C-n>'
let g:yankring_replace_n_pkey = '<C-p>'
"}}}

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
" nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
map  <Leader>n <Plug>(easymotion-next)
map  <Leader>N <Plug>(easymotion-prev)
" }}}

"" indent guides setting {{{
"let g:indent_guides_color_change_percent = 15
"let g:indent_guides_guide_size = 1
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar']
"let g:indent_guides_default_mapping = 1
"let g:indent_guides_start_level = 1
""}}}

"indentLine {{{
let g:indentLine_fileTypeExclude = ['help', 'text', 'markdown']
let g:indentLine_setConceal = 0
"}}}

" airline configuration {{{
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git"]
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_detect_spell=0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
"let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
"let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.paste = 'PASTE'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

"" powerline symbols
"let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

"" old vim-powerline symbols
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'
"}}}

" TagBar{{{
let g:tagbar_sort = 0
" }}}

" Golden-Ratio {{{
let g:golden_ratio_autocommand = 0
let g:golden_ratio_exclude_nonmodifiable = 1
" }}}

"ConqueTerm {{{
let g:ConqueTerm_Color = 0
let g:ConqueTerm_InsertOnEnter = 0
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_FastMode = 1
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_ToggleKey = '<Leader><F8>'
let g:ConqueTerm_ExecFileKey = '<Leader><F11>'
let g:ConqueTerm_SendFileKey = '<Leader><F10>'
let g:ConqueTerm_SendVisKey = '<Leader><F9>'
"}}}

"VimWiki {{{
" let g:vimwiki_folding = 'expr'
let g:vimwiki_table_mappings = 0
"}}}

"Ipython {{{
let g:ipython_greedy_matching = 1
let g:ipy_cell_folding = 0
let g:ipython_dictionary_completion = 1
let g:ipy_monitor_subchannel = 1
"}}}

"Unite{{{
" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
imap <buffer> <C-n>   <Plug>(unite_select_next_line)
imap <buffer> <C-p>   <Plug>(unite_select_previous_line)

nmap <buffer> <C-n>   <Plug>(unite_select_next_line)
nmap <buffer> <C-p>   <Plug>(unite_select_previous_line)

nmap <silent><buffer><expr> Enter unite#do_action('switch')
nmap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
nmap <silent><buffer><expr> <C-s> unite#do_action('splitswitch')
nmap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

imap <silent><buffer><expr> Enter unite#do_action('switch')
imap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
imap <silent><buffer><expr> <C-s> unite#do_action('splitswitch')
imap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

nmap <buffer> <C-g> <Plug>(unite_toggle_auto_preview)

nmap <buffer> <ESC> :UniteClose<cr>
nnoremap <silent><buffer><expr> cd unite#do_action('lcd')
nmap <buffer> <C-z> <Plug>(unite_toggle_transpose_window)
nmap <buffer><silent> <c-r> <Plug>(unite_redraw)
endfunction

if executable('ag') == 1
let g:unite_source_grep_command = 'ag'
let g:unite_source_rec_async_command =
      \['ag', '--follow', '--nocolor', '--hidden', '-g', '']
let g:unite_source_grep_default_opts =
      \ '-i --vimgrep --hidden --ignore ' .
      \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
endif

call unite#custom#profile('default', 'context', {
\   'direction': 'botright',
\ })
call unite#custom#profile('outline', 'context', {'direction': 'topleft'})

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
    \ 'ignore_pattern', join([
    \ '\.git/',
    \ '__cache__/',
    \ '\.undo',
    \ '\.backup',
    \ ], '\|'))
call unite#custom#source('files,file,file/new,buffer,file_rec,file_rec/async,file_mru', 'matchers', 'matcher_fuzzy')

"}}}

" VimFiler {{{
let g:vimfiler_as_default_explorer = 1
call vimfiler#custom#profile('explorer', 'context', {
      \  'safe': 0,
      \  'simple': 0
      \ })
autocmd FileType vimfiler nmap <buffer> i :VimFilerPrompt<CR>
let g:vimfiler_tree_leaf_icon = '¦'
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
" let g:vimfiler_file_icon = '-'
" let g:vimfiler_marked_file_icon = '*'
"}}}

" Vim-Space{{{
let g:space_no_character_movements = 1
"}}}

" Latex {{{
let g:tex_conceal= 'adgm'
"}}}

" Limelight {{{
" let g:limelight_bop = '^\s*\n^\w'
" let g:limelight_eop = '\ze\n^\s*\n^\w'
"}}}

" Riv {{{
let g:riv_python_rst_hl=1
"}}}

"}}}
