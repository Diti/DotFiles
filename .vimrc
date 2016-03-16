set cursorline
set mouse=v
set t_Co=256

set tabstop=4 shiftwidth=4 expandtab

" ┌─────────────────────┐
" │  Keyboard bindings  │
" └─────────────────────┘
" Disable ex mode:
nnoremap Q <Nop>

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap <Space> <Nop>
let mapleader = ' '

" Type <Space>w to save file:
nnoremap <Leader>w :w<CR>
" Enter visual line mode with <Space><Space>:
nnoremap <Leader><Leader> V

" Type ˆN to toggle line numbers:
nnoremap <silent> <C-n> :setlocal number!<CR>

" ┌────────────┐
" │  VimPlugs  │
" └────────────┘
if !filereadable(expand('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
Plug 'Bling/vim-airline'             " Status/tabline for vim that's light as air.
Plug 'chrisbra/Colorizer'            " Color hex codes and color names.
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'        " Shows a git diff in the gutter (sign column).
Plug 'jamessan/vim-gnupg'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'gabrielelana/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/syntastic'          " Syntax checking hacks for vim.
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-sensible'            " Defaults everyone can agree on.
Plug 'wombat256.vim'                 " Wombat theme for 256-color terms
call plug#end()

" ┌──────────────────┐
" │  Plugin configs  │
" └──────────────────┘
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'

let g:colorizer_auto_filetype='css,html'

let g:GPGPreferSign=1
let g:GPGDefaultRecipients=0x3A06DA6A0A7AB7B3795E8A7187F30257AE1E0000

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"

" ┌─────────────┐
" │  Vim theme  │
" └─────────────┘
try
    colorscheme wombat256mod
catch
    colorscheme desert
endtry
