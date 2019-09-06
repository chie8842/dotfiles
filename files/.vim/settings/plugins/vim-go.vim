let g:go_bin_path = $GOPATH.'/bin'
filetype plugin indent on
let mapleader = "\<Space>"
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_term_mode = 'split'
let g:go_auto_type_info = 1

au FileType go nmap <leader>s <Plug>(go-def-split)
au FileType go nmap <leader>au FileType go nmap <silent> <leader>at :GoAddTags<CR>
au FileType go nmap <leader>fs :GoFillStruct<CR>
au FileType go nmap <leader>ei :GoIfErr<CR>
au FileType go nmap <leader>ki :GoKeyify<CR>
au FileType go nmap <leader>dd :GoDeclsDir<CR>
au FileType go nmap <leader>ip :GoImpl<CR>v <Plug>(go-def-vertical)

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c  <Plug>(go-coverage-toggle)
