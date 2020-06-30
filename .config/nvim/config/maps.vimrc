" =========== General ===========
let mapleader=" " " Map <space> to leader
imap jk <Esc>
inoremap <leader>; <C-o>A;
nmap <silent> <leader>ev :vsplit ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>sv :source ~/.config/nvim/init.vim<CR>
map <D> <C> " Map mac Command key to Ctrl

" Useful for moving between long wrapped lines.
:nnoremap k gk
:nnoremap j gj

:nnoremap <leader><C-b> :ls<CR>:buffer<Space>

" =========== Navigation ===========
" Easymvtion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <leader><leader>L <Plug>(easymotion-bd-jk)
map <leader><leader>L <Plug>(easymotion-overwin-line)
nmap <leader><leader>w <Plug>(easymotion-bd-w)
nmap <leader><leader>w <Plug>(easymotion-overwin-w)

" General Navigation
" Switch to  next / previous tab
noremap <C-k> :bnext<CR>
noremap <C-j> :bprevious<CR>

" Switch to specific tab numbers with Command-number
noremap gt1 :tabn 1<CR>
noremap gt2 :tabn 2<CR>
noremap gt3 :tabn 3<CR>
noremap gt4 :tabn 4<CR>
noremap gt5 :tabn 5<CR>
noremap gt6 :tabn 6<CR>
noremap gt7 :tabn 7<CR>
noremap gt8 :tabn 8<CR>
noremap gt9 :tabn 9<CR>
" Command-0 goes to the last tab
noremap gt0 :tablast<CR>

" Switch between buffers
nmap <leader><TAB> :b#<CR>

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" =========== UltiSnips ===========
" Trigger key
let g:UltiSnipsExpandTrigger="<C-l>"

" =========== Format JSON ===========
" Format JSON with jq 
map <leader>fj :%!jq '.'<CR>

" =========== VimWiki ===========
" CMD + D to insert date
nmap <D-d> i<C-R>=strftime("*%I:%M%p %A %d %B %Y*")<CR><Esc> 
imap <D-d> <C-R>=strftime("*%I:%M%p %A %d %B %Y*")<CR>

" =========== LEADER ===========
" W - Window
map <leader>wv :vsplit<CR>
map <leader>wb :split<CR>
map <leader>wd :q<CR>
map <leader>wD :q!<CR>
" Window manipulation
map <leader>wh <C-w>h
map <leader>wj <C-w>j
map <leader>wk <C-w>k
map <leader>wl <C-w>l

" P - Project
"map <C-p> :NERDTreeClose<CR>:GFile<CR>
map <C-p> :GFile<CR>

" F - File
map <leader>fs :w<CR> "File save
map <leader>ft <C-n>  "File tree
nmap <leader>tr :NERDTreeFind<CR>

" S - Search
map <leader><C-p> :NERDTreeClose<CR>:Ag<CR>
map <leader>ss /

" =========== COC ==========
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands
"nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>cg :CocConfig<CR>
" Find symbol of current document
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>
" =========== END COC ==========

" Open Terminal in Vim
function! OpenTerminal()
  " move to right most buffer
  execute "normal 5\<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    " open terminal
    execute "vsp term://zsh"

    " turn off numbers
    execute "setlocal nonu"
    execute "setlocal nornu"
    execute "setlocal noshowmode"
    execute "setlocal noruler"
    " execute "setlocal laststatus=0"
    execute "setlocal noshowcmd"

    " toggle insert on enter/exit
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"

    startinsert!
  endif
endfunction
nnoremap <C-t> :call OpenTerminal()<CR>
