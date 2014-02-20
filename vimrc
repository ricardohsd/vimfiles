" pathogen
execute pathogen#infect()

" colors
syntax on

if has('gui_running')
  set guifont=Monaco:h14
  set background=light
else
  set background=dark
endif

colorscheme solarized

" style
set number
set autoindent
set cursorline
set ruler

set colorcolumn=80
autocmd FileType gitcommit setlocal colorcolumn=72

" whitespace
set list
set listchars=tab:\ \ ,trail:·

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Spell checking
"
" See: http://robots.thoughtbot.com/vim-spell-checking/
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.md setlocal complete+=kspell

" Display incomplete commands
set showcmd

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" This tip is an improved version of the example given for :help last-position-jump.
" It fixes a problem where the cursor position will not be restored if the file only has a single line.
"
" See: http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" NERDTree
map <Leader>n :NERDTreeToggle<CR>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Ruby
imap <c-l> <space>=><space>

" RSpec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

" Clear the search buffer when hitting return
nnoremap <cr> :nohlsearch<cr>

" load the plugin and indent settings for the detected filetype
filetype plugin indent on
