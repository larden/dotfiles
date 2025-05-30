" Vim configuration
"
" =============================================================================
" Vim-plug setup
" =============================================================================
call plug#begin()
Plug 'chriskempson/base16-vim'
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " show better tree
Plug 'christoomey/vim-tmux-navigator' " improve navigation in vim and tmux
"Plug 'vim-scripts/cscope.vim'
" TODO
" Plug 'ronakg/quickr-cscope.vim'  << better version of vim-scripts/cscope.vim
"if !has('nvim')
"Plug 'Valloric/YouCompleteMe'
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
"else
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"endif
Plug 'junegunn/fzf.vim'
if has('nvim') || has('patch-8.0.902') "show differences with style
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'ggml-org/llama.vim'
call plug#end()

set nocompatible
set ttyfast

" =============================================================================
" External configuration
" =============================================================================

" enable modeline in files
set modeline
" allow local .vimrc files but use only safe options
set exrc
set secure

" =============================================================================
" Colorscheme
" =============================================================================
"set t_Co=256
"set background=dark
if exists('$BASE16_THEME')
			\ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
	let base16colorspace=256  " Access colors present in 256 colorspace
	colorscheme base16-$BASE16_THEME
endif

syntax on
" highlight matching brackets
set showmatch


" =============================================================================
" Leader
" =============================================================================
let mapleader=","

" =============================================================================
" Interface
" =============================================================================

set cursorline
set number
set wildmenu
set relativenumber
set shortmess=atI
set laststatus=2

" leader r to toggle relative line numbers
nmap <leader>r :set rnu!<CR>

set splitright

" =============================================================================
" Indentation
" =============================================================================

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

filetype plugin indent on

" =============================================================================
" Invisible characters
" =============================================================================

nmap <leader>li :set list!<CR>
set listchars=tab:▸\ ,eol:¬

function! Preserve(command)

	" Save last search and cursor position
	let _s=@/
	let l = line(".")
	let c = col(".")

	execute a:command

	" Restore search history and cursor position
	let @/=_s
	call cursor(l, c)

endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" =============================================================================
" Buffers
" =============================================================================

" Auto hide buffers without raising error
set hidden

" =============================================================================
" Navigation mappings
" =============================================================================

" better window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" better scrolling within wrapped lines
nnoremap j gj
nnoremap k gk

" leader r to toggle relative line numbers
nmap <leader>r :set rnu!<CR>

"set pastetoggle=<F11>

" =============================================================================
" Search
" =============================================================================

set hlsearch
nnoremap <leader><space> :noh<cr>

set incsearch
set smartcase

" use g flag by default
set gdefault
" very magic regular expressions
nnoremap / /\v
vnoremap / /\v

" =============================================================================
" Scrolling
" =============================================================================

set scrolloff=10

" =============================================================================
" Cscope
" =============================================================================

nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>

" open in vertical split
nnoremap <leader>vs :vert scs find s <C-R>=expand("<cword>")<CR><CR>:cw<CR><CR>
nnoremap <leader>vg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>vd :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>vc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>vt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>ve :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>vf :vert scs find f <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>vi :vert scs find i <C-R>=expand("<cword>")<CR><CR>

" =============================================================================
" Plugins configuration
" =============================================================================

"" YouCompleteMe
"let g:ycm_complete_in_comments = 1
"let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_always_populate_location_list = 1

" Set path for python3
"let g:ycm_server_python_interpreter = "/usr/bin/python3"

" YCM - don't ask to load config
"let g:ycm_confirm_extra_conf = 0

" YCM - autoclouse scratch window
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1

" Airline configuration
"let g:airline_theme='base16_classic'
"let g:airline_powerline_fonts = 1

" Signify
set updatetime=100

"" llama.vim
" put before llama.vim loads
"let g:llama_config = { 'show_info': 0 }

