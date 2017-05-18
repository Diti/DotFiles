set autowrite
set cursorline
set mouse=v
set t_Co=256

set tabstop=4 shiftwidth=4 expandtab

let stdheader42_file = '/usr/share/vim/vim73/plugin/stdheader.vim'
if filereadable(stdheader42_file)
    execute 'source ' . fnameescape(stdheader42_file)
endif

" ┌─────────────────────┐
" │  Keyboard bindings  │
" └─────────────────────┘
" Disable ex mode:
nnoremap Q <Nop>

nnoremap j gj
nnoremap k gk

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap <Space> <Nop>
let mapleader = ' '

" Type <Space>w to save file:
nnoremap <Leader>w :w<CR>
" Enter visual line mode with <Space><Space>:
nnoremap <Leader><Leader> V

" Type ˆN to toggle line numbers:
nnoremap <silent> <C-n> :setlocal number!<CR>

" Tagbar (use C-w w to change windows)
nnoremap <silent> <C-]> :Tagbar<CR>

autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)

" ┌────────────┐
" │  VimPlugs  │
" └────────────┘
if !filereadable(expand('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'joshglendenning/vim-caddyfile'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/wombat256.vim'
if executable('go') | Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } | endif
if executable('gpg') || executable ('gpg2') | Plug 'jamessan/vim-gnupg' | endif
if executable('latex') | Plug 'lervag/vimtex', { 'for': 'tex' } | endif
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

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

let g:go_fmt_command = "goimports"

let g:GPGPreferSign=1
let g:GPGDefaultRecipients=0x3A06DA6A0A7AB7B3795E8A7187F30257AE1E0000

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if exists(':Tagbar')
    let g:tagbar_compact = 1
"    autocmd VimEnter * nested :call tagbar#autoopen(1) " Open Tagbar in supported files
"    autocmd FileType * nested :call tagbar#autoopen(0) " Open a supported file when Vim running
else
    echohl WarningMsg
    echomsg 'Tagbar requires Exuberant Ctags'
    echohl None
endif

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
