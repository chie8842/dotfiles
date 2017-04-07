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

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
"call dein#add('altercation/vim-colors-solarized')
call dein#add('crusoexia/vim-monokai')
call dein#add('scrooloose/nerdtree')

"    NeoBundle 'Shougo/neosnippet-snippets'
"      NeoBundle 'tpope/vim-fugitive'
"        NeoBundle 'ctrlpvim/ctrlp.vim'
"	  NeoBundle 'flazz/vim-colorschemes'
"	    NeoBundle 'altercation/vim-colors-solarized'
"	      " You can specify revision/branch/tag.
"	      "   NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
	      "

" (中略)

call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


syntax on
set background=dark
" colorscheme monokai
" set t_Co=256

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

" 見た目系
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
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" 括弧の対応をハイライト
set showmatch
" TAB,EOFなどを可視化する
set list
set listchars=tab:>-,extends:<,trail:-,eol:<
" ウインドウタイトルを設定する
set title

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
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
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"自動文字数
augroup WordCount
    autocmd!
    autocmd BufWinEnter,InsertLeave,CursorHold * call WordCount('char')
augroup END
let s:WordCountStr = ''
let s:WordCountDict = {'word': 2, 'char': 3, 'byte': 4}
function! WordCount(...)
    if a:0 == 0
        return s:WordCountStr
    endif
    let cidx = 3
    silent! let cidx = s:WordCountDict[a:1]
    let s:WordCountStr = ''
    let s:saved_status = v:statusmsg
    exec "silent normal! g\<c-g>"
    if v:statusmsg !~ '^--'
        let str = ''
        silent! let str = split(v:statusmsg, ';')[cidx]
        let cur = str2nr(matchstr(str, '\d\+'))
        let end = str2nr(matchstr(str, '\d\+\s*$'))
        if a:1 == 'char'
            " ここで(改行コード数*改行コードサイズ)を'g<C-g>'の文字数から引く
            let cr = &ff == 'dos' ? 2 : 1
            let cur -= cr * (line('.') - 1)
            let end -= cr * line('$')
        endif
        let s:WordCountStr = printf('%d/%d', cur, end)
    endif
    let v:statusmsg = s:saved_status
    return s:WordCountStr
endfunction

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"ステータスラインにコマンドを表示
set showcmd
"ステータスラインを常に表示
set laststatus=2
"ファイルナンバー表示
set statusline=[%n]
"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
"ファイル名表示
set statusline+=%<%F
"変更のチェック表示
set statusline+=%m
"読み込み専用かどうか表示
set statusline+=%r
"ヘルプページなら[HELP]と表示
set statusline+=%h
"プレビューウインドウなら[Prevew]と表示
set statusline+=%w
"ファイルフォーマット表示
set statusline+=[%{&fileformat}]
"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"ファイルタイプ表示
set statusline+=%y
"ここからツールバー右側
set statusline+=%=
"skk.vimの状態
set statusline+=%{exists('*SkkGetModeStr')?SkkGetModeStr():''}
"文字バイト数/カラム番号
set statusline+=[%{col('.')-1}=ASCII=%B,HEX=%c]
"現在文字列/全体列表示
set statusline+=[C=%c/%{col('$')-1}]
"現在文字行/全体行表示
set statusline+=[L=%l/%L]
"現在のファイルの文字数をカウント
set statusline+=[WC=%{exists('*WordCount')?WordCount():[]}]
"現在行が全体行の何%目か表示
set statusline+=[%p%%]
"レジスタの中身を表示
"set statusline+=[RG=\"%{getreg()}\"]

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

"ファイルタイプに応じて挙動,色を変える
syntax on
filetype plugin on
filetype indent on

"-------キー設定-------
"矢印キーでは表示行単位で行移動する
nmap <UP> gk
nmap <DOWN> gj
vmap <UP> gk
vmap <DOWN> gj

"他のvimにviminfoを送る
"http://nanasi.jp/articles/howto/editing/rviminfo.html
nmap ,vw :vw<CR>
nmap ,vr :vr<CR>

"ZZは強制的に書き込む
map ZZ :wq!<CR>

