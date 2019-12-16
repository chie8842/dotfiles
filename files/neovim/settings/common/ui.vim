"==============================================
" settings for ui
"==============================================

"ターミナルでマウスを使用できるようにする
if has ("mouse")
    set mouse=a
    vmap <LeftRelease> "*ygv
    set guioptions+=a
    "set ttymouse=xterm2
endif

if has('gui')
    "ツールバーを消す
    set guioptions=egLta
    "既に開いているGVIMがあるときはそのVIMを前面にもってくる
    runtime macros/editexisting.vim
    "gp gyで+レジスタに入出力
    nmap gd "+d
    nmap gy "+y
    nmap gp "+p
    nmap gP "+P
endif

"-----Macのみ有効------
if has('gui_macvim') || has('mac')
    " 半角スペースが入ったファイル名もgfで開けるようにする
    set isfname+=32
    set guifont=Ricty\ Regular\ for\ Powerline:h11
    set guifontwide=Ricty\ Regular\ for\ Powerline:h11
    set imdisable
    "set iminsert=2
    set imsearch=0
endif

"-----Windowsのみ有効------
if has('win32')
    "フォント設定
    set guifont=MS_Gothic:h9:cSHIFTJIS
    "パスのセパレータを変更(\->/)
    set shellslash
    "ウインドウポジション、サイズの設定
    winpos 9 6
    set lines=73
    set columns=110
    "スペースの入ったファイル名も扱えるようにする
    set isfname+=32
    "ファイル保存ダイアログの初期ディレクトリをバッファのあるディレクトリにする
    set browsedir=buffer
    "カラーの設定
    colorscheme pablo
    "IME入力状態を規定にする(skkを使っているとき用)
    set iminsert=2
    set imsearch=0
    "起動時デスクトップに移動
    if isdirectory( $HOME . "/Desktop" )
        cd $HOME/Desktop
    elseif isdirectory( $HOME . "/デスクトップ" )
        cd $HOME/デスクトップ
    endif
endif
