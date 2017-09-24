"==============================================
" settings for vim-table-mode
"==============================================

" execute \tm or :TableModeToggle to enable table mode.\
" || to write horizontal line

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" To get ReST compatible tables use below settings
" let g:table_mode_corner_corner='+'
" let g:table_mode_header_fillchar='='

" key bind
" [|    move left
" ]|    move right
" {|    move up
" }|    move down

" \tdd  delete row
" \tdc  delete column
