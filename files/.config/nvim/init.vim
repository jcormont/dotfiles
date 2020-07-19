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
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim'
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
set list lcs=trail:·,tab:»·
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
let g:typescript_ignore_browserwords=0
set background=dark
hi clear
color default
hi Bold cterm=bold gui=bold
hi Italic cterm=italic gui=italic
hi Underline cterm=underline gui=underline
let s:c_normal = "#666677"
let s:c_darker = "#333340"
let s:c_dark = "#444455"
let s:c_light = "#DDDEEE"
let s:c_teal = "#88BBBB"
let s:c_blue = "#88AACC"
let s:c_red = "#BB6666"
let s:c_orange = "#DD8877"
let s:c_yellow = "#EECC88"
let s:c_gold = "#CCAA66"
let s:c_green = "#AABB88"
let s:c_purple = "#BB88AA"
function! s:bg(group, guibg, cterm)
  exec "hi " . a:group . " guibg=" . a:guibg .
        \" cterm=" . a:cterm . " gui=" . a:cterm
endfunction
function! s:hi(group, guifg, guibg, cterm)
  exec "hi " . a:group . " guifg=" . a:guifg . " guibg=" . a:guibg .
        \" cterm=" . a:cterm . " gui=" . a:cterm
endfunction
call s:hi("Normal", s:c_light, "bg", "NONE")
call s:hi("NormalNC", s:c_light, "bg", "NONE")
call s:hi("NonText", s:c_gold, "bg", "NONE")
call s:hi("Whitespace", s:c_normal, "bg", "NONE")
call s:hi("LineNr", s:c_normal, s:c_darker, "NONE")
call s:bg("CursorLine", s:c_darker, "NONE")
call s:bg("ColorColumn", s:c_darker, "NONE")
call s:hi("CursorColumn", s:c_blue, "bg", "NONE")
call s:hi("CursorLineNr", s:c_light, s:c_dark, "bold")
call s:hi("SignColumn", s:c_purple, s:c_darker, "NONE")
call s:hi("FoldColumn", s:c_purple, s:c_darker, "NONE")
call s:hi("VertSplit", s:c_darker, "bg", "NONE")
call s:hi("EndOfBuffer", s:c_darker, "bg", "NONE")
call s:hi("MsgArea", s:c_normal, "bg", "italic")
call s:hi("ErrorMsg", s:c_red, "bg", "italic")
call s:hi("WarningMsg", s:c_red, "bg", "italic")
call s:hi("ModeMsg", s:c_blue, "bg", "NONE")
call s:hi("MoreMsg", s:c_blue, "bg", "italic")
call s:hi("QuickFixLine", s:c_blue, "bg", "italic")
autocmd FileType list set winhighlight=CursorLine:CursorLineNr

call s:hi("StatusLine", s:c_light, s:c_dark, "NONE")
call s:hi("StatusLineBold", s:c_light, s:c_dark, "bold")
call s:hi("StatusLineNC", s:c_normal, s:c_dark, "NONE")

call s:hi("Question", s:c_blue, "bg", "italic")
call s:hi("Error", s:c_red, "bg", "NONE")
call s:hi("Warning", s:c_orange, "bg", "NONE")
call s:hi("CocErrorSign", s:c_red, "bg", "NONE")
call s:hi("CocWarningSign", s:c_orange, "bg", "NONE")
call s:hi("CocInfoSign", s:c_blue, "bg", "NONE")
call s:hi("CocErrorHighlight", s:c_light, s:c_red, "underline")
call s:hi("CocWarningHighlight", s:c_light, s:c_orange, "underline")
hi CocInfoHighlight gui=underline
hi CocHintHighlight gui=underline

call s:hi("PMenu", s:c_light, s:c_normal, "NONE")
call s:hi("PMenuSel", s:c_dark, s:c_light, "NONE")
call s:hi("WildMenu", s:c_blue, "bg", "italic")

call s:hi("MatchParen", "#FFFFFF", s:c_light, "NONE")
call s:hi("Visual", s:c_normal, s:c_light, "NONE")
call s:hi("VisualNOS", s:c_normal, s:c_light, "NONE")
call s:hi("Search", s:c_dark, s:c_light, "bold")
call s:hi("IncSearch", s:c_dark, s:c_light, "bold")
call s:bg("Substitute", s:c_normal, "bold")
call s:bg("MatchParen", s:c_normal, "bold")
call s:bg("CocHighlightText", s:c_dark, "NONE")

