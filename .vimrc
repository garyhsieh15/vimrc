
" --------------------------------------------------------------------
"
" Copyright 2018 Gary Hsieh vimrc configuration
"
" --------------------------------------------------------------------

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

" ******************** START Vundle Configuration ********************
set nocompatible                                 " no vi-compatible
filetype off                                     " required, Disable file type for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'gmarik/vundle'                           " required, let Vundle manage Vundle

" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
" Override configs by directory 
Plugin 'arielrossanigo/dir-configs-override.vim'
Plugin 'scrooloose/nerdtree'                     " Better file browser
Plugin 'scrooloose/nerdcommenter'                " Code commenter
Plugin 'majutsushi/tagbar'                       " Class/module browser
Plugin 'ctrlpvim/ctrlp.vim'                      " Code and files fuzzy finder
Plugin 'fisadev/vim-ctrlp-cmdpalette'            " Extension to ctrlp, for fuzzy command finder
Plugin 'mattn/emmet-vim'                         " Zen coding
Plugin 'motemen/git-vim'                         " Git integration
Plugin 'kien/tabman.vim'                         " Tab list panel
Plugin 'vim-airline/vim-airline'                 " Airline
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fisadev/fisa-vim-colorscheme'            " Terminal Vim with 256 colors colorscheme
Plugin 'rosenfeld/conque-term'                   " Consoles as buffers
Plugin 'fisadev/FixedTaskList.vim'               " Pending tasks list
Plugin 'tpope/vim-surround'                      " Surround
Plugin 'Townk/vim-autoclose'                     " Autoclose
Plugin 'michaeljsmith/vim-indent-object'         " Indent text object
Plugin 'jeetsukumaran/vim-indentwise'            " Indentation based movements
"Plugin 'davidhalter/jedi-vim'                    " Python autocompletion, go to definition.
Plugin 'Shougo/neocomplcache.vim'                " Better autocompletion
" Snippets manager (SnipMate), dependencies, and snippets repo
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'garbas/vim-snipmate'
" Git/mercurial/others diff icons on the side of the file lines
Plugin 'mhinz/vim-signify'
"Plugin 'fisadev/vim-isort'                      " Automatically sort python imports
Plugin 'fisadev/dragvisuals.vim'                " Drag visual blocks arround
Plugin 't9md/vim-choosewin'                     " Window chooser
Plugin 'scrooloose/syntastic'                   " Python and other languages code checker
Plugin 'lilydjwg/colorizer'                     " Paint css colors with the real color
" Ack code search (requires ack installed in the system)
Plugin 'mileszs/ack.vim'
if has('python')
    " YAPF formatter for Python
    Plugin 'pignacio/vim-yapf-format'
endif
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative 
" numbering every time you go to normal mode. Author refuses to add a setting 
" to avoid that)
" Plug 'myusuf3/numbers.vim'

" Plugins from vim-scripts repos:
Plugin 'vim-scripts/IndexedSearch'               " Search results counter
Plugin 'vim-scripts/matchit.zip'                 " XML/HTML tags navigation
Plugin 'vim-scripts/Wombat'                      " Gvim colorscheme
Plugin 'vim-scripts/YankRing.vim'                " Yank history navigation

call vundle#end()                                " required
filetype plugin indent on                        " required
" ******************* END Vundle Configuration ********************

""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Configuration Section
" 
""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
"set nocompatible                                 " no vi-compatible
set backspace=indent,eol,start                   " In order to modify vim8 backspace's question.

" set basic format
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" Theme and Styling
set t_Co=256
set background=dark

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

set ls=2                                         " always show status bar
set incsearch                                    " incremental search
set hlsearch                                     " highlighted search results
set nu                                           " show line numbers
set relativenumber                               " show relative number

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview
" save as sudo
ca w!! w !sudo tee "%"

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let &t_Co = 256
    colorscheme fisa
else
    colorscheme delek
endif

if has('gui_running')                            " colors for gvim
    colorscheme wombat
endif

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp                    " directory to place swap files in
set backup                                       " make backup files
set backupdir=~/.vim/dirs/backups                " where to put backup files
set undofile                                     " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

let g:solarized_termcolors = 256                 " setting color parameter
let g:yankring_history_dir = '~/.vim/dirs/'      " store yankring history file there too

if !isdirectory(&backupdir)                      " create needed directories if they don't exist
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" Plugins settings and mappings
" Edit them as you wish.

