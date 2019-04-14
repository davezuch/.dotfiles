if has('mac')
  let g:python_host_prog = '/usr/local/bin/python2'
elseif has('unix')
  let g:python_host_prog = '/usr/bin/python2'
endif

" use system clipboard
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
let g:mapleader = "\<Space>"

" Autoinstall vim-plug (https://github.com/junegunn/vim-plug)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" Plugins initialization start
call plug#begin('~/.vim/plugged')

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
Plug 'scrooloose/nerdcommenter'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Replace the default delimiters for PS / Haskell
let g:NERDCustomDelimiters = {
    \ 'purescript': { 'leftAlt': '{-', 'rightAlt': '-}', 'left': '--', 'right': '' },
    \ 'haskell': { 'leftAlt': '{-', 'rightAlt': '-}', 'left': '--', 'right': '' },
    \ }

Plug 'junegunn/vim-easy-align'
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'crusoexia/vim-javascript-lib', { 'for': ['javascript'] }
Plug 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
Plug 'ctrlpvim/ctrlp.vim'
"set path+=**
set wildignore+=*/node_modules/*,*/vendor/*,*/bower_components/*,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.git
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]output$',
  \ }
"toggle NERDTree with space-nt
map <leader>nt :NERDTreeToggle<CR>
"find current file in NERDTree with space-nf
map <leader>nf :NERDTreeFind<CR>
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim', { 'for': ['python'] }
Plug 'shawncplus/phpcomplete.vim', { 'for': ['php'] }
Plug 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8', { 'for': ['python'] }
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdatoast/elm.vim', { 'for': ['elm'] }
Plug 'raichoo/purescript-vim', { 'for': ['purescript'] }
" filetype settings
"au FileType javascript setl sw=2 sts=2 ts=2
au BufNewFile,BufRead *.js,*.html,*.css,*.sass,*.php
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2


Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell'] }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
set laststatus=2
Plug 'frigoeu/psc-ide-vim', { 'for': ['purescript'] }

let g:psc_ide_import_on_completion = v:false
"psc-ide bindings
au FileType purescript nm <buffer> <silent> <leader>L :Plist<CR>
au FileType purescript nm <buffer> <silent> <leader>l :Pload!<CR>
au FileType purescript nm <buffer> <silent> <leader>r :Prebuild!<CR>
au FileType purescript nm <buffer> <silent> <leader>f :PaddClause<CR>
au FileType purescript nm <buffer> <silent> <leader>t :PaddType<CR>
au FileType purescript nm <buffer> <silent> <leader>a :Papply<CR>
au FileType purescript nm <buffer> <silent> <leader>A :Papply!<CR>
au FileType purescript nm <buffer> <silent> <leader>C :Pcase!<CR>
au FileType purescript nm <buffer> <silent> <leader>i :Pimport<CR>
au FileType purescript nm <buffer> <silent> <leader>qa :PaddImportQualifications<CR>
au FileType purescript nm <buffer> <silent> <leader>g :Pgoto<CR>
au FileType purescript nm <buffer> <silent> <leader>p :Pursuit<CR>
au FileType purescript nm <buffer> <silent> <leader>T :Ptype<CR>

"Plug 'kana/vim-fakeclip'
Plug 'tpope/vim-surround'
Plug 'hdima/python-syntax', { 'for': ['python'] }
Plug 'djoshea/vim-autoread'

call plug#end()

" basic settings
filetype plugin indent on
set backspace=2
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
"extension based indent settings
au BufNewFile,BufRead *.{html,py,hs,rs}
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set fileformat=unix
au BufNewFile,BufRead *.{elm,purs,js,css,scss,php}
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
set expandtab
set autoindent
set fileformat=unix
set number
set list
set listchars=tab:▸\ 
highlight ExtraWhiteSpace ctermbg=red guibg=red
highlight Search ctermfg=black
match ExtraWhiteSpace /\s\+$/
autocmd BufWinEnter * match ExtraWhiteSpace /\s\+$/
autocmd InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"indent text and rehighlight -- vim tip_id=224
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" splits
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" style
syntax enable
set t_Co=256
let python_highlight_all=1
set hlsearch
highlight VertSplit cterm=none gui=none
" terminal overrides
highlight LineNr ctermfg=red
highlight CursorLineNr ctermfg=red
highlight Statement ctermfg=cyan

" basics
inoremap jk <ESC>
imap <BS> <Left><Del>
"nnoremap <dd> za " remap space to fold

"search for word under cursor with space-s
map <leader>s /<C-r><C-w><CR>

"toggle search highlighting with space-h
map <leader>h :set hlsearch! hlsearch?<CR>

" plugin settings

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_php_checkers = ['php']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['eslint']
let g:syntastic_python_flake8_args='--ignore=E402 --max-line-length=100'

" Trim whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" purescript
let purescript_indent_case = 2
let purescript_indent_where = 2
let purescript_indent_do = 2
let purescript_indent_dot = v:true
let purescript_indent_in = 0
