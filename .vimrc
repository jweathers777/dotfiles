" John's Personal VIM settings
" Maintainer: John Weathers <jweathers@gmail.com>

" Activate pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"We don't want the vi-compatible version
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show matching parentheses
set showmatch

" Make backspace key normal
set bs=2

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

" Fine-tune the C/C++/Java indentation options
set cinoptions=:0,g0,(0,j1,p0,t0

" Turn off the annoying bell sounds
set vb t_vb=

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

let mapleader = ","

" Use ack instead of grep
set grepprg=ack
set grepformat=%f:%l:%m

" Auto completion
set complete+=k

" Turn off folding
set nofoldenable

" XML Plugin settings
let xml_use_xhtml=1

let g:slimv_impl='clisp'
let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"clisp ~/.vim/bundles/slimv/slime/start-swank.lisp\""'

" Shortcut to rapidly toggel `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Settings for haskell
let g:ghc="/usr/local/bin/ghc"
let g:haddock_browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

" FuzzyFinder settings
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|log|swp)$|(^|[/\\])(\.(hg|git|bzr)|target)($|[/\\])'
let g:fuf_dir_exclude = '\v(^|[/\\])(\.(hg|git|bzr)|target)($|[/\\])'

"map <leader>t :FufFile<CR>
map <leader>b :FufBuffer<CR>
"map <leader>g :FufTag<CR>
map <leader>r :NERDTreeFind<CR>

" Search via ack on the current word
map <leader>* :Ack <cword><CR>

"Shortcut for searching with ack
map <leader>a :Ack ""<Left>

" NERD Tree
map <leader>d :NERDTreeToggle<cr>
let NERDTreeIgnore=['\~$','^target$','\.hi','\.o']
let NERDTreeDirArrows=1

" Map shortcut for ZoomWin
map <leader>z :ZoomWin<CR>

" Map shortcut for ConqueTerm
map <leader>e :ConqueTerm zsh<CR>

" Map shortcuts for ctags commands
map <leader>rt :!ctags --extra=+f -R *<CR><CR>
map <leader>g :Tlist<CR>

" Gundo
map <leader>u :GundoToggle<CR>

map <leader>lcd :lcd %:p:h<CR>

map <leader>cp :let @+ = expand("%:p")<cr>

" Control settings for python highlighting
let python_highlight_all = 1
let python_slow_sync = 1

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
   if &diff
      set background=light
      colors peaksea
   else
      set background=dark
      colors idlefingers256
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

      autocmd BufEnter Gemfile set filetype=ruby
      autocmd FileType ruby setlocal ts=2 sw=2
      autocmd FileType yaml setlocal ts=2 sw=2
      autocmd FileType java setlocal ts=4 sw=4 tw=80
      autocmd FileType xml,xhtml,html,htm setlocal autoindent
      autocmd FileType xml,xhtml,html,htm let b:delimitMate_matchpairs="(:),{:},[:]"
      au BufNewFile,BufRead SCons* set filetype=python

      au FileType lisp let b:delimitMate_quotes="\""

      "au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
      "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      autocmd BufReadPost *
               \ if line("'\"") > 0 && line("'\"") <= line("$") |
               \   exe "normal g`\"" |
               \ endif

   augroup END

else

   set autoindent " always set autoindenting on

endif " has("autocmd")

set diffopt=filler,context:17,iwhite
set diffexpr=MyDiff()
function MyDiff()
   let opt = ''
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   silent execute '!diff -a ' . opt . '"' . v:fname_in . '" "' . v:fname_new . '" > "' . v:fname_out . '"'
endfunction

