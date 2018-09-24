if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'w0rp/ale'
    Plug 'maralla/completor.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'mileszs/ack.vim'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" colors
syntax on

if has('gui_running')
  set guifont=Monaco:h18
  set background=light
else
  set background=light
endif

colorscheme solarized

set guioptions-=T " no toolbar set guioptions-=m " no menus
set guioptions-=r " no scrollbar on the right
set guioptions-=R " no scrollbar on the right
set guioptions-=l " no scrollbar on the left
set guioptions-=b " no scrollbar on the bottom
set guioptions=aiA
set cc=80
set fileformats=unix,dos,mac

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set showmode
set laststatus=2

let mapleader = "\\"

" allow navigate with hidden buffers
set hidden

" style
set number
set autoindent
set cursorline
set cursorcolumn

" whitespace
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap

set hlsearch                                                  " highlight search
set updatetime=100                                            " pretty much just so gocode will update quickly
set scrolloff=3                                               " Keep more context when scrolling off the end of a buffer

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" vim-go {
    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_function_arguments = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_echo_command_info=0                              " do not return SUCCESS/FAILURE in the status bar
    let g:go_auto_type_info=1                                 " automaticaly show identifier information when moving cursor
    let g:go_fmt_autosave=1
    augroup VimGo
        au!
        au FileType go nmap <leader>t  <Plug>(go-test)
        au FileType go nmap <leader>gt <Plug>(go-coverage-toggle)
        au FileType go nmap <leader>i <Plug>(go-info)
        au FileType go nmap <buffer> <leader>d :GoDecls<CR>
        au FileType go nmap <buffer> <leader>dr :GoDeclsDir<CR>
    augroup END
" }

" ALE {
    let g:ale_linters = {
    \	'go': ['go build', 'go vet', 'golint'],
    \	'python': ['flake8']
    \}
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign
    let g:ale_sign_error = '✖'
    let g:ale_sign_warning = '⚠'
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_linters_explicit = 1                            " Only run linters named in ale_linters settings.
" }

" NerdTree {
    map <Leader>p :NERDTreeToggle<CR>
" }

" Ack {
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
" }

" Key maps {
  " Mapping <tab> to chage tabs on commands mode
  nnoremap <Tab> gt
  " Moving lines
  nnoremap <C-j> :m .+1<CR>==
  nnoremap <C-k> :m .-2<CR>==
  inoremap <C-j> <Esc>:m .+1<CR>==gi
  inoremap <C-k> <Esc>:m .-2<CR>==gi
  vnoremap <C-j> :m '>+1<CR>gv=gv
  vnoremap <C-k> :m '<-2<CR>gv=gv
  " Clear the search buffer when hitting return
  nnoremap <cr> :nohlsearch<cr>
"}

" Clean unnecessary spaces
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

autocmd BufWritePre *.py,*.js,*.rb,*.erb,*.jbuilder,*.less,*.css :call <SID>StripTrailingWhitespaces()
