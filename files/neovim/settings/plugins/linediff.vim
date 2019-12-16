” １つ目に選択した行をbuffer上で開く（初期値はtabnew）
let g:linediff_first_buffer_command = ‘new’
” ２つ目に選択した行を垂直分割して開く（初期値はrightbelow vertical new）
let g:linediff_second_buffer_command = ‘vertical new’
” LinediffResetをqをタイプすることで実行(2行表示されてますが1行で）
autocmd User LinediffBufferReady nnoremap <buffer> q :LinediffReset<cr>
” コマンドショートカット
command! -range Ld  call linediff#Linediff(<line1>, <line2>)
command! -bang  Ldr call linediff#LinediffReset(<q-bang>)
“このコマンドショートカットは、linediff version 0.2.0で動作OK。 version 0.3.0にアップデートしたら、以下の様に修正が必要になります。
command! -range Ld  call linediff#Linediff(<line1>, <line2>, {})
command! -bang  Ldr call linediff#LinediffReset(<q-bang>, {})
