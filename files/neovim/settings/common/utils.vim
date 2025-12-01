"==============================================
" settings for utils
"==============================================

" setting
"カーソルを行頭，行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" バックスペースで削除できるものを指定する。（indent:行頭の空白, eol:改行,start:挿入モード開始位置より手前の文字）
set backspace=indent,eol,start
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" ファイルが変更されたらリロードする
set autoread
" カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline
" コマンドラインでTABで補完できるようにする
set wildchar=<C-Z>
" zshを使う
set shell=zsh

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC遅延・無反応対策: 端末エスケープシーケンスの待ち時間を短縮
set ttimeout
set ttimeoutlen=10    " ESC単体をすぐ判定
set timeout
set timeoutlen=500    " マップの待ち時間は程よく
" Insertモード時のIME状態を保持しない
"inoremap <ESC> <ESC>:set iminsert=0<CR>

"-------エンコード------
"エンコード設定
if has('unix')
    set fileformat=unix
    set fileformats=unix,dos,mac
    set fileencoding=utf-8
    set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
    set termencoding=
elseif has('win32')
    set fileformat=dos
    set fileformats=dos,unix,mac
    set fileencoding=utf-8
    set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
    set termencoding=
endif

"ワイルドメニューを使う
set wildmenu
set wildmode=longest,list,full

"OSのクリップボードを使用する
set clipboard+=unnamed,unnamedplus

"-------AutoCmd------
if has('unix')
"   "CVSのコミットはSJISで行う
"   autocmd BufRead /tmp/cvs* :set fileencoding=cp932
"   "Muttから開いた編集はiso-2022-jpで行う
"   autocmd BufRead ~/.mutt/tmp/* :set fileencoding=utf-8
"   "w3mのフォームは改行コードDOSで編集
"   autocmd BufRead ~/.w3m/w3mtmp* :set fileformat=dos
"   "どのような言語でもペースト時自動インデントしない（常時pasteは無効化）
   set nopaste
endif

"開いているバッファのディレクトリに移動
if v:version >= 700
    set autochdir
endif

"Vimを終了しても undo 履歴を復元する
"http://vim-users.jp/2010/07/hack162/
if has('persistent_undo')
    set undodir=./.vimundo,~/.vimundo
    set undofile
endif

"Makeやgrepでcwindowを自動でひらくようにする
if v:version >= 700
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
    autocmd QuickfixCmdPost l* lopen
    "M-gでGrepする
    if has('unix')
        nmap <Leader>g :vimgrep  %<LEFT><LEFT>
        nmap <Leader>f :cn<CR>
        nmap <Leader>b :cp<CR>
    elseif has('win32')
        nmap <M-g> :vimgrep  %<LEFT><LEFT>
        "M-P,Nで候補移動
        nmap <M-f> :cn<CR>
        nmap <M-b> :cp<CR>
    endif
endif

"カーソル位置を復元
"autocmd BufWinLeave ?* silent mkview
"autocmd BufWinEnter ?* silent loadview
autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

"HEXエディタとしてvimを使う
if has('unix')
    augroup Binary
        au!
        au BufReadPre  *.bin let &bin=1
        au BufReadPost *.bin if &bin | silent %!xxd -g 1
        au BufReadPost *.bin set ft=xxd | endif
        au BufWritePre *.bin if &bin | %!xxd -r
        au BufWritePre *.bin endif
        au BufWritePost *.bin if &bin | silent %!xxd -g 1
        au BufWritePost *.bin set nomod | endif
    augroup END
endif

"C-C,C-Vでターミナルからコピーできる表示形式にする(関数使用)
if has('unix')
    function Indent_switch()
        if &nu =='1'
            set noai
            set nolist
            set nonu
            set paste
            set cursorline
        else
            set ai
            set list
            set nu
            set nopaste
            set cursorline
        endif
    endfunction
    nmap <C-C><C-V> :call Indent_switch()<CR>
endif

""拡張属性を自動付与
"if has('mac')
"    autocmd BufWritePost *.txt
"        \ if &fenc=='utf-8' |
"        \ exec "silent !xattr -w com.apple.TextEncoding 'UTF-8;134217984' \"%\"" |
"        \ elseif &fenc=='euc-jp' |
"        \ exec "silent !xattr -w com.apple.TextEncoding 'EUC-JP;2361' \"%\"" |
"        \ elseif &fenc=='iso-2022-jp' |
"        \ exec "silent !xattr -w com.apple.TextEncoding 'ISO-2022-JP;2080' \"%\"" |
"        \ elseif &fenc=='cp932' |
"        \ exec "silent !xattr -w com.apple.TextEncoding 'SHIFT_JIS;2561' \"%\"" |
"        \ endif
"endif
