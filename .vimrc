"" vim-plug
call plug#begin('~/.vim/bundle')
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'skammer/vim-css-color'
call plug#end()

"" vim-gitgutter
set updatetime=100

"" solarized
syntax enable
set background=dark
colorscheme solarized

"" nerdtree
" auto open if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" toggle on ctrl+n
nnoremap <C-n> :NERDTreeToggle<CR>

"" vim-airline
set noshowmode
set timeout timeoutlen=10
let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled=1
let g:airline_skip_empty_sections=1
let g:airline_detect_spell=0
let g:airline_symbols={}
let g:airline_symbols.maxlinenr=''

"" general
" tab
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab

" line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" cursorline
set cursorline
:hi CursorLineNr cterm=bold

" spell check
set spell spelllang=en_us

" search
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <C-h> :nohlsearch<CR>

" syntax highlighting
" yaml syntax in eyaml
au BufReadPost *.eyaml set filetype=yaml