"C-Lでawkを呼び出す
nmap <C-C><C-L> :w !awk 'BEGIN{n=0}{n+=$1}END{print n}'

"C-P,C-Nでバッファ移動,C-Dでバッファ消去
nmap <C-P> :bp<CR>
nmap <C-N> :bn<CR>
nmap <C-D> :bd<CR>

"C-Nで新しいバッファを開く
nmap <C-C><C-N> :new<CR>

"C-L,C-Lでバッファリスト
nmap <C-L><C-L> :ls<CR>
"C-L,C-Rでレジスタリスト
nmap <C-L><C-R> :dis<CR>
"C-L,C-Kでキーマップリスト
nmap <C-L><C-K> :map<CR>
"C-L,C-Mでマークリスト
nmap <C-L><C-M> :marks<CR>
"C-L,C-Jでジャンプリスト
nmap <C-L><C-J> :jumps<CR>
"C-L,C-Hでコマンドヒストリ
nmap <C-L><C-H> :his<CR>
"C-L,C-Uでアンドゥヒストリ
nmap <C-L><C-U> :undolist<CR>

"C-W,sで横分割
nmap <C-W>s :sp<CR>
"C-W,vで縦分割
nmap <C-W>v :vsp<CR>

"C-W,oでファイルを指定して横分割、オープン
nmap <C-W>o :sp
"C-W,Oでファイルを指定して縦分割、オープン
nmap <C-W>O :vp

"C-W,好みの方向キーで新しくバッファを開く
nmap <C-W><C-h> :vne<cr>
nmap <c-w><c-j> :bel new<cr>
nmap <c-w><c-k> :new<cr>
nmap <c-w><c-l> :rightb vnew<cr>

"C-W,eでファイルブラウザを横分割起動
nmap <C-W>e :vsp<CR>:wincmd w<CR>:e! ./<CR>
"C-W,Eでファイルブラウザを縦分割起動
nmap <C-W>E :sp<CR>:wincmd w<CR>:e! ./<CR>

"C-W,C-Aで現在のウインドウのみの表示
nmap <C-W><C-A> :all<CR>

