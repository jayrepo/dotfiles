set shortmess=atI " Quick start
lang mes en_US.UTF-8
set termguicolors
call plug#begin('~/.local/share/nvim/bundle')
"Plug 'Valloric/YouCompleteMe'
"Plug 'Shougo/vimproc.vim'
"Plug 'Shougo/unite.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'Shougo/denite.nvim'
Plug 'morhetz/gruvbox'
" Plug 'Shougo/neomru.vim'
" Plug 'Shougo/neoyank.vim'
" Plug 'Shougo/vimshell.vim'
Plug 'mhinz/vim-startify'
" Plug 'Shougo/vimfiler.vim'
Plug 'mbbill/undotree'
Plug 'itchyny/lightline.vim'
" Plug 'othree/yajs.vim' " js syntax
" Plug 'gavocanov/vim-js-indent' " js indent
Plug 'scrooloose/syntastic'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" Plug 'mbbill/fencview'
Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
call plug#end()

" ============ Encodeing ============
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,sjis,euc-kr,latin1
set fileformats=unix,dos

" ========== General Config ==========
set mouse=a         " Enable mouse
set hidden          " Allow buffer switching without saving
set history=1000    " Enable Longer cmd history
set showmode        " Display the current mode
set number          " SHow line numbers
set showmatch       " Show matching brackets/parenthesis
set linespace=0     " No extra spaces between rows
set nowrap          " No wrap long lines
set linebreak       " Wrap lines at linebreaks
set winminheight=0  " Windows can be 0 line high
set laststatus=2    " Always show the statusline

" ========== Search ================
set ignorecase      " Case insensitive search
set smartcase       " Case sensitive when uppercase present

" ============ No Backup =========
set noswapfile
set nobackup

" =========== Persistent Undo =======
set undofile
set undolevels=1000

" ============== Indentation ===========
set autoindent
set smartindent
set shiftwidth=2    " Use indents of 2 spaces
set expandtab       " Tabs are spaces, not tabs
set tabstop=2       " An indentation every 2 columns
set softtabstop=2   " Let backspace delete indent

" ======= Code Folding ======
"set foldenable      " Auto fold code
set foldmethod=indent
set foldlevel=999

" ========= Completion ========
set wildignorecase
set wildmode=list:longest,full
set wildignore=*.pyc

" ==============Navigation ==========
set backspace=indent,eol,start  " Backspace for dummies
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap to
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor

" ================ UI =================
set background=dark
colorscheme gruvbox 
set cursorline      " Highlight current line
set textwidth=80
set colorcolumn=+1
" ================ Shortcut ==============

" Change map leader to ","
let mapleader=","

" Quick edit and source vimrc
nmap <leader>v :e $MYVIMRC<CR>

augroup reload_vimrc
  autocmd!
  autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

set pastetoggle=<F12>   " Toggle paste mode

" Invoke sudo
cmap w!! %!sudo tee > /dev/null %

" Show whitespace, toggled with <leader>s
set listchars=tab:>-,trail:·,eol:¶
nmap <silent> <leader>s :set nolist!<CR>

" ================ Key Mapping ===============
imap jk <esc>
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
nmap <space> [unite]
nnoremap [unite] <nop>

nnoremap <silent> [unite]<space> :<C-u>Unite
  \ -buffer-name=files buffer file_mru bookmark file_rec/async<CR>

let g:unite_source_history_yank_enable=1
nnoremap <space>y :Unite history/yank<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

" =============== Speecific Language Settings ==========
" python
autocmd BufRead *.py nmap <F5> :!python "%"<CR>

" ==Systastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_javascript_checkers=['standard']
let g:syntastic_python_checkers=['prospector']

if executable('rg')
  let g:unite_source_grep_command='rg'
	let g:unite_source_grep_default_opts='--color=never --no-heading -n -S'
	let g:unite_source_grep_recursive_opt=''
	let g:unite_source_rec_async_command =
    \ ['rg', '--follow', '--hidden', '--files', '-g', '']
endif

" YouCompleteMe
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ]],
  \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'filename': 'LightLineFilename',
  \   'fileformat': 'LightLineFileformat',
  \   'filetype': 'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode': 'LightLineMode',
  \ },
  \ 'component_expand': {
  \   'syntastic': 'SyntasticStatuslineFlag',
  \ },
  \ 'component_type': {
  \   'syntastic': 'error',
  \ },
  \ 'subseparator': { 'left': '|', 'right': '|' }
  \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" augroup AutoSyntastic
"   autocmd!
"   autocmd BufWritePost *.c,*.cpp call s:syntastic()
" augroup END
" function! s:syntastic()
"   SyntasticCheck
"   call lightline#update()
" endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" source $VIMRUNTIME/delmenu.vim
"
let g:deoplete#enable_at_startup = 1
