set pastetoggle=<f3>
nmap <tab> i<tab>

" Insert blank line
nmap <Enter> o<ESC>
nmap <S-Enter> O<ESC>

" Search
map <leader>a :Rg<cr>

" Open files with <leader>f
map <leader>f :Files<cr>

" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping in .vimrc
map <leader>gf :Files %%<cr>

" Open a buffer
map <leader>b :Buffers<cr>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" Rails specific
map <leader>gv :Files app/views<cr>
map <leader>gc :Files app/controllers<cr>
map <leader>gm :Files app/models<cr>
map <leader>gh :Files app/helpers<cr>
map <leader>gl :Files lib<cr>
map <leader>gp :Files public<cr>
map <leader>gj :Files app/assets/javascripts<cr>
map <leader>gs :Files app/assets/stylesheets<cr>
map <leader>ga :Files app/assets<cr>

map <leader>gr :edit config/routes.rb<cr>
map <leader>gg :edit Gemfile<cr>

" Map kj to esc
imap kj <esc>

" next/prev quicklist item
nmap <c-b> :cprevious<CR>
nmap <c-n> :cnext<CR>

" Turn off search highlighting
map <silent> <leader><esc> :noh<return>
map <silent> <leader>/ :noh<return>

" Very magic searching (requires less regex character escaping)
nmap // /\v

" Cursor Movement *************************************************************
" Make cursor move by visual lines instead of file lines (when wrapping)
nmap <up> gk
vmap <up> gk
imap <up> <C-o>gk
nmap <down> gj
vmap <down> gj
imap <down> <C-o>gj

if !exists('vimpager')
  nnoremap j gj
  nnoremap k gk
endif

set cursorline
map <leader>c :set cursorline!<cr>
map <leader>C :set cursorcolumn!<cr>

" Use E to jump back to the previous end of a word
map E ge

" Switch between the last two files	
nnoremap <leader><leader> <c-^>

" Don't use Ex mode, use Q for macros
" (qq - record; Q - play)
map Q @q

" Sudo write
command! W w !sudo tee % > /dev/null

" remap Y to yank to end of line
map Y y$

" replace word with clipboard contents 
" nmap <leader>w "_cw0<ESC>

" ,# Surround a word with #{ruby interpolation}
map <leader># ysiw#
vmap <leader># c#{<C-R>"}<ESC>

" ," Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>( c( <C-R>" )<ESC>
vmap <leader>) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

" Window navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l

"Vertical split then hop to new buffer
noremap <leader>v :vsp<cr>
noremap <leader>h :split<cr>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Maximize viewport
map <leader>\ <C-w><bar>

map U :redo<CR>
nmap <F2> :UndotreeToggle <CR>

" Add undo to ctrl-u / ctrl-w
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Next/previous tab support in the console
noremap <M-[> :tabp<cr>
noremap <M-]> :tabn<cr>
map <leader>t :tabe<cr>
map <M-t> :tabe<cr>
map <M-q> :tabclose<cr>

" Delete buffer
map <leader><bs> :bd!<cr>

nnoremap <F4> :Errors<CR>
nmap <F8> :TagbarOpenAutoClose<CR>

" Commentary mapping, since \\ has been replaced by gc
xmap \\  <Plug>Commentary
nmap \\  <Plug>Commentary
omap \\  <Plug>Commentary
nmap \\\ <Plug>CommentaryLine

" Open file browser
map <c-e> :Lexplore<cr>

" Lookup syntax type for current word
map <F10> :echo join(reverse(map(synstack(line('.'), col('.')), {i,v -> synIDattr(v, 'name')})))<cr>