"C-C,C-Rでカーソル語の置き換え
nmap <C-C><C-R> yw:%s:<C-R>0::g<LEFT><LEFT>
"C-C,rでYankした文字列との置き換え
nmap <C-C>r :%s:<C-R>0::g<LEFT><LEFT>
"C-C,gでカーソル語が存在する行の削除
nmap <C-C>g yw:g:<C-R>0:d
"C-C,Gでカーソル語が存在する行以外の削除
nmap <C-C>G yw:v:<C-R>0:d
",celで空白行の削除
nmap ,cel :%s:^$\n:<CR>
",cclでコメント行の削除
nmap ,ccl :%s:^\("\\|#\\\|\*\).*$\n:<CR>
",cdで現在編集中のファイルのあるディレクトリに変更
nmap ,cd :cd %:h<CR>

"コマンドモード時にカーソル移動するのに便利
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Delete>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

"<ESC>hでハイライトをOFFにする
nmap <ESC><ESC> :noh<CR>

"Insertmodeで<C-C>でESCと同義
inoremap <C-C> <ESC>

"<S-TAB>でexpandtabをトグル
function Tab_switch()
    if &expandtab =='1'
        set noexpandtab
    else
        set expandtab
    endif
endfunction
nmap <S-TAB> :call Tab_switch()<CR>

"<ESC>wでnowrapをトグル
function Wrap_switch()
    if &wrap =='1'
        set nowrap
    else
        set wrap
    endif
endfunction
nmap <ESC>w :call Wrap_switch()<CR>

"-------MENU-------
"SSHを通してファイルオープン
menu User.Open.SCP.NonSprit :e! scp:///<LEFT>
menu User.Open.SCP.VSprit :vsp<CR>:wincmd w<CR>:e! scp:///<LEFT>
menu User.Open.SCP.Sprit :sp<CR>:wincmd w<CR>:e! scp:///<LEFT>
"分割してファイルブラウザを起動
menu User.Open.Explolr.NonSprit :vsp<CR>:wincmd w<CR>:e! ./<CR>
menu User.Open.Explolr.VSprit :vsp<CR>:wincmd w<CR>:e! ./<CR>
menu User.Open.Explolr.Sprit :sp<CR>:wincmd w<CR>:e! ./<CR>
"各種VIMの記録情報を表示する
menu User.Buffur.RegisterList :dis<CR>
menu User.Buffur.BuffurList :ls<CR>
menu User.Buffur.HistoryList :his<CR>
menu User.Buffur.MarkList :marks<CR>
menu User.Buffur.JumpList :jumps<CR>
"エンコードを指定して再読み込み
menu User.Encode.reload.SJIS :e ++enc=cp932<CR>
menu User.Encode.reload.EUC :e ++enc=euc-jp<CR>
menu User.Encode.reload.ISO :e ++enc=iso-2022-jp<CR>
menu User.Encode.reload.UTF :e ++enc=utf-8<CR>
"保存エンコードを指定
menu User.Encode.convert.SJIS :set fenc=cp932<CR>
menu User.Encode.convert.EUC :set fenc=euc-jp<CR>
menu User.Encode.convert.ISO :set fenc=iso-2022-jp<CR>
menu User.Encode.convert.UTF :set fenc=utf-8<CR>
"フォーマットを指定して再読み込み
menu User.Format.Unix :e ++ff=unix<CR>
menu User.Format.Dos :e ++ff=dos<CR>
menu User.Format.Mac :e ++ff=mac<CR>
"行番号をファイルに挿入
menu User.Global.No :%!awk '{print NR, $0}'<CR>
"TABをSPACEに変換する
menu User.Global.Space :set expandtab<CR>:retab<CR>
"空白行を削除する
menu User.Global.Delete :g/^$/d<CR>
"カーソル上の単語を全体から検索し、別ウインドウで表示
menu User.Cursor.Serch.Show [I
menu User.Cursor.Serch.Top [i
menu User.Cursor.Serch.Junp [<tab>
"カーソル上のファイルのオープン
menu User.Cursor.FileOpen gf
"コピー、ペーストモード
menu User.Cursor.Paste :call Indent()<CR>
"全体置き換えモード
menu User.Cursor.Replace :%s/
"C-C,C-Rと同様
menu User.Cursor.Delete yw:%v:<C-R>0

"CUI時にメニューをA-lで表示する
set wildcharm=<TAB>
if has('gui')
    nmap <M-l> :emenu <TAB>
else
    nmap <ESC>l :emenu <TAB>
endif

"-------GUI--------
"ワイルドメニューを使う
set wildmenu
set wildmode=longest,list,full

"OSのクリップボードを使用する
set clipboard+=unnamed,autoselect

"ターミナルでマウスを使用できるようにする
if has ("mouse")
"    set mouse=a
    set guioptions+=a
    set ttymouse=xterm2
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

"-------AutoCmd------
if has('unix')
"   "CVSのコミットはSJISで行う
"   autocmd BufRead /tmp/cvs* :set fileencoding=cp932
"   "Muttから開いた編集はiso-2022-jpで行う
"   autocmd BufRead ~/.mutt/tmp/* :set fileencoding=utf-8
"   "w3mのフォームは改行コードDOSで編集
"   autocmd BufRead ~/.w3m/w3mtmp* :set fileformat=dos
"   "どのような言語でもペースト時自動インデントしない
   autocmd BufRead * :set paste
endif

"-------VIM7以降--------
"Tab操作
if v:version >= 700
    "15までタブを開く
    set tabpagemax=15
    "タブラインを常に表示する
    "set showtabline=2
    if has('unix')
        nmap <ESC>t :tabnew<CR>
        nmap <ESC>e :tabnew ./<CR>
        nmap <ESC>n :tabn<CR>
        nmap <ESC>p :tabp<CR>
        nmap <ESC>o :tabo<CR>
        nmap <ESC>d :tabd
        if has('gui')
            nmap <M-t> :tabnew<CR>
            nmap <M-e> :tabnew ./<CR>
            nmap <M-n> :tabn<CR>
            nmap <M-p> :tabp<CR>
            nmap <M-o> :tabo<CR>
            nmap <M-d> :tabd
        endif
    elseif has('win32')
        nmap <M-t> :tabnew<CR>
        nmap <M-e> :tabnew ./<CR>
        nmap <M-n> :tabn<CR>
        nmap <M-p> :tabp<CR>
        nmap <M-o> :tabo<CR>
        nmap <M-d> :tabd
    endif
endif

"開いているバッファのディレクトリに移動
if v:version >= 700
    set autochdir
endif

"Vimを終了しても undo 履歴を復元する
"http://vim-users.jp/2010/07/hack162/
"if has('persistent_undo')
    "set undodir=./.vimundo,~/.vimundo
    "set undofile
"endif

"Makeやgrepでcwindowを自動でひらくようにする
if v:version >= 700
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
    autocmd QuickfixCmdPost l* lopen
    "M-gでGrepする
    if has('unix')
        nmap <Esc>g :vimgrep  %<LEFT><LEFT>
        nmap <Esc>f :cn<CR>
        nmap <Esc>b :cp<CR>
    elseif has('win32')
        nmap <M-g> :vimgrep  %<LEFT><LEFT>
        "M-P,Nで候補移動
        nmap <M-f> :cn<CR>
        nmap <M-b> :cp<CR>
    endif
endif

"-------拡張--------
"カーソルラインを派手にする
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

"completeoptの背景色をグレーにする
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=Green
highlight PmenuSbar ctermbg=Green

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

",nnで絶対行に表示切り替え
if has('unix')
    function Relnum_switch()
        if &relativenumber =='1'
            set norelativenumber
        else
            set relativenumber
        endif
    endfunction
    nmap ,nn :call Relnum_switch()<CR>
endif

"SSH越しにファイルを編集する
if has('unix')
    function Scp_edit(svr)
        vsp
        wincmd w
        let sv = "e scp://" . a:svr . "/../"
        exec sv
    endfunction
    nmap ,ssh :call Scp_edit("")<LEFT><LEFT>
endif

"挿入モードで",date",',time'で日付、時刻挿入
inoremap ,date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap ,time <C-R>=strftime('%H:%M')<CR>

"sudoを忘れて権限のないファイルを編集した時\sudoで保存
nmap ,sudo :w !sudo tee %<CR>

"<C-C><C-d>で現在のバッファと保存前のファイルをdiffする
nmap <C-C><C-D> :w !diff -u % -<CR>

"<C-C><C-g>で現在のファイルをgit diffする
nmap <C-C><C-G> :!git diff --  %<CR>

"<C-C><C-D>でvimdiffを使用して現在のバッファと元ファイルを比較する
command DiffOrigcmp vert new | set bt=nofile | r # | -1d_ | diffthis | wincmd p | diffthis
nmap <C-C>d :DiffOrig<CR>

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

"-----Macのみ有効------
if has('gui_macvim')
    "ウインドウポジション、サイズの設定
    winpos 837 22
    set isfname+=32
    set lines=90
    set columns=140
    colorscheme murphy
    set guifont=Menlo\ Regular:h10
    set guifontwide=Menlo\ Regular:h10
    "set guifont=Ricty\ Regular\ for\ Powerline:h11
    "set guifontwide=Ricty\ Regular\ for\ Powerline:h11
    "set imdisable
    "set iminsert=2
    "set imsearch=0
endif

"拡張属性を自動付与
if has('mac')
    autocmd BufWritePost *.txt
        \ if &fenc=='utf-8' |
        \ exec "silent !xattr -w com.apple.TextEncoding 'UTF-8;134217984' \"%\"" |
        \ elseif &fenc=='euc-jp' |
        \ exec "silent !xattr -w com.apple.TextEncoding 'EUC-JP;2361' \"%\"" |
        \ elseif &fenc=='iso-2022-jp' |
        \ exec "silent !xattr -w com.apple.TextEncoding 'ISO-2022-JP;2080' \"%\"" |
        \ elseif &fenc=='cp932' |
        \ exec "silent !xattr -w com.apple.TextEncoding 'SHIFT_JIS;2561' \"%\"" |
        \ endif
endif

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

