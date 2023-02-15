if has('python3')
endif

packadd! dracula
syntax enable
colorscheme dracula

set guifont=Consolas:h15

set ruler
set colorcolumn=80
set cursorline
highlight ColorColumn ctermbg=0 guibg=lightgrey
set hlsearch
set showmatch
set nu

set mouse=a

set encoding=utf-8

set shiftwidth=4
set tabstop=4

autocmd StdinReadPre * let s:std_in=1

augroup NERD
    au!
    autocmd VimEnter * NERDTree
    autocmd VimEnter * wincmd p
augroup end
"let NERDTreeShowHidden=1

"let R_path = 'c:\rtools40\mingw64\bin;C:\rtools40\usr\bin;c:\Program Files\R\R-4.2.2\bin\x64'
"let R_app = 'Rgui.exe'
"let R_cmd = 'Rgui.exe'

" Enable folding
set foldlevel=99
set foldmethod=manual
set foldcolumn=1 
"highlight FoldColumn guibg=white guifg=blue ctermbg=white ctermfg=blue
"highlight Folded guibg=... guifg=...

set backspace=indent,eol,start  " more powerful backspacing

" https://realpython.com/vim-and-python-a-match-made-in-heaven/
let python_highlight_all=1
syntax on

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

set clipboard=unnamed

" py-mode settings
let g:pymode = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_paths = []
let g:pymode_options = 1
let g:pymode_options_max_line_length = 79
let g:pymode_motion = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = '<leader>i'
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_rope = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_completion_bind = '<c-Space>'
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_goto_definition_bind = '<leader>g'
let g:pymode_rope_goto_definition_cmd = 'new'
let g:pymode_rope_rename_bind = '<leader>R'
let g:pymode_indent = 1
let g:pymode_indent_hanging_width = &shiftwidth
let g:pymode_indent_hanging_width = 4

let g:pymode_virtualenv = 1
let g:pymode_virtualenv_path = '/Users/cusworsj/miniconda3/envs/datascience' 

au BufNewFile,BufRead *.py
	\ set tabstop=4 | 
	\ set softtabstop=4 | 
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
	\ set foldmethod=indent

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 

