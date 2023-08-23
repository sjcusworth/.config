call plug#begin()
Plug '~/.config/nvim/plugged/general/nerdtree'
Plug '~/.config/nvim/plugged/themes/dracula'

" Python
Plug '~/.config/nvim/plugged/python/ale'
Plug '~/.config/nvim/plugged/python/deoplete-jedi'
Plug '~/.config/nvim/plugged/python/nvim-dap'
Plug '~/.config/nvim/plugged/python/dap-ui'
Plug '~/.config/nvim/plugged/python/echodoc'
Plug '~/.config/nvim/plugged/python/deoplete'
Plug '~/.config/nvim/plugged/python/indent-blankline'

" Markdown
Plug '~/.config/nvim/plugged/markdown/knap'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'
Plug 'mzlogin/vim-markdown-toc'

call plug#end()


" filetype plugin on

" packadd! dracula
syntax enable
colorscheme dracula

set guifont=Consolas:h15

set ruler
set colorcolumn=80
set cursorline
highlight ColorColumn ctermbg=0 guibg=lightgrey
hi Normal ctermbg=none
set hlsearch
set showmatch

set mouse=a

set encoding=utf-8

set shiftwidth=4
set tabstop=4

autocmd StdinReadPre * let s:std_in=1

autocmd VimEnter * NERDTree

"let R_path = 'c:\rtools40\mingw64\bin;C:\rtools40\usr\bin;c:\Program Files\R\R-4.2.2\bin\x64'
"let R_app = 'Rgui.exe'
"let R_cmd = 'Rgui.exe'

" Enable folding
set foldlevel=99
set foldmethod=manual
set foldcolumn=1 

set backspace=indent,eol,start  " more powerful backspacing

" https://realpython.com/vim-and-python-a-match-made-in-heaven/
syntax on

set clipboard=unnamed

" Remove trailing white space
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre *.py :call TrimWhiteSpace()

autocmd FileType *.py source ~/.config/nvim/python.vim


let g:knap_settings = {
    \ "mdoutputext": "pdf", 
	\ "mdtopdf": "pandoc --pdf-engine=xelatex -L pandoc-zotxt.lua -C %docroot% -o %outputfile%",
	\ "mdtopdfviewerlaunch": "sioyek %outputfile%",
	\ "mdtopdfviewerrefresh": "none",
\ }
#–-csl /Users/cusworsj/.local/share/pandoc/vancouver.csl

""""""""""""""""""
" KNAP functions "
""""""""""""""""""
" F5 processes the document once, and refreshes the view "
inoremap <silent> <F5> <C-o>:lua require("knap").process_once()<CR>
vnoremap <silent> <F5> <C-c>:lua require("knap").process_once()<CR>
nnoremap <silent> <F5> :lua require("knap").process_once()<CR>

" F6 closes the viewer application, and allows settings to be reset "
inoremap <silent> <F6> <C-o>:lua require("knap").close_viewer()<CR>
vnoremap <silent> <F6> <C-c>:lua require("knap").close_viewer()<CR>
nnoremap <silent> <F6> :lua require("knap").close_viewer()<CR>

" F7 toggles the auto-processing on and off "
inoremap <silent> <F7> <C-o>:lua require("knap").toggle_autopreviewing()<CR>
vnoremap <silent> <F7> <C-c>:lua require("knap").toggle_autopreviewing()<CR>
nnoremap <silent> <F7> :lua require("knap").toggle_autopreviewing()<CR>

" F8 invokes a SyncTeX forward search, or similar, where appropriate "
inoremap <silent> <F8> <C-o>:lua require("knap").forward_jump()<CR>
vnoremap <silent> <F8> <C-c>:lua require("knap").forward_jump()<CR>
nnoremap <silent> <F8> :lua require("knap").forward_jump()<CR>


au BufNewFile,BufRead *.md
	\ set tabstop=4 | 
	\ set softtabstop=4 | 
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
	\ set foldmethod=indent |
	\ set nu



"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2 |
"    \ set softtabstop=2 |
"    \ set shiftwidth=2 | 
"    \ set nu

