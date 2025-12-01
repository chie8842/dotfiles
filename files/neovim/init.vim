if &compatible
  set nocompatible
endif

" Airline configuration
" Load only specific extensions to avoid duplicate registrations
let g:airline_extensions = ['tabline', 'branch']
let g:airline_theme='simple'
let g:airline_powerline_fonts=1
set laststatus=2 " Always show statusline

" NOTE: Avoid explicitly reloading airline extensions here to prevent
" duplicate funcref warnings like "has already been added". Airline will
" load extensions based on settings above during plugin startup.


" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = '~/go/src/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('ghq get https://github.com/Shougo/dein.vim')
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" dein.vim is already prepended to &runtimepath above; avoid duplicating it
" set runtimepath+=~/go/src/github.com/Shougo/dein.vim
"set rtp+=~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

" deinプラグインインストール
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/.config/nvim/settings')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  let s:non_nvim_toml = g:rc_dir . '/dein_non_nvim.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  if !has ('nvim')
	  call dein#load_toml(s:non_nvim_toml, {'lazy': 1})
  endif

  call dein#end()
  call dein#save_state()
endif



" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" fzf is managed by dein; avoid adding Homebrew path to &rtp twice
" set rtp+=/usr/local/opt/fzf

" common
filetype plugin indent on
syntax on
filetype plugin on
filetype indent on

scriptencoding utf-8
set encoding=utf-8

" 共通的な設定の読み込み
runtime! settings/common/appearance.vim
runtime! settings/common/keymapping.vim
runtime! settings/common/menu.vim
"runtime! settings/common/statusline.vim
runtime! settings/common/ui.vim
runtime! settings/common/utils.vim