call s:hi("Directory", s:c_light, "bg", "bold")
call s:hi("Folded", s:c_normal, s:c_light, "NONE")
call s:hi("DiffAdd", s:c_dark, s:c_green, "NONE")
call s:hi("DiffChange", s:c_light, s:c_orange, "NONE")
call s:hi("DiffDelete", s:c_light, s:c_red, "NONE")
call s:hi("DiffText", s:c_gold, "bg", "bold")

call s:hi("Todo", s:c_red, "bg", "bold")
call s:hi("Comment", s:c_green, "bg", "italic")
call s:hi("Constant", s:c_purple, "bg", "NONE")
call s:hi("String", s:c_gold, "bg", "NONE")
call s:hi("PreProc", s:c_light, "bg", "NONE")
call s:hi("Identifier", s:c_blue, "bg", "bold")
call s:hi("Function", s:c_light, "bg", "NONE")
call s:hi("Statement", s:c_blue, "bg", "italic")
call s:hi("Keyword", s:c_blue, "bg", "italic")
call s:hi("Conditional", s:c_blue, "bg", "italic")
call s:hi("Repeat", s:c_blue, "bg", "italic")
call s:hi("Label", s:c_blue, "bg", "italic")
call s:hi("Exception", s:c_blue, "bg", "italic")
call s:hi("Type", s:c_light, "bg", "NONE")
call s:hi("Operator", s:c_orange, "bg", "NONE")
call s:hi("Delimiter", s:c_teal, "bg", "NONE")
call s:hi("Special", s:c_light, "bg", "NONE")

hi! link typescriptStorageClass Keyword
hi! link typscriptGlobal Normal
hi! link typescriptLogicSymbols Operator
hi! link javascriptLogicSymbols Operator
hi! link typescriptBraces Delimiter
hi! link javascriptBraces Delimiter
hi! link typescriptParens Delimiter
hi! link javascriptParens Delimiter

" Status line
set laststatus=2
function! GitStatus() abort
  return get(g:, 'coc_git_status', '') . get(b:, 'coc_git_status', '')
endfunction
function! CocError() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  if get(info, 'error', 0) | return ' ⚡️' . info['error'] . ' ' | endif
  return ''
endfunction
function! CocWarn() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  if get(info, 'warning', 0) | return '  ? ' . info['warning'] . ' ' | endif
  return ''
endfunction
function! CocStatus() abort
  return get(g:, 'coc_status', '')
endfunction
function! s:setStatus()
  set statusline=
  set statusline+=\ %#StatusLineBold#
  set statusline+=%{GitStatus()}
  set statusline+=\ %#StatusLine#
  set statusline+=%n
  set statusline+=\:
  set statusline+=\ %f
  set statusline+=%m%r%h%w

  set statusline+=%=
  set statusline+=%#CocErrorHighlight#
  set statusline+=%{CocError()}
  set statusline+=%#CocWarningHighlight#
  set statusline+=%{CocWarn()}
  set statusline+=%#StatusLineBold#
  set statusline+=\ %{CocStatus()}
  set statusline+=%#StatusLine#
  set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
  set statusline+=\:%{&fileformat}
  set statusline+=%#StatusLineBold#
  set statusline+=\ \ %l
  set statusline+=%#StatusLine#
  set statusline+=/%2.3L:%2.3c
  set statusline+=\ %a
endfunction
call s:setStatus()

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
nnoremap <silent> go <C-w>o:leftabove vs #<CR>

" CoC key mappings
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> K :call CocAction('doHover')<CR>
nnoremap <silent> - :CocCommand explorer<CR>
nnoremap <silent> \ :CocList --number-select --top buffers<CR>
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
nmap <silent> <leader><leader> :CocList --number-select mru<CR>
nmap <silent> <leader>F :CocList grep<CR>
nmap <silent> <leader>f :CocList --auto-preview files<CR>
nmap <silent> <leader>g :CocList --auto-preview gstatus<CR>
nmap <silent> [, :CocPrev<CR>
nmap <silent> ], :CocNext<CR>

" Show syntax highlighting groups for word under cursor
nmap <leader>? :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
