" John's Personal VIM settings
" Maintainer: John Weathers <jweathers@gmail.com>

" vim plugins
call plug#begin('~/.vim/plugged')
Plug 'cespare/vim-toml'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elixir-lang/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'garbas/vim-snipmate'
Plug 'hcs42/vim-erlang'
Plug 'honza/vim-snippets'
Plug 'honza/vim-snippets'
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'itchyny/vim-haskell-indent'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kchmck/vim-coffee-script'
Plug 'lervag/vimtex'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ZoomWin'
call plug#end()

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

" Use space to clear last search highlighting
nnoremap <space> :noh<return><esc>

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

" Toggle paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Expand tabs to spaces
set expandtab

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

" Shortcut to rapidly toggel `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Settings for haskell
let g:ghc="/usr/local/bin/ghc"
let g:haddock_browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

map <leader>r :NERDTreeFind<CR>

" NERD Tree
map <leader>d :NERDTreeToggle<cr>
"let NERDTreeIgnore=['\~$','^target$','\.hi','\.o']
let NERDTreeDirArrow=['\.hs','\.pyc','\.o']
let NERDTreeDirArrows=1

" NERD Commenter
command! -nargs=? -range=% Ct :normal <line1>ggv<line2>gg<Leader>c<space>

" Search and Replace
function SearchAndReplaceFunc(search, replace)
   execute '!for f in `ag -l ' . a:search . "`; do sed -e 's/" . a:search . "/" . a:replace . "/g' -i '' $f; done"
endfunction
command! -nargs=+ SearchAndReplaceCmd call SearchAndReplaceFunc(<f-args>)
map <leader>p :SearchAndReplaceCmd <C-R><C-W>

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
map <leader>* :Ag <C-R><C-W><CR>
map <leader>a :Ag <C-R>
map <leader>. :Tags<CR>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'

" Control settings for python highlighting
let python_highlight_all = 1
let python_slow_sync = 1

" Disable default key bindings for elm
let g:elm_setup_keybindings = 0

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
   syntax on
   set hlsearch
endif

if $TERM_PROGRAM =~ "iTerm"
   "set termguicolors
   set t_ut=
   if $COLOR_SCHEME =~ "LIGHT"
      set background=light
      colors pyte
   else
      set background=dark
      colors jellybeans
      let g:jellybeans_use_term_italics = 1
      "colors idlefingers256
      highlight Comment cterm=italic
   endif
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
      autocmd FileType haskell,ruby,yaml,jade,javascript,coffee,coffeescript,scala,html.handlebars setlocal ts=2 sw=2
      autocmd FileType java setlocal ts=2 sw=2 tw=100
      autocmd FileType xml,xhtml,html,htm,html.handlebars setlocal autoindent
      autocmd FileType xml,xhtml,html,htm,html.handlebars let b:delimitMate_matchpairs="(:),{:},[:]"
      autocmd FileType tex set spelllang=en_us spell
      autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
      au BufRead,BufNewFile SCons* set filetype=python
      au BufRead,BufNewFile *.hamlc set filetype=haml

      au FileType lisp let b:delimitMate_quotes="\""

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      autocmd BufReadPost *
               \ if line("'\"") > 0 && line("'\"") <= line("$") |
               \   exe "normal g`\"" |
               \ endif

      "au FilterWritePre * if &diff | set background=light | colorscheme peaksea | endif
   augroup END
else

   set autoindent " always set autoindenting on

endif " has("autocmd")
