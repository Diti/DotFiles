set autowrite
set cursorline
set mouse=v
set number
set relativenumber
set t_Co=256

set tabstop=4 shiftwidth=4 expandtab

if !exists(':Stdheader')
    let stdheader42_file = '/usr/share/vim/vim80/plugin/stdheader.vim'
    if filereadable(stdheader42_file)
        execute 'source ' . fnameescape(stdheader42_file)
    endif
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

" Highlighted searches reset
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" NERDTree explorer
nnoremap <silent> <C-n> :NERDTreeFocus<CR>

" Tagbar (use C-w w to change windows)
nnoremap <silent> <C-]> :Tagbar<CR>

autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)

" ┌────────────┐
" │  VimPlugs  │
" └────────────┘
let vimplug_file = has('nvim') ? '~/.config/nvim/autoload/plug.vim' : '~/.vim/autoload/plug.vim'
let vimplugged_dir = has('nvim') ? '~/.config/nvim/plugged' : '~/.vim/plugged'

if !filereadable(expand(vimplug_file))
    silent execute '!curl -fLo ' . vimplug_file . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall
endif

call plug#begin(vimplugged_dir)
Plug 'Bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'lilydjwg/colorizer'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/wombat256.vim'
Plug 'w0rp/ale'
if executable('go') | Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } | endif
if executable('gpg') || executable ('gpg2') | Plug 'jamessan/vim-gnupg' | endif
if executable('latex') | Plug 'lervag/vimtex', { 'for': 'tex' } | endif
if has('nvim') && executable('clang') | Plug 'arakashic/chromatica.nvim' | endif
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
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

if has('nvim') && executable('clang')
    let g:chromatica#enable_at_startup=1
    let g:chromatica#libclang_path=system('printf "%s" $(mdfind libclang.dylib | head -n 1)')
endif

let g:colorizer_auto_filetype='css,html'

let g:deoplete#enable_at_startup = 1

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
    if has('nvim')
        set background=dark
        set termguicolors
        colorscheme gruvbox
    else
        colorscheme wombat256mod
    endif
catch
    colorscheme desert
endtry

" ┌────────────────────┐
" │  vimrc autoreload  │
" └────────────────────┘
augroup autoReloadConfig
    autocmd Filetype vim autocmd! BufWritePost <buffer> source $MYVIMRC
augroup END
