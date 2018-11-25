syntax on
set noswapfile

" Vundle plugin manager
set nocompatible " be iMproved, required for vundle
filetype off " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()

autocmd BufWritePre * :retab " convert tabs to spaces on save

let mapleader = '\'

" map CTRL-E to end-of-line
imap <C-e> <esc>$i<right>
map <C-e> $

" map CTRL-A to beginning-of-line
imap <C-a> <esc>0i
map <C-a> 0

" Vertical color line to show file width
if exists('+colorcolumn')
  set colorcolumn=100
  hi ColorColumn guibg=#300000 ctermbg=52
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Enable mouse in console vim
set mouse=a
set ttymouse=xterm2
set ttyfast

" tmux fixes
if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" line numbers and tabs
set number
set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.
set shiftwidth=2    " Indents will have a width of 2
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces"

" Colorscheme. Also requires iterm to have the right colors set
colorscheme sourcerer " http://sourcerer.xero.nu/
" colorscheme apprentice " https://github.com/romainl/Apprentice

set omnifunc=syntaxcomplete#Complete " set the default omnifunc

Plugin 'tpope/vim-sensible' " vim default settings
Plugin 'tpope/vim-surround' " change surrounds

Plugin 'tpope/vim-fugitive' " provides :Gblame
Plugin 'airblade/vim-gitgutter' " Shows git status in the side gutter

Plugin 'bronson/vim-trailing-whitespace' " remote trailing whitespace
autocmd BufWritePre * :FixWhitespace " vim-trailing-whitespace auto trigger on save

Plugin 'scrooloose/nerdtree' " File tree display
let g:NERDTreeWinSize = 45 " Set width of column
let NERDTreeShowHidden = 1

Plugin 'jistr/vim-nerdtree-tabs' " Allow nerdtree to persist between vim tabs
map <F5> :NERDTreeTabsToggle<CR> " toggle key set
let g:nerdtree_tabs_open_on_gui_startup = 1
let g:nerdtree_tabs_open_on_console_startup = 2
let g:nerdtree_tabs_smart_startup_focus = 1
let g:nerdtree_tabs_open_on_new_tab = 1
let g:nerdtree_tabs_meaningful_tab_names = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_synchronize_view = 1
let g:nerdtree_tabs_focus_on_files = 0

Plugin 'scrooloose/nerdcommenter' " language specific commenting
" map \\ to comment toggle for selection
nmap \\ <Plug>NERDCommenterInvert
xmap \\ <Plug>NERDCommenterInvert
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1

Plugin 'wincent/command-t' " open file based on name search
let g:CommandTMaxFiles=200000
nmap <silent> <C-t> <Plug>(CommandT)

Plugin 'fatih/vim-go' " golang support along with on-save formatting.
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_def_mapping_enabled = 0 " frees up key mapping
" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

" Other languages
Plugin 'keith/swift.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'slim-template/vim-slim'

" Provides compile checks AND autocomplete for many languages, including typescript
" YouCompleteMe does not provide compile feedback (display diagnostics) for golang or ruby. Syntastic does.
" Will provide autocomplete for all unsuppored languages via the omnifunc.
Plugin 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Provides compile feedback for a wide range of languages.
Plugin 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0 " auto open the error list
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
hi! link QuickFixLine Search " fix for syntastic error highlighting
" NOTE: run :SyntasticInfo on a file to see what checkers are available and active. Some checkers
" will only be available if a dependent binary is also installed via homebrew.
let g:syntastic_go_checkers = ['go'] " This is slow if go is below v1.10
let g:syntastic_ruby_checkers = ['mri'] " This checker is pretty basic. Is not app aware.
let g:syntastic_javascript_checkers = [] " TODO: Need to pick a checker and configure.
let g:syntastic_html_checkers = [] " disable this due to being too strict

call vundle#end() " required for vundle
filetype plugin indent on
