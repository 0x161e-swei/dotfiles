set nocompatible              " be iMproved, required
filetype off                  " required
set nu

set encoding=utf-8

call plug#begin('~/.vim/plugged')

" Syntax Highlighting "
au BufRead,BufNew *.md setf markdown
au BufRead,BUfNew *.tex setf tex

" =============================================================================
" airline theme
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
" =============================================================================
" LeaderF
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" =============================================================================
" fiel search plugin
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
set rtp+=~/.linuxbrew/opt/fzf
nnoremap ff :Files<CR>
nnoremap fff :Files 
" =============================================================================
" Completion plugins
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe'
" =============================================================================
" Go Syntax Highlighting "
Plug 'fatih/vim-go', { 'tag': '*' }
" =============================================================================
" gutentags
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'

let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

"For using Taglist for easy function finding" " let Tlist_Ctags_Cmd = '~/.linuxbrew/bin/ctags'
" let Tlist_WinWidth = 35
" nnoremap tt :TlistToggle<CR><C-w>w
" =============================================================================
" AsyncRun
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', 'build.xml']
nnoremap make :AsyncRun -cwd=<root> make<CR>
" =============================================================================
" Spacing
set expandtab " always uses spaces instead of tab characters
au Filetype python setl et ts=4 sw=4
au Filetype cpp setl et ts=4 sw=4 sts=0 smarttab
au Filetype c setl et ts=4 sw=4 sts=0 smarttab
au Filetype sh setl et ts=4 sw=4 sts=0 smarttab
"" au FileType coffee setl ts=4 sw=4
" =============================================================================
" For a better status line "
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set laststatus=2


" Quick swapping between windows "
nnoremap ww <C-w>w

" Open quickfix window
nnoremap qf :copen<CR>

" =============================================================================
" Turn on/off spell check "
setlocal spell spelllang=en_us
nnoremap ss :set spell<CR>
nnoremap sss :set nospell<CR>
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
hi CursorLine ctermbg=8 ctermfg=15 "8 = dark gray, 15 = white

" inoremap jj <Esc>

"folding code"
set foldmethod=syntax
set foldnestmax=10
set foldlevel=2


"Clang path"
" let g:clang_library_path='~/.vim/plugin/clang/'

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
" let g:syntastic_c_config_file = '.clang_complete'
" let g:syntastic_cpp_config_file = '.clang_complete'

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" SuperTab option for context aware completion
"set ofu=syntaxcomplete#Complete"
" let g:SuperTabContextDefaultCompletionType='<c-p>'
let g:SuperTabDefaultCompletionType='<C-n>'
let g:SuperTabNoCompleteAfter = ['^', ',', '\s', '\', '\n']

" UltiSnipsExpandTrigger key bindings
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" SuperTab option for context aware completion
"let g:SuperTabDefaultCompletionType="context" 
"set ofu=syntaxcomplete#Complete"
"let g:SuperTabContextDefaultCompletionType='<c-p>'"
"let g:SuperTabNoCompleteAfter = ['^', ',', '\s', '\', '\n']"


" All of your Plugins must be added before the following line
call plug#end()             " required

" filetype plugin indent on    " required
" syntax on

au Filetype tex syntax spell toplevel
