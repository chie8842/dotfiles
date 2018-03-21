"==============================================
" settings for appearance
"==============================================

set background=dark
" colorscheme monokai
" set t_Co=256
" 行番号,ルーラーを表示
set number
set ruler
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 不可視文字を可視化
set list
if has('mac')
    set list listchars=tab:\▸\-,extends:↓,precedes:«,trail:-,eol:↩
else
    set list listchars=tab:\▸\-,extends:↓,precedes:«,trail:-
endif
" 括弧の対応をハイライト
set showmatch
" ウインドウタイトルを設定する
set title

"-------Tab系--------
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2
" オートインデント
set smartindent
set autoindent
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" FileTypeがpythonの場合のタブ設定
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

"-------拡張--------
"カーソルラインを派手にする
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

"completeoptの背景色をグレーにする
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=Green
highlight PmenuSbar ctermbg=Green
"80文字目より右の背景を薄くする
let &colorcolumn=join(range(81,999),",")
"let &colorcolumn=join(range(51,999),",")
hi ColorColumn ctermbg=235 guibg=#2c2d27 

