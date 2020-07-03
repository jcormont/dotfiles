scriptencoding utf-8

" Coc plugins
let g:coc_global_extensions = [
\ 'coc-explorer',
\ 'coc-yank',
\ 'coc-prettier',
\ 'coc-lists',
\ 'coc-highlight',
\ 'coc-git',
\ 'coc-actions',
\ 'coc-tsserver',
\ 'coc-json'
\ ]

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-rsi'
Plug 'jiangmiao/auto-pairs'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim'
Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" General options
language en_US
set termguicolors
set clipboard=unnamed
set hidden
set expandtab
set softtabstop=2
set shiftwidth=2
set shortmess+=cI
set cmdheight=2
set signcolumn=yes
set noruler
set mouse=a
set list
set ww=<,>,[,]
set updatetime=300
set linebreak
set breakindent
set breakindentopt=shift:2,sbr
set noshowmode
set winbl=10
set ignorecase
set smartcase
set autoread
set number
set cursorline
set scrolloff=8
set splitbelow
set splitright
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup
set backup
set noswapfile
set shell=/usr/local/bin/fish
set grepprg=ag

" Theme
set background=dark
colorscheme nord
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE guifg=#333333
hi VertSplit guibg=bg guifg=#1D2030
hi Comment cterm=italic gui=italic guifg=#C5A264
hi Visual guibg=#6B7089 guifg=#ffffff
hi CocErrorHighlight guibg=#E27878 guifg=#ffffff gui=underline
hi CocWarningHighlight guifg=#E2A478 gui=underline
hi CocInfoHighlight gui=underline
hi CocHintHighlight gui=underline

" Airline options
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%2s '
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_b = "%{get(g:, 'coc_git_status', '')}%{get(b:, 'coc_git_status', '')}"
let g:airline_section_z = airline#section#create(['linenr', '/%2.3L:%2.3c'])
let g:airline_exclude_preview = 1
let g:airline_theme = 'nord'
let airline#extensions#coc#error_symbol = '⚡️'
let airline#extensions#coc#warning_symbol = 'W '

" auto-pairs option: avoid skipping over ) across lines
let g:AutoPairsMultilineClose = 0

" CoC features
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use tab for Coc completion instead of Control-n/space
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Key mappings
let g:mapleader=','
vnoremap <leader>d "_d
nnoremap j gj
nnoremap k gk
inoremap <silent><M-BS> <esc>dbxa

inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> K :call CocAction('doHover')<CR>
nnoremap <silent> - :CocCommand explorer<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gv <C-w>o:vs<CR>gd
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-git-prevchunk)
nmap <silent> ]g <Plug>(coc-git-nextchunk)
nmap <silent> gs <Plug>(coc-git-chunkinfo)
nmap <silent> gc <Plug>(coc-git-commit)
nmap <silent> <leader>qq <Plug>(coc-prettier)
nmap <silent> <leader>uu <Plug>(coc-diagnostic-next)
nmap <silent> <leader>ee <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>xx <Plug>(coc-fix-current)
nmap <silent> <leader>rr <Plug>(coc-rename)
nmap <silent> <leader>aa <Plug>(coc-codeaction)
nnoremap <silent> <leader><leader> :CocList mru<CR>
nnoremap <silent> <leader>F :CocList grep<CR>
nnoremap <silent> <leader>f :CocList --auto-preview files<CR>
nnoremap <silent> <leader>g :CocList --auto-preview gstatus<CR>

