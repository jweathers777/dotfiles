" John's Personal GVIM settings
" Maintainer: John Weathers <johnweathers@gmail.com>

" Make command line one lines high
set ch=1
set antialias

" I like to be able to open/close folds with my mouse
set foldcolumn=2

set guioptions-=T

set lines=45
set columns=88

" Hide the mouse when typing text
set mousehide

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Set the gui font
if has("gui_gtk2")
   set guifont=Nimbus\ Mono\ L\ 10
elseif has("gui_macvim")
   set guifont=Inconsolata:h12
else
   set guifont=Lucida_Console:h9:cANSI
end

colors idleFingers
hi NonText guifg=#aa00ff

" Helper function to allow automatic resizing with NERDTree
function NERDTreeToggleWithSize()
   if !exists("g:NERDTreeIsOpen")
      let g:NERDTreeIsOpen = 1
      let &columns=&columns + g:NERDTreeWinSize
      NERDTreeToggle
   else
      unlet g:NERDTreeIsOpen
      NERDTreeToggle
      let &columns=&columns - g:NERDTreeWinSize
   end
endfunction

map <leader>d :call NERDTreeToggleWithSize()<cr>

" Double number of columns and then virtually split the window
map <leader>vs :let &columns=&columns+&columns<cr>:vsplit<cr>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

endif

" Set window size
if &diff
   set lines=60
   set columns=176
else
   set lines=52
   set columns=88
end

