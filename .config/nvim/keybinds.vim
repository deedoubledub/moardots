" use tab in normal mode to cycle buffers
nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>

" use shift + vim motion to navigate windows
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

" toggle NERDTree with ctrl + n
nnoremap <C-n> :NERDTreeToggle<CR>

" map ctrl+h to disable hlsearch
nnoremap <C-h> :nohlsearch<CR>
