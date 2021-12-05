" John's Personal VIM settings
" Maintainer: John Weathers <johnweathers@gmail.com>

"Plug 'cespare/vim-toml'
"Plug 'elixir-lang/vim-elixir'
"Plug 'elmcast/elm-vim'
"Plug 'flazz/vim-colorschemes'
"Plug 'hcs42/vim-erlang'
"Plug 'honza/vim-snippets'
"Plug 'jiangmiao/auto-pairs'
"Plug 'junegunn/vim-easy-align'
"Plug 'kchmck/vim-coffee-script'
"Plug 'lervag/vimtex'
"Plug 'mustache/vim-mustache-handlebars'
"Plug 'sjl/gundo.vim'
"Plug 'tpope/vim-haml'
"Plug 'tpope/vim-rails'
"Plug 'vim-scripts/ZoomWin'

"We don't want the vi-compatible version
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show matching parentheses
set showmatch

" Make backspace key normal
set bs=2

" Highlight the current line
set cursorline

" We want to wrap long lines but we want
" to show them intelligently
set wrap
set cpoptions+=n
set linebreak
set showbreak=\ ↵\ \

" tab stop and shift width settings
set tabstop=3
set shiftwidth=3
set smarttab

" Don't litter the place with swap files
set directory=~/tmp,/var/tmp,/tmp

" Fine-tune the C/C++/Java indentation options
set cinoptions=:0,g0,(0,j1,p0,t0

" Turn off the annoying bell sounds
set vb t_vb=

set iskeyword+=-

" Eliminate pauses
set timeoutlen=1000 ttimeoutlen=0

" Force myself to use the right motion keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Toggle paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Expand tabs to spaces
set expandtab

set splitbelow
set splitright

set number
set history=50 "Keep 50 lines of command line history
set ruler      "Show the cursor position all the time
set showcmd    "Display incomplete commands

set ic         "Ignore the case in searches
set smartcase  "Override the ignore case for mixed patterns

" We don't want to clutter up things with backup files
set nobackup

" We want the xterm way of doing things instead of M$ Windows
behave xterm

" It's nice to be able to use the mouse in the Terminal
set mouse=a

" It's nice to be able to select with the mouse
set selectmode=mouse

" Which directory to use for the file browser
set browsedir=current

" Don't use Ex mode, use Q for formatting
map Q gq

" Easier than pressing ESC
inoremap jj <ESC>

let mapleader = ","

" Auto completion
set complete+=k

" Turn off folding
set nofoldenable

" XML Plugin settings
let xml_use_xhtml=1

" VIM-Slime settings
let g:slime_target="tmux"
let g:slime_paste_file = tempname()

let g:mustache_abbreviations = 1

"let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-x>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" Shortcut to rapidly toggel `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

map <leader>r :NERDTreeFind<CR>

" Search via ack on the current word
map <leader>* :Ag <cword><CR>

"Shortcut for searching with ack
map <leader>a :Ag ""<Left>

" NERD Tree
map <leader>d :NERDTreeToggle<cr>
let NERDTreeIgnore=['\~$','^target$','\.hi','\.o']
let NERDTreeDirArrows=1

" Map shortcut for ZoomWin
map <leader>z :ZoomWin<CR>

" Map shortcut for ConqueTerm
map <leader>e :ConqueTerm zsh<CR>
let g:ConqueTerm_SendVisKey='<F3>'

" Map shortcuts for ctags commands
map <leader>rt :!ctags --extra=+f -R *<CR><CR>
map <leader>g :Tlist<CR>

" Gundo
map <leader>u :GundoToggle<CR>

map <leader>lcd :lcd %:p:h<CR>

map <leader>cp :let @+ = expand("%:p")<cr>

" Mapping for edit/reloading vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  "let g:ackprg = 'ag --nocolor --nogroup --column --ignore=*min.js --ignore=*min.css --ignore=public'
  let g:ackprg = 'ag --nocolor --nogroup --column'
endif

set grepformat=%f:%l:%m

" Enable fzf
set rtp+=/usr/local/opt/fzf
map <leader>t :FZF<CR>
map <leader>b :Buffers<CR>
map <leader>a :Ag
map <leader>. :Tags<CR>

let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'

" Control settings for python highlighting
let python_highlight_all = 1
let python_slow_sync = 1

" Disable default key bindings for elm
let g:elm_setup_keybindings = 0

" Jedi configuration for python
let g:jedi#goto_command = "<leader>v"
let g:jedi#goto_assignments_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>m"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>w"

:inoremap <C-D> <Esc>:call setline(".",substitute(getline(line(".")),'^\s*',matchstr(getline(line(".")-1),'^\s*'),''))<CR>I

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
   syntax on
   set hlsearch
endif

if $TERM == 'screen'
   set t_Co=256
endif

if &t_Co >= 256
   set background=dark
   colors idlefingers256
else
   set background=dark
   colors default
endif

" Make windows use a sensible shell for vim
"set shell=powershell

" Only do this part when compiled with support for autocommands.
if has("autocmd")

   " Enable file type detection.
   " Use the default filetype settings, so that mail gets 'tw' set to 72,
   " 'cindent' is on in C files, etc.
   " Also load indent files, to automatically do language-dependent indenting.
   filetype plugin indent on

   " Put these in an autocmd group, so that we can delete them easily.
   augroup vimrcEx
      au!
      autocmd FileType c,cpp,java,php,haskell,ruby,yaml,javascript,coffee,coffescript,scala,rust autocmd BufWritePre <buffer> %s/\s\+$//e
      autocmd BufEnter Gemfile set filetype=ruby
      autocmd BufEnter .gitconfig_local set filetype=gitconfig
      autocmd FileType haskell set autoindent
      autocmd FileType haskell,ruby,yaml,jade,javascript,coffee,coffeescript,scala,html.handlebars setlocal ts=2 sw=2
      autocmd FileType java setlocal ts=2 sw=2 tw=100
      autocmd FileType xml,xhtml,html,htm,html.handlebars setlocal autoindent
      autocmd FileType xml,xhtml,html,htm,html.handlebars let b:delimitMate_matchpairs="(:),{:},[:]"
      autocmd FileType tex set spelllang=en_us spell
      autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
      au BufRead,BufNewFile SCons* set filetype=python
      au BufRead,BufNewFile *.hamlc set filetype=haml
      autocmd BufWritePre *.py :%s/\s\+$//e

      au FileType lisp let b:delimitMate_quotes="\""

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      autocmd BufReadPost *
               \ if line("'\"") > 0 && line("'\"") <= line("$") |
               \   exe "normal g`\"" |
               \ endif

      autocmd VimEnter * if exists('Windows') | delc Windows | endif

      au FilterWritePre * if &diff | set background=light | colorscheme peaksea | endif
   augroup END
else

   set autoindent " always set autoindenting on

endif " has("autocmd")
