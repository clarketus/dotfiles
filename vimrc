" Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on
set noswapfile

" Nerdtree
let g:NERDTreeWinSize = 45 " Set width of column
let NERDTreeShowHidden = 1

" Nerdtree Tabs
map <F5> :NERDTreeTabsToggle<CR> " toggle key set
let g:nerdtree_tabs_open_on_gui_startup = 1
let g:nerdtree_tabs_open_on_console_startup = 2
let g:nerdtree_tabs_smart_startup_focus = 1
let g:nerdtree_tabs_open_on_new_tab = 1
let g:nerdtree_tabs_meaningful_tab_names = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_synchronize_view = 1
let g:nerdtree_tabs_focus_on_files = 0

" vim-trailing-whitespace auto trigger on save
autocmd BufWritePre * :FixWhitespace

" map CTRL-E to end-of-line
imap <C-e> <esc>$i<right>
map <C-e> $

" map CTRL-A to beginning-of-line
imap <C-a> <esc>0i
map <C-a> 0

" map \\ to comment toggle for selection
nmap \\ <Plug>NERDCommenterInvert
xmap \\ <Plug>NERDCommenterInvert
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1

" Color Line
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

" tsuquyomi (typescript)
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

" Supertab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
set omnifunc=syntaxcomplete#Complete

" line numbers
set number

" indenting
set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.
set shiftwidth=2    " Indents will have a width of 2
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces"

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty \<", "inserting implicit ", "unescaped \&" , "lacks \"action", "lacks value", "lacks \"src", "is not recognized!", "discarding unexpected", "replacing obsolete ", "has invalid value", "is invalid", "escaping malformed URI reference", "plain text isn't allowed in <head> elements", "lacks \"alt\" attribute"]
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_enable_highlighting = 1

" Colorscheme. Also requires iterm to have the right colors set
colorscheme sourcerer " http://sourcerer.xero.nu/
" colorscheme apprentice " https://github.com/romainl/Apprentice

set termguicolors

" go settings
let g:go_fmt_command = "goimports"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

" fix for syntastic error highlighting
hi! link QuickFixLine Search
