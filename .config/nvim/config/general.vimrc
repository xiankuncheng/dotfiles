syntax on " Syntax highlighting in vim

" Explicitly set filetyle=javascript fo fix jsx syntax highlighting
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx

" Explicitly set filetype=typescript for .ts .tsx
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript

" render a column at 80 characters
set colorcolumn=80

" SKIN
syntax enable
set background=dark
set termguicolors

" Tabs to spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Relative Line numbers
set nu rnu

" Showmatch
set showmatch

" Ignore node_modules
set wildignore+=*/node_modules/*

" Yank to clipboard
set clipboard+=unnamed

" Font Size
set gfn=Menlo:h16

" Turn off that darn highlighting when searching
set nohlsearch

" Scrolling within iterm
set mouse=nicr

" Open new split panes to right
set splitright

filetype plugin indent on
