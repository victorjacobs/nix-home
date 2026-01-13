" If shell is fish, set shell to something more standard
if &shell =~# 'fish$'
    set shell=sh
endif

" Always show current position
set ruler
set updatetime=100

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Theme etc
set gfn=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
set cmdheight=2
colorscheme peaksea
syntax enable
" Set 7 lines around the cursor
set so=7
" Cursorline
set cursorline
autocmd ColorScheme * hi CursorLine cterm=none ctermbg=236
" Add a bit extra margin to the left
" set foldcolumn=1
set background=dark
" set signcolumn=yes

" Lightline
set laststatus=2

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ ['mode', 'paste'],
            \             ['fugitive', 'readonly', 'relativepath', 'modified'] ],
            \   'right': [ [ 'lineinfo' ], ['percent'] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
            \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
            \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
            \ },
            \ 'component_visible_condition': {
            \   'readonly': '(&filetype!="help"&& &readonly)',
            \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
            \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
            \ },
            \ 'separator': { 'left': ' ', 'right': ' ' },
            \ 'subseparator': { 'left': ' ', 'right': ' ' }
            \ }

" Quit NERDTree on opening file
let NERDTreeQuitOnOpen = 1

" Use quickfix list for ALE
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" Cursor shapes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Match brackets
set showmatch
" Matching bracket blinks
set mat=2

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set nobackup
set nowb
set noswapfile

try
    silent !mkdir -p ~/.vim/temp_dirs/undodir > /dev/null 2>&1
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

" Indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai
set si
set wrap

" Tab complete menu
set wildmenu

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Key mappings
noremap <leader>pp :setlocal paste!<cr>
noremap <leader>nn :setlocal number!<cr>
noremap <leader>rn :setlocal relativenumber!<cr>
nnoremap <leader>w :w!<cr>
nnoremap t :Files<cr>
noremap <C-o> :NERDTreeToggle<cr>
noremap ,n :NERDTreeFind<CR>
nnoremap <F5> :UndotreeToggle<cr>
noremap H ^
noremap L g_
nnoremap K <nop>
nnoremap <leader>d "_d

if has('mac')
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)

    autocmd FileType go nmap <leader>i :w!<cr><Plug>(go-install)
    autocmd FileType go map <F1> <Plug>(go-doc)
end

command! W w !sudo tee % > /dev/null
command! JF %!jq .

