if &compatible
	  set nocompatible
endif

" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
"set rtp+=~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neocomplcache')
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/neosnippet-snippets')
"call dein#add('altercation/vim-colors-solarized')
call dein#add('crusoexia/vim-monokai')
call dein#add('scrooloose/nerdtree')
call dein#add('tpope/vim-obsession')
call dein#add('plasticboy/vim-markdown')
call dein#add('dhruvasagar/vim-table-mode')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
call dein#add('godlygeek/tabular')
call dein#add('AndrewRadev/linediff.vim')
call dein#add('elzr/vim-json')
call dein#add('shinespark/vim-list2tree')
call dein#add('junegunn/vim-emoji')
call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
call dein#add('andviro/flake8-vim')
call dein#add('heavenshell/vim-pydocstring', {'on_ft': ['python','djangohtml']})
call dein#add('itchyny/calendar.vim')
call dein#add('derekwyatt/vim-scala')
call dein#add('leafcage/yankround.vim')
call dein#add('wakatime/vim-wakatime')
"call dein#add('powerline/powerline', {'rtp': 'powerline/bindings/vim/'})

call dein#end()

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Required:
filetype plugin indent on

"ファイルタイプに応じて挙動,色を変える
syntax on
filetype plugin on
filetype indent on

"-------Plugin--------
"eskk.vim
if has('unix') && isdirectory($HOME . '/.vim/plugged/eskk.vim')
    let g:eskk#directory = "~/vim/skk"
    let g:eskk#dictionary = { 'path': "~/.vim/skk/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
    let g:eskk#large_dictionary = { 'path': "~/.vim/skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'utf-8', }
endif

"Fuf系
"http://vim.g.hatena.ne.jp/keyword/fuzzyfinder.vim
if isdirectory($HOME . '/.vim/plugged/FuzzyFinder')
    let g:fuf_modesDisable = ['mrucmd']
    nmap fb :FufBuffer<CR>
    nmap fF :FufFile<CR>
    nmap ff :FufMruFile<CR>
    nmap fl :FufChangeList<CR>
    nmap fc :FufMruCmd<CR>
endif

" 共通的な設定の読み込み
runtime! settings/common/*.vim
" プラグイン固有の設定の読み込み
runtime! settings/plugins/*.vim
