"==============================================
" settings for menu
"==============================================

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
    nmap <Leader>l :emenu <TAB>
endif
