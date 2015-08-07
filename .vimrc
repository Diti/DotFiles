if filereadable(expand("~/.vim/autoload/plug.vim"))
  call plug#begin('~/.vim/plugged')

  Plug 'morhetz/gruvbox'        " Retro groove color scheme for Vim.
  Plug 'Bling/vim-airline'      " Lean & mean status/tabline for vim that's light as air.
  Plug 'airblade/vim-gitgutter' " Shows a git diff in the gutter (sign column).
  Plug 'jamessan/vim-gnupg'
  Plug 'tpope/vim-sensible'     " Defaults everyone can agree on.
  Plug 'reedes/vim-wheel'       " Screen-anchored cursor movement for Vim.

  call plug#end()
endif

" """""""""""""""""""" "
"                      "
"    Plugin configs    "
"                      "
" """""""""""""""""""" "
let g:GPGPreferSign=1
let g:GPGDefaultRecipients=0xFD4F1D56645219A0C6F6F9AB31A49121CD42FF00

try
  colorscheme gruvbox
catch
  colorscheme default
endtry
