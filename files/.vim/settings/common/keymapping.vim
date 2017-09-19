"==============================================
" settings for keymapping 
"==============================================

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
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

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

"sudoを忘れて権限のないファイルを編集した時\sudoで保存
nmap ,sudo :w !sudo tee %<CR>

"<C-C><C-d>で現在のバッファと保存前のファイルをdiffする
nmap <C-C><C-D> :w !diff -u % -<CR>

"<C-C><C-g>で現在のファイルをgit diffする
nmap <C-C><C-G> :!git diff --  %<CR>

"<C-C><C-D>でvimdiffを使用して現在のバッファと元ファイルを比較する
command DiffOrigcmp vert new | set bt=nofile | r # | -1d_ | diffthis | wincmd p | diffthis
nmap <C-C>d :DiffOrig<CR>

"コマンドモード時にカーソル移動するのに便利
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Delete>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

"挿入モードで<C-C>でESCと同義
inoremap <C-C> <ESC>
"挿入モードで",date",',time'で日付、時刻挿入
inoremap ,date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap ,time <C-R>=strftime('%H:%M')<CR>

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

"JSONを整形する
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction

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