"""" Tagbar 
let g:tagbar_autofocus = 1                       " autofocus on tagbar open

"""" NERDTree 
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

"""" Signify
" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]

"""" vim-isort
"let g:vim_isort_map = '<C-i>'
"let g:vim_isort_map = ''
"let g:vim_isort_python_version = 'python3'       " specify a particular Python version, so if isort is installed under Python 3

" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

"""" Window Chooser
let g:choosewin_overlay_enable = 1               " show big letters

"""" CtrlP
let g:ctrlp_map = ',e'                           " file finder mapping
let g:ctrlp_working_path_mode = 0                " don't change working directory

" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

"""" Syntastic
let g:syntastic_check_on_open = 1                " check also when just opened the file
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'

"""" Jedi-vim
" All these mappings work only for python code:
"let g:jedi#goto_command = ',d'                   " Go to definition
"let g:jedi#usages_command = ',o'                 " Find ocurrences
"let g:jedi#goto_assignments_command = ',a'       " Find assignments

"""" NeoComplCache
" most of them not documented because I'm not sure how they work
" (docs aren't good, had to do a lot of trial and error to make 
" it play nice)
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_manual_completion_start_length = 1
let g:neocomplcache_min_keyword_length = 1
let g:neocomplcache_min_syntax_length = 1
" complete with workds from any opened file
let g:neocomplcache_same_filetype_lists = {}
let g:neocomplcache_same_filetype_lists._ = '_'

"""" TabMan
" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

"""" Autoclose
" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

"""" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
"let g:airline_theme = 'dark'
"let g:airline_theme = 'light'
"let g:airline_theme = 'solarized'
"let g:airline_theme = 'behelit'
"let g:airline_theme = 'base16'
"let g:airline_theme = 'durant'
"let g:airline_theme = 'powerlineish'
"let g:airline_theme = 'luna'
let g:airline#extensions#whitespace#enabled = 0

""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" Mappings configurationn
"
""""""""""""""""""""""""""""""""""""""""""""""""""
" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

" old autocomplete keyboard shortcut
imap <C-J> <C-X><C-O>

" simple recursive grep
nmap ,r :Ack 
nmap ,wr :Ack <cword><CR>

"""" Tagbar
" toggle tagbar display
map <F4> :TagbarToggle<CR>

"""" NERDTree 
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>

"""" Tasklist
" show pending tasks list
map <F2> :TaskList<CR>

"""" CtrlP
" tags (symbols) in current file finder mapping
nmap ,g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :CtrlPBufTagAll<CR>
 " general code finder in all files mapping
nmap ,f :CtrlPLine<CR>
" recent files finder mapping
nmap ,m :CtrlPMRUFiles<CR>
" commands finder mapping
nmap ,c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" same as previous mappings, but calling with current word as default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>

"""" Syntastic
" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>

"""" Jedi-vim
" Go to definition in new tab
"nmap ,D :tab split<CR>:call jedi#goto()<CR>

"""" recovery
" control-r to cr    20181202 garyhsieh
nmap cr <C-R>

"""" DragVisuals
" mappings to move blocks in 4 directions
vmap <expr> <S-M-LEFT> DVB_Drag('left')
vmap <expr> <S-M-RIGHT> DVB_Drag('right')
vmap <expr> <S-M-DOWN> DVB_Drag('down')
vmap <expr> <S-M-UP> DVB_Drag('up')
" mapping to duplicate block
vmap <expr> D DVB_Duplicate()

"""" Signify
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

"""" Window Chooser
" mapping
nmap  -  <Plug>(choosewin)


" old ---------------------------------------------------------------------------------------------
" control + h enter left windown
"nmap <C-H> <C-W>h
" control + j enter down windown
"nmap <C-J> <C-W>j
" control + k enter top windown
"nmap <C-K> <C-W>k
" control + l enter right windown
"nmap <C-L> <C-W>l

" 回車即選中當前項"
"inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>'     

" 上下左右鍵行為"
"\inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
"\inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
"\\inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
"\inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'

""""""""""""""""""""""""""""""""""""""""""""""""""
"
" F5 compile settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :call CompileAndRun()<CR>
func! CompileAndRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc -std=c11 % -o /tmp/a.out && /tmp/a.out"
    elseif &filetype == 'cpp'
        exec "!g++ -std=c++11 % -o /tmp/a.out && /tmp/a.out"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!%
    elseif &filetype == 'python'
        exec "!python3 %"
    endif
endfunc

