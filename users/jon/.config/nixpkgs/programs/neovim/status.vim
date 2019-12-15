" status line
set noshowmode

let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus', 'currentfunction' ]
  \       ]
  \ },
  \ 'colorscheme': 'jellybeans',
  \ 'component': {
  \   'lineinfo': " %3l:%-2v",
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'gitbranch': 'LightlineFugitive',
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction'
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \ }

function! LightlineReadonly()
  return &readonly ? '' : ""
endfunction

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# "" ? ' '.branch : ""
  endif
  return ""
endfunction

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction
