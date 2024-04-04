" general
set termguicolors      " enable truecolor
syntax enable          " enable syntax hightligting
set nowrap             " disable word wrapping long lines
set iskeyword+=-       " treat dash separated words as a single word

" tabs
set tabstop=2	         " set tab width to 2
set shiftwidth=2       " set tab width to 2
set smarttab           " smarter tabbing
set expandtab          " convert tabs to spaces
set autoindent         " auto indent
set smartindent        " smart auto indenting

" status, tab line, gutter
set laststatus=2       " always show the status line
set showtabline=2      " always show the tab line
set noshowmode         " hide mode, it's on the status line
set cursorline         " highlight the current line
set number             " show line numbers
set relativenumber     " show relative line numbers
set colorcolumn=81     " highlight column 81 to show long lines
set updatetime=100     " faster updates for gutter

" toggle relative line numbers off in INSERT mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" search
set hlsearch           " highlight all search results
set incsearch          " incremental search while typing query
set ignorecase         " ignore case while searching
set smartcase          " override ignorecase if upper case character is used

" clipboard
set clipboard=unnamed  " y and p interact with primary

" disable comments continuing to next line
autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro

" spelling and completion
set spell spelllang=en_us " enable spell check
set complete+=kspell      " enable auto-completion with ctrl+p / ctrl+s
set spellcapcheck=        " ignore lowercase at sentence start

" filetype customization
autocmd BufNewFile,BufRead *.eyaml set syntax=yaml
