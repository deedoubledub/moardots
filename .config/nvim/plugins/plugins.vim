"auto install vim_plug and any missing plugins
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugged')
  " theme
  Plug 'arcticicestudio/nord-vim'
  Plug 'vim-airline/vim-airline'
  " git
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  " filesystem
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-eunuch'
  " colors
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'junegunn/rainbow_parentheses.vim'
  " text helpers
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-endwise'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-commentary'
  Plug 'alvan/vim-closetag'
  " motion helpers
  Plug 'justinmk/vim-sneak'
  Plug 'unblevable/quick-scope'
  " syntax
  Plug 'sheerun/vim-polyglot'
call plug#end()

"auto install missing plugins on startup
autocmd VimEnter *
  \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | q
  \| endif
