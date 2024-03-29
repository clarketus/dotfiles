set nocompatible " be iMproved, required for vundle
filetype off " required for vundle setup
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize

source ~/.vimrc_local " local overrides

call vundle#begin()

Plugin 'xero/sourcerer.vim' " sourcerer theme.
Plugin 'tpope/vim-sensible' " vim default settings
Plugin 'tpope/vim-surround' " change surrounds
Plugin 'tpope/vim-fugitive' " provides :Gblame
Plugin 'mhinz/vim-signify' " Shows git and hg status in the side gutter
Plugin 'bronson/vim-trailing-whitespace' " remote trailing whitespace
Plugin 'scrooloose/nerdtree' " File tree display
Plugin 'jistr/vim-nerdtree-tabs' " Allow nerdtree to persist between vim tabs
Plugin 'scrooloose/nerdcommenter' " language specific commenting
Plugin 'wincent/command-t' " open file based on name search. Requires a compile step after install.
Plugin 'fatih/vim-go' " golang support along with on-save formatting.
Plugin 'keith/swift.vim'
Plugin 'udalov/kotlin-vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'slim-template/vim-slim'
Plugin 'vim-syntastic/syntastic' " Provides compile feedback for a wide range of languages.

" g:ycm_is_loaded = 1 can be set in .vimrc_local if I am using a custom ycm.
if !exists('g:ycm_is_loaded')
  " Provides compile checks AND autocomplete for many languages, including typescript
  " YouCompleteMe does not provide compile feedback (display diagnostics) for golang or ruby. Syntastic does.
  " Will provide autocomplete for all unsuppored languages via the omnifunc.
  "
  " On MacOS not providing the  --system-libclang flag causes clang completion
  " to break.
  "
  " Before installing plugin: brew install cmake python go nodejs
  Plugin 'Valloric/YouCompleteMe', { 'do': './install.py --all --system-libclang' }
endif

call vundle#end() " required for vundle
filetype plugin indent on

syntax on
set noswapfile
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
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Colorscheme. Also requires iterm to have the right colors set
colorscheme sourcerer " https://github.com/xero/sourcerer.vim
" colorscheme apprentice " https://github.com/romainl/Apprentice

set omnifunc=syntaxcomplete#Complete " set the default omnifunc

" built into vim ruby functionality. This uses the same ruby vim is compiled against. This ruby may
" need the application bundle installed to function correctly. Run :messages to see if there is any
" error output regarding missing gems.
autocmd FileType ruby compiler ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
let g:rubycomplete_rails = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_include_object = 0
let g:rubycomplete_include_objectspace = 0
let s:rubycomplete_debug = 0
let g:rubycomplete_load_gemfile = 0
let g:rubycomplete_use_bundler = 0

" Plugins ==========================

" Plugin: vim-trailing-whitespace
autocmd BufWritePre * :FixWhitespace " vim-trailing-whitespace auto trigger on save

" Plugin: nerdtree
let g:NERDTreeWinSize = 45 " Set width of column
let NERDTreeShowHidden = 1

" Plugin: vim-nerdtree-tabs
map <F5> :NERDTreeTabsToggle<CR> " toggle key set
let g:nerdtree_tabs_open_on_gui_startup = 1
let g:nerdtree_tabs_open_on_console_startup = 2
let g:nerdtree_tabs_smart_startup_focus = 1
let g:nerdtree_tabs_open_on_new_tab = 1
let g:nerdtree_tabs_meaningful_tab_names = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_synchronize_view = 1
let g:nerdtree_tabs_focus_on_files = 0

" Plugin: nerdcommenter
" map \\ to comment toggle for selection
nmap \\ <Plug>NERDCommenterInvert
xmap \\ <Plug>NERDCommenterInvert
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1

" Plugin: command-t
let g:CommandTMaxFiles=200000
" Map Ctrl-T to open filesearch
nmap <silent> <C-t> <Plug>(CommandT)
let g:CommandTTraverseSCM = 'pwd' " only index from the current folder downwards

" Plugin: vim-go
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

" Plugin: youcompleteme
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_max_num_candidates = 10
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_cache_omnifunc = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_max_diagnostics_to_display = 500
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_auto_trigger = 0 " Use Ctrl-Space to manually trigger autocomplete rather than auto.
let g:ycm_auto_hover = '' " New YCM feature which can cause vim to freeze.

" Plugin: syntastic
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
let g:syntastic_go_checkers = ['go', 'golint'] " 'go' is slow if go is below v1.10
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_javascript_checkers = [] " TODO: Need to pick a checker and configure.
let g:syntastic_html_checkers = [] " disable this due to being too strict
