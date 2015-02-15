" disable vi compatibility
set nocompatible
" disable file type detection
filetype off

""""""""""""""""""""""""""""""""""""""""""
" initialize Vundle,
" and manage Vundle with Vundle itself
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
"Bundle 'gmarik/vundle'
"Bundle 'altercation/vim-colors-solarized'

" plugins in github

" vim-scripts plugin

" plugins outside github
""""""""""""""""""""""""""""""""""""""""""

" initialize NeoBundle
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'linux' : 'make',
            \     'unix' : 'gmake',
            \    },
            \ }
NeoBundle 'altercation/vim-colors-solarized'

call neobundle#end()

"enable file type detection, plugins, indent
filetype plugin indent on
filetype indent on

NeoBundleCheck

" for solarized colorscheme
let g:solarized_termcolors=256
let g:solarized_termtrans=1

if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

syntax on

" use os clipboard
set clipboard+=unnamed
set clipboard+=autoselect

" show line number
set number
" highlight correspondingbrackets for 0.3s
set matchtime=3
" enable wrap line
set wrap

set list
set listchars=eol:¬,tab:▸\ ,extends:>,precedes:<,trail:-

" setup tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set autoindent
set smartindent

" enable backspace deletion of indents, new line code
set backspace=2

" highlight full-pitch space
if has("syntax")
    syntax on
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Cyan guibg=Cyan
    endf
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

" show ruler
set ruler
set title
