" Ideas from:
" Source: https://github.com/bhilburn/dotfiles/blob/master/vim/
" And from Steve Losh's spectacular vimrc.
" Source: http://bitbucket.org/sjl/dotfiles/src/tip/vim/
" And from ashwin:
" https://github.com/ashwin/dot_files/blob/master/vim/.vimrc
" And from amix:
" https://github.com/amix/vimrc/

" Ignore compatibility issues with Vi. Really don't know why ViM still defaults
" to this. Especially gViM.
set nocompatible

" To enable Pathogen, we have to first disable the filetype, load the bundles,
" and then re-enable.
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

" General Options
set encoding=utf-8                                  " Handle Unicode files
set autoindent                                      " Turn on auto indenting
set showmode                                        "
set showcmd                                         " Display commands as they are typed
set hidden                                          " Allow opening new buffer when current one is unsaved
set visualbell                                      " Flash display instead of beeping
set ttyfast                                         " Draw screen quickly
set ruler                                           " Always show cursor position
set backspace=indent,eol,start                      " Backspace over anything in insert mode
set number                                          " Display line numbers
set relativenumber                                  " Use relative line numbers
set laststatus=2                                    " Always show status line
set history=1000                                    " Number of old commands to remember
set list                                            "
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮  " Characters for whitespace
set shell=/bin/bash\ --login                        "
set matchtime=3                                     "
let &showbreak = '↪ '                               " Character used to trunk lines
set splitbelow                                      "
set splitright                                      "
set fillchars=diff:⣿,vert:│                         " Characters for filling
set autowrite                                       "
set autoread                                        " Automatically reload file if its changed
set shiftround                                      "
set title                                           " Vim sets window title
set linebreak                                       " When line is wrapped, break at word boundary
"set spellfile=~/.vim/custom-dictionary.utf-8.add
set colorcolumn=+1                                  "
set modelines=5                                     "

" Disabling this because vim-airline doesn't like it
set lazyredraw

" Set options regarding the undo history and undo tree depth
set undofile
set undoreload=10000
set undolevels=512

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Resize splits when the window is resized
"au VimResized * :wincmd =

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Only shown trailing spaces when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars+=eol:¬
    au InsertLeave * :set listchars-=eol:¬
augroup END


" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Spacing and tabbing
set expandtab                           " Use spaces instead of tabs
set smarttab                            " Be smart when using tabs ;)
set softtabstop=4                       " 1 tab == 4 spaces
set shiftwidth=4                        " 1 tab == 4 spaces
set wrap                                " Wrap lines
set textwidth=80
set formatoptions=qrn1

" Scrolling
set scrolloff=5                         " Keep the current working line in the center of the screen
set sidescroll=1                        " Smooth side scrolling
set sidescrolloff=5                     " Left-right offset during side-scrolling

" Searching
set smartcase                           " When searching try to be smart about cases
"set hlsearch                            " Highlight search results
set incsearch                           " Makes search act like search in modern browsers

" Moving around, tabs, windows and buffers
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Get those annoying temporary files out of the working directory
set backup                          " enable backups
set undodir=~/.vim/tmp/undo//       " undo files
set backupdir=~/.vim/tmp/backup//   " backups
set directory=~/.vim/tmp/swap//     " swap files
let g:yankring_history_dir='~/.vim/tmp/yankring'

"Hide relative line numbers when in insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Leader key remapping
let mapleader = ","
let maplocalleader = "\\"
map <leader><space> :noh<cr>

" <ESC> is really far away
imap <c-d> <ESC>
nnoremap <c-d> <ESC>
vnoremap <c-d> <ESC>
cnoremap <c-d> <ESC>

" Toggle line numbers
nnoremap <leader>n :setlocal number! relativenumber!<cr>

" Show contents of registers
nnoremap <leader>r :registers<cr>

" Ctags  Rebuild (mnemonic CR -> <cr>)
nnoremap <leader><cr> :silent !ctags -R --exclude=.git --exclude=build .<cr>:redraw!<cr>

" Delete trailspaces
nnoremap <leader>t :%s/\s\+$//e<cr>

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Rainbow {{{
let g:rainbow_active = 1
" }}}

" Solarized {{{
syntax enable
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
" }}}

" NERD Tree {{{
noremap  <F2> :NERDTreeToggle<cr>
inoremap <F2> <esc>:NERDTreeToggle<cr>

augroup ps_nerdtree
    au!

    au Filetype nerdtree setlocal nolist
    " au Filetype nerdtree nnoremap <buffer> K :q<cr>
augroup END

let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                    \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                    \ '.*\.o$', 'db.db', 'tags.bak', '.*\.pdf$', '.*\.mid$',
                    \ '.*\.midi$']

" Disables display of the 'Bookmarks' label and 'Press ? for help' text.
let NERDTreeDirArrows = 1
" Tells the NERD tree if/when it should change vim's current working directory.
let NERDTreeChDirMode = 2
"let NERDChristmasTree = 1
" Jump to the first child of the current nodes parent.
let NERDTreeMapJumpFirstChild = 'gK'
" }}}

" Tagbar {{{
inoremap <F7> :TagbarToggle<CR>
nnoremap <F7> :TagbarToggle<CR>
vnoremap <F7> :TagbarToggle<CR>
" }}}

" Limelight {{{
" https://zenbro.github.io/2015/06/09/meditating-on-code.html
nmap <silent> gl :Limelight!!<CR>
xmap gl <Plug>(Limelight)
let g:limelight_default_coefficient = 0.7
"let g:limelight_paragraph_span = 1
" }}}

" Quick-scope {{{{
" Map the leader key + q to toggle quick-scope's highlighting in normal/visual mode.
" Note that you must use nmap/vmap instead of their non-recursive versions (nnoremap/vnoremap).
"nmap <leader>q <plug>(QuickScopeToggle)
"vmap <leader>q <plug>(QuickScopeToggle)
" The performance of vim when quickscope is always on is crap; highlight
" characters only when we want to move.
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}}
