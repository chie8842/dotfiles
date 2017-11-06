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

" deinプラグインインストール
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/.vim/settings')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

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
