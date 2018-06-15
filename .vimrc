set nocompatible              " be iMproved, required
filetype off                  " required
set nu

set encoding=utf-8
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Syntax Highlighting "
au BufRead,BufNew *.md setf markdown
au BufRead,BUfNew *.tex setf tex

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin 'vim-airline/vim-airline'
Plugin 'Valloric/YouCompleteMe'
" Bundle "MarcWeber/vim-addon-mw-utils"
" Bundle "tomtom/tlib_vim"
" Bundle "garbas/vim-snipmate"

" Go Syntax Highlighting "
Plugin 'fatih/vim-go'

" set runtimepath^=~/.vim/bundle/ctrlp.vim

" spaces for python
au Filetype python setl et ts=4 sw=4
au Filetype cpp setl et ts=4 sw=4 sts=0 smarttab
au Filetype c setl et ts=4 sw=4 sts=0 smarttab
" au FileType coffee setl ts=4 sw=4

" always uses spaces instead of tab characters
set expandtab

" For a better status line "
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set laststatus=2

" For easier window switching with alt + arrow keys "
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

"For using Taglist for easy function finding"
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 35
nnoremap tt :TlistToggle<CR><C-w>w

" Quick swapping between tabes "
nnoremap df :tabn<CR>
nnoremap fd :tabp<CR>

" Quick swapping between windows "
nnoremap ww <C-w>w

" Turn on/off spell check "
setlocal spell spelllang=en_us
nnoremap ss :set spell
nnoremap sss :set nospell
set nospell

" Keep the cursor near the center "
set scrolloff=15

" For fast paragraph formatting "
"nnoremap oo gqip"


"Colorscheme and line highlighting"
:colorscheme molokai 
"highlighting 80 char"
set colorcolumn=80

":set tw=85
set cursorline
hi CursorLine ctermbg=8 ctermfg=15 "8 = dark gray, 15 = white
set cursorcolumn
inoremap jj <Esc>
set tabstop=4
set shiftwidth=4
set softtabstop=4

"folding code"
set foldmethod=syntax
set foldnestmax=10
set foldlevel=2

"Clang path"
let g:clang_library_path='~/.vim/plugin/clang/'


" Add highlighting on functions and classes for C++
function! EnhanceCppSyntax()
	syn match    cCustomParen    "?=(" contains=cParen,cCppParen
	syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
	syn match    cCustomScope    "::"
	syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
	"hi def link cCustomFunc Function
	hi def link cCustomClass Function
endfunction
au Syntax cpp call EnhanceCppSyntax()

" Highlight local variables
let g:TagHighlightSettings={'IncludeLocals':'True'}
function CustomTagHighlight()
	hi LocalVariable guifg=#ff00ff
	hi GlobalVariable guifg=#ff00ff
endfunction
au Syntax c,cpp call CustomTagHighlight()

" Clang compilation options file for Syntastic (if needed)
let g:syntastic_c_config_file = '.clang_complete'
let g:syntastic_cpp_config_file = '.clang_complete'
let g:SuperTabContextDefaultCompletionType='<c-p>'

let g:airline_powerline_fonts = 1
" Complete only the current buffer and includes
"set complete=.,i

" Complete options (disable preview scratch window)
"set completeopt=menu,menuone ",longest

" SuperTab option for context aware completion
"let g:SuperTabDefaultCompletionType="context" 
"set ofu=syntaxcomplete#Complete"
"let g:SuperTabContextDefaultCompletionType='<c-p>'"
"let g:SuperTabNoCompleteAfter = ['^', ',', '\s', '\', '\n']"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
