set shortmess=atI " Quick start
set title
lang mes en_US.UTF-8
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
call plug#begin('~/.local/share/nvim/bundle')
"Plug 'Shougo/unite.vim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'justinmk/vim-dirvish'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" Plug 'mbbill/fencview'
Plug 'pangloss/vim-javascript'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
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

" ==Denite
" Change file_rec command.
call denite#custom#var('file_rec', 'command',
\ ['rg', '--files', '--glob', '!.git', ''])
" For Pt(the platinum searcher)
" NOTE: It also supports windows.
" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
    \ ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_symbols_ascii = 1
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
let g:startify_bookmarks = [{'p': '~/Projects'}]
" Disable when using multiple cursors
function g:Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
endfunction
function g:Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
endfunction
" Key mapping for deoplete
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
