filetype off                  " required
set nu

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set encoding=utf-8

call plug#begin('~/.vim/plugged')

" Syntax Highlighting "
au BufRead,BufNew *.md setf markdown
au BufRead,BUfNew *.tex setf tex
au BufRead,BUfNew *.org setf tex
au BufRead,BUfNew *.isa setf python

" =============================================================================
" Dracula color
Plug 'dracula/vim', { 'as': 'dracula' }
" =============================================================================
" airline theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1
" =============================================================================
" LeaderF
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_RootMarkers = ['.root', '.svn', '.git', '.hg', '.project']
let g:Lf_WindowHeight = 0.20
let g:Lf_StlColorscheme = 'powerline'
nnoremap fa  :LeaderfFunctionAll<CR>
" =============================================================================

Plug 'sheerun/vim-polyglot'
" Markdown Syntax Highlighting
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
nnoremap <C-m> :MarkdownPreview<CR>

" Completion plugins
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe', {'do': 'python3 ./install.py --clang-completer', 'for': 'cpp,c' }

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" SuperTab option for context aware completion
" set ofu=syntaxcomplete#Complete"
" let g:SuperTabContextDefaultCompletionType='<c-p>'
let g:SuperTabDefaultCompletionType='<C-n>'
let g:SuperTabNoCompleteAfter = ['^', ',', '\s', '\', '\n']

" UltiSnipsExpandTrigger key bindings
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" SuperTab option for context aware completion
"let g:SuperTabDefaultCompletionType="context"
"set ofu=syntaxcomplete#Complete"
"let g:SuperTabContextDefaultCompletionType='<c-p>'"
"let g:SuperTabNoCompleteAfter = ['^', ',', '\s', '\', '\n']"

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,sh': ['re!\w{4}'],
           \ 'lua,javascript': ['re!\w{2}'],
           \ 'tex': ['re!\w{2}'],
           \ }

" =============================================================================
" Go Syntax Highlighting "
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }

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

"For using Taglist for easy function finding"
" let Tlist_Ctags_Cmd = '~/.linuxbrew/bin/ctags'
" let Tlist_WinWidth = 35
" nnoremap tt :TlistToggle<CR><C-w>w

" =============================================================================
" AsyncRun
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_mode = 0
let g:asyncrun_open = 10
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', 'build.xml']
nnoremap make :AsyncRun -cwd=<root> make<CR>
" Open quickfix window
nnoremap qf :call asyncrun#quickfix_toggle(10)<CR>

" =============================================================================
" file search plugin
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'Enter': 'vsplit',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
set rtp+=~/.linuxbrew/opt/fzf
function! s:_get_root()
        let l:root = asyncrun#get_root('%')
        return l:root
endfunction
command! Roottest execute s:_get_root()
command! ProjectFiles execute 'GFiles' s:_get_root()
nnoremap ff :ProjectFiles<CR>
nnoremap fff :Files<CR>

" =============================================================================
" FlyGrep
" Plug 'wsdjeg/FlyGrep.vim'
Plug '0x161e-swei/FlyGrep.vim'
command! -nargs=1 FGrep call FlyGrep#open({
                        \ 'dir': s:_get_root(),
                        \ 'input': <f-args>})

" Grep for current word
nnoremap gr :FGrep <C-r><C-w><CR>

" Grep for current selection
vnoremap gr vgvy :FGrep <c-r>"<CR>
" let g:FlyGrep_search_tools = ['ag', 'rg', 'grep', 'pt', 'ack']

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


" All of your Plugins must be added before the following line
call plug#end()             " required

" =============================================================================
" #############################################################################
" =============================================================================


colorscheme dracula

" =============================================================================
" Edit
" =============================================================================
" Turn on/off spell check "
setlocal spell spelllang=en_us
nnoremap ss :setl spell! spell?<CR>
set nospell

"make backspace behave properly in insert mode
set backspace=indent,eol,start

" This defines a macro in register A that duplicates a line with increasing
" value in the number feild
let @A="Yp\<C-a>"
" This command executes the macro...use is as Ndi, where N is the number of
" lines to generate
nnoremap di @A

" deletes the trailing whitespace
nnoremap dt :%s/\s\+$//e<CR>
nnoremap fy gwip



" =============================================================================
" Spacing
" =============================================================================
set expandtab " always uses spaces instead of tab characters
au Filetype python setl et ts=4 sw=4
au Filetype cpp setl et ts=4 sw=4 sts=0 smarttab
au Filetype c setl et ts=4 sw=4 sts=0 smarttab
au Filetype markdown setl et ts=4 sw=4 sts=0 smarttab
au Filetype tex setl et ts=4 sw=4 sts=0 smarttab
au Filetype tex setl spell
au Filetype sh setl et ts=4 sw=4 sts=0 smarttab


" =============================================================================
" Navigation
" =============================================================================
" Keep the cursor near the center "
set scrolloff=15
" Quick swapping between windows "
nnoremap ww <C-w>w
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wh <C-w>h
nnoremap wl <C-w>l

" Preview definition
nnoremap gd <C-w>}
" Close Preview window
nnoremap cp <C-w>z
" Go to definition
nnoremap gt <C-w>v<C-]>
inoremap jj <Esc>

"incremental search
set incsearch
"highlight search
set hlsearch
"searches are case insensitive unless they contain at least one capital letter
" set ignorecase
set smartcase



" =============================================================================
" Viewing
" =============================================================================
"
"more characters will be sent to the screen for redrawing
set ttyfast
"time waited for key press(es) to complete. It makes for a faster key response
set ttimeout
set ttimeoutlen=50
"display incomplete commands
set showcmd
"a better menu in command mode
set wildmenu
set wildmode=longest:full,full
"hide buffers instead of closing them even if they contain unwritten changes
set hidden
"disable soft wrap for lines
set nowrap

"folding code"
set foldmethod=syntax
set foldnestmax=10
set foldlevel=2

"display line numbers on the left side
set number
"highlight current line
set cursorline
"display text width column
set colorcolumn=81

hi ColorColumn ctermbg=8
set cursorline
hi CursorLine ctermbg=239
set cursorcolumn
hi CursorColumn ctermbg=239

"always display the status line
set laststatus=2

if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

filetype plugin indent on    " required
syntax on

