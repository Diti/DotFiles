set cursorline
set mouse=v
set t_Co=256

"http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"

"Type <Space>w to save file:
nnoremap <Leader>w :w<CR>
"Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V

" """"""""""""" "
"               "
"    VimPlug    "
"               "
" """"""""""""" "
if !filereadable(expand("~/.vim/autoload/plug.vim"))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
  Plug 'chrisbra/Colorizer'            " Color hex codes and color names.
  Plug 'editorconfig/editorconfig-vim'
 "Plug 'Bling/vim-airline'             " Status/tabline for vim that's light as air.
  Plug 'airblade/vim-gitgutter'        " Shows a git diff in the gutter (sign column).
  Plug 'jamessan/vim-gnupg'
  Plug 'tpope/vim-sensible'            " Defaults everyone can agree on.
  Plug 'wombat256.vim'                 " Wombat theme for 256-color terms
call plug#end()

" """""""""""""""""""" "
"                      "
"    Plugin configs    "
"                      "
" """""""""""""""""""" "
let g:GPGPreferSign=1
let g:GPGDefaultRecipients=0xFD4F1D56645219A0C6F6F9AB31A49121CD42FF00


try
  colorscheme wombat256mod
catch
  colorscheme desert
endtry
