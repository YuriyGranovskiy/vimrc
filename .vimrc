execute pathogen#infect()	

" Setting up vim-plug as the package manager {{{
if !filereadable(expand("~/vimfiles/autoload/plug.vim"))
    echo "Installing vim-plug and plugins. Restart vim after finishing the process."
    silent call mkdir(expand("~/vimfiles/autoload", 1), 'p')
    execute "!curl -fLo ".expand("~/vimfiles/autoload/plug.vim", 1)." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall
endif

set rtp+=~\vimfiles

call plug#begin('~/vimfiles/plugged')
let g:plug_url_format = 'https://github.com/%s.git'

" Plugin settings {{{

Plug 'saaguero/vim-utils'
Plug 'saaguero/vimcompletesme'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'OrangeT/vim-csharp'
Plug 'altercation/solarized'
Plug 'othree/xml.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()
"}}}

" Vim sensible settings {{{
filetype plugin indent on

" better backup, swap and undo storage {{{

set backupdir=~/vimfiles/dirs/backup
set undodir=~/vimfiles/dirs/undo
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif
if !isdirectory(&undodir)
  call mkdir(&undodir, "p")
endif
"}}}
"}}}

" Terminal setttings {{{
set hlsearch
set incsearch
set number
set fileformat=dos
set tabstop=4

set showmode                    " show the current mode
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set ruler                       " show the cursor position all the time

" Turn off any bells
set novisualbell
set t_vb=

set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

syntax enable
set background=dark
set statusline=%f\ %y\ %=\ [%{&enc}]\ [%{&ff}]\ [lines:%L]\ [ln:%l,col:%v][%p%%]
set laststatus=2

set splitright
set splitbelow
"}}}

" Mapping {{{
 nnoremap <C-s> :w<CR>
"}}}

" NERDTree settings {{{

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "-",
    \ "Renamed"   : "r",
    \ "Unmerged"  : "^",
    \ "Deleted"   : "X",
    \ "Dirty"     : "x",
    \ "Clean"     : "=",
    \ "Unknown"   : "?"
    \ }
let g:NERDTreeWinPos = "right"

autocmd vimenter * NERDTree | wincmd p
" }}}

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")
