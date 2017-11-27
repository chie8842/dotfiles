# zprof実行時に使う
# zmodload zsh/zprof && zprof

# Mac brew
PATH="$HOME/bin:/usr/local/bin:$PATH"

# ckpd brew
PATH=/opt/brew/Homebrew/bin:/opt/brew/bin:$PATH

# GTags
PATH=$PATH:$HOME/bin

# Scala
PATH=$PATH:~/scala-2.12.2/bin
export SCALA_HOME=/opt/brew/Homebrew/Cellar/scala/2.12.4

# Clojure
PATH=$PATH:~/.clojure

# go
export GOPATH=$HOME/go
PATH=$PATH:$GOPATH/bin

PATH=$PATH:~/gradle-3.5/bin
PATH=$PATH:~/.bin

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# pyenv
export PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

# Ruby
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Embulk
# PATH=$PATH:$HOME/.embulk/bin

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH


# other utils
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.pyenv/versions/anaconda3-4.2.0/pkgs/arrow-cpp-0.2.post-0/lib:~/work/jars/jni
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$HOME/work/jars/jni
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/chie-hayashida/work/dpi/gcp/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/chie-hayashida/work/dpi/gcp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/work/dpi/gcp/google-cloud-sdk/completion.zsh.inc' ]; then source '~/work/dpi/gcp/google-cloud-sdk/completion.zsh.inc'; fi


# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000


# LANG設定 rootの場合はCに設定
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac


# cdr, add-zsh-hook を有効にする
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
 
# cdr の設定
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true
# キーバインドをVi化
bindkey -e
# なんかanyframeに'^B'が取られてたので設定
bindkey '^B' backward-char

# anyframeの設定
bindkey '^x^b' anyframe-widget-checkout-git-branch
bindkey '^x^g' anyframe-widget-cd-ghq-repository
bindkey '^x^i' anyframe-widget-put-history
bindkey '^x^k' anyframe-widget-kill

# プロンプトの設定
autoload -U colors
colors
autoload history-search-end

local p_mark="%B%(?, %F{green}, %F{red})%#%f%b"

if [ -n "$SSH_CONNECTION" ]; then
    PROMPT="%F{green]}[%F{magenta}%n%F{green}@%F{cyan}%m%F{green}:%c]$p_mark"
else
    PROMPT="%F{green}[%c]$p_mark"
fi
PROMPT2="%F{magenta}%_->%f"
RPROMPT="%F{yellow}[%d]%f"
SPROMPT="%F{yellow}%r is correct? [(n)o, (y)es, (a)bort, (e)dit]:%f"

# gitの補完
fpath=(~/.zsh/completion $fpath)

# 補完入力の有効化 (zplugの中で実行されるためコメントアウト)
autoload -U compinit
compinit -u
rm -f ~/.zcompdump; compinit
setopt combiningchars
source ~/.zsh/zplug

# gitのブランチ情報などを表示
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# ls 補完リスト色設定
export LSCOLORS=gxfxcxdhbxegehabahhfhg
export LS_COLORS="di=36;49:ln=35;49:so=32;49:pi=33;47:ex=31;49:bd=34;46:cd=34;47:su=30;41:sg=30;47:tw=37;45:ow=37;46"

zstyle ':completion:*' list-colors 'di=36;49' 'ln=35;49' 'so=32;49' 'pi=33;47' 'ex=31;49' 'bd=34;46' 'cd=34;47' 'su=30;41' 'sg=30;47'  'tw=37;45' 'ow=37;46'


# エイリアス設定
case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias grep='grep --color'
alias less='less -X -R'

alias vim="vi"
#alias vim='/Applications/MacVim.app/Contents/MacOS/mvim'
#alias cvim='/Applications/MacVim.app/Contents/MacOS/Vim'

alias fstr='(){ find $1 -type f -print | xargs grep $2 }'
alias fstr2='(){ find $1 -type f |grep $2 | xargs grep $3 }'
alias dirs='dirs -v'
frepo() {
  local dir
  dir=$(ghq list > /dev/null | fzf-tmux --reverse +m) &&
    cd $(ghq root)/$dir
}

# エイリアスを拡張する(D)
setopt ALIASES

# 以降、定義されたすべての変数は自動的にexportされる
unsetopt ALL_EXPORT

# 補完候補など表示する時はその場に表示し、終了時に画面から消す
setopt ALWAYS_LAST_PROMPT

# 補完時に文字列末尾へカーソル移動
setopt ALWAYS_TO_END

# コマンドを終了した順序でヒストリファイルに追加
setopt APPEND_HISTORY

# コマンドがディレクトリの名前の時に自動的にcdコマンドとして実行する
setopt AUTO_CD

# disownコマンドでジョブテーブルから削除されストップしたジョブには自動的に CONT シグナルが送られ、実行するようになる
setopt AUTO_CONTINUE

# 補完のリストアップ
setopt AUTO_LIST

# 2度目の連続する補完の要求で自動的にメニュー補完を使う
setopt AUTO_MENU

# ディレクトリの絶対パスがセットされた変数は、そのディレクトリの名前となる
setopt AUTO_NAME_DIRS

# 変数名が補完され自動的に文字が入力されたあと、次の文字が変数名の直後に来るべきものであるなら自動的に付加された文字が削除され、入力された文字が変数名の直後に来る
setopt AUTO_PARAM_KEYS

# 中味がディレクトリ名である変数を補完すると、末尾がスペースのかわりにスラッシュとなる
setopt AUTO_PARAM_SLASH

# cdすると古いディレクトリがディレクトリスタックに積まれる
setopt AUTO_PUSHD

# 補完の結果として得られる最後の文字がスラッシュで次に入力した文字が単語の区切文字、スラッシュ、もしくはコマンドを終端する文字のとき、そのスラッシュを取り除く
setopt AUTO_REMOVE_SLASH

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt AUTO_RESUME

# ファイル名生成のパターンがフォーマット違反の時、エラーメッセージを表示する
setopt BAD_PATTERN

# cshスタイルのヒストリ拡張を使う '!' 文字を特別に扱う
setopt BANG_HIST

# グロブパターンにおいて、末尾にあって'|'も'('も'~'も含まないならば、修飾子とみなす
unsetopt BARE_GLOB_QUAL

# 曖昧な補完の場合、補完関数が二度連続で呼ばれると自動的に選択肢をリストアップする このオプションは AUTO_LIST よりも強い優先度を持つ
unsetopt BASH_AUTO_LIST

# ZLE のエラー時にビープ音を発する
#unsetopt BEEP

# 全てのバックグラウンドジョブを低優先度で実行する
unsetopt BG_NICE

# ブレース内の式が正しくない形式のとき、個々の文字の辞書順リストとなる
unsetopt BRACE_CCL

# 組み込みコマンド echo を、 BSD echo(1) コマンドと互換性のある動作にする
setopt BSD_ECHO

# グロッビング(ファイル名生成)で大文字小文字を区別する
setopt CASE_GLOB

# 16進数を C 言語形式で出力する
setopt C_BASES

# cd コマンドに与えられる引数がディレクトリではなく、スラッシュから開始されない場合には、先頭が'~' で開始されるように拡張される
unsetopt CDABLE_VARS

# パスの一部に'..'が含まれているもの、つまりひとつ前のディレクトリ名をキャンセルしたものに移動するとき、実際のディレクトリ名に移動する
unsetopt CHASE_DOTS

# ディレクトリ移動時のシンボリックリンクを真の値に変換する
unsetopt CHASE_LINKS

# バックグラウンドジョブとサスペンドしたジョブのステータスが、ジョブ制御をしたシェルの終了前に報告される
setopt CHECK_JOBS

# '>'のリダイレクションで存在するファイルを指定した場合に削除し、'>>' で存在しないファイルを指定した場合に新しいファイルを作成する
unsetopt CLOBBER

# 補完を行う前に内部的にコマンド行のエイリアスを置き換える作業を抑制する
unsetopt COMPLETE_ALIASES

# カーソルの位置に補なうことで単語を完成させようとする
setopt COMPLETE_IN_WORD

# コマンドのスペルの訂正を試みる
setopt CORRECT

# コマンド行の全ての引数に対してスペルミスの訂正を試みる
unsetopt CORRECT_ALL

# イベント識別子なしのヒストリ参照はつねに直前のコマンドとみなされる
setopt CSH_JUNKIE_HISTORY

# ループの中味として'do list; done'ではなく'list; end'の形式を許可する
setopt CSH_JUNKIE_LOOPS

# シングルクォートやダブルクォートの文字列のルールを、 csh のものと一致させる
unsetopt CSH_JUNKIE_QUOTES

# コマンドなしにリダイレクトを実行したとき、 NULLCMD および READNULLCMD の値を使わない
unsetopt CSH_NULLCMD

# ファイル名生成のパターンがマッチしないとき、引数リストからそのパターンを取り除く コマンド中の全てのパターンがマッチしない時でなければエラーを出力しない
unsetopt CSH_NULL_GLOB

# CORRECT、CORRECTALLの両オプション、およびspell-wordエディタコマンドでのスペルミス推定で、Dvorak配列を使う
unsetopt DVORAK

# ZLE がロードされていてこのオプションがオンになっているのは'bindkey -e'と等価に扱われ、 VI オプションが解除される
# setopt EMACS

# = のファイル名生成が利用される
setopt EQUALS

# あるコマンドが非ゼロの終了コードとなったとき、このオプションがセットされていると、ZERRトラップを実行して終了する
unsetopt ERR_EXIT

# あるコマンドが非ゼロの終了コードとなったとき、そのコマンドの外の関数から脱出する
unsetopt ERR_RETURN

# コマンドを実行する このオプションなしには、コマンドが読み込まれて構文エラーをチェックうするだけで、実行されない
setopt EXEC

# '#' '~' '^' といった文字をファイル名生成のパターンの一部として扱う
unsetopt EXTENDED_GLOB

# コマンドの開始時のタイムスタンプ(エポックからの秒数)と実行時間(秒単位)をヒストリに含める
setopt EXTENDED_HISTORY

# このオプションが解除されていると、シェルエディタにおけるスタート／ストップ文字(通常は ^S/^Q) によるフロー制御の出力が無効化される
setopt FLOW_CONTROL

# シェル関数やスクリプトの source 実行時に、 $0 を一時的にその関数／スクリプト名にセットする
setopt FUNCTION_ARGZERO

# ファイル名生成(グロッビング)を実行する
setopt GLOB

# このオプションがセットされていると、 declare、float、integer、readonly、および typeset(ただし local は除く)に -x フラグが与えられると、 -g フラグもオンになる
setopt GLOBAL_EXPORT

# このオプションが解除されると、起動時に /etc/zprofile、/etc/zshrc、/etc/zlogin、/etc/zlogout は実行されなくなる
setopt GLOBAL_RCS

# このオプションがセットされると、スカラ変数代入の形式の'name=pattern'の右辺でもファイル名生成が実行される
unsetopt GLOB_ASSIGN

# 現在の単語がグロブパターンのとき、その結果の単語すべてを挿入するのではなく、 MENU_COMPLETE のように補完にマッチしたものを生成し、サイクルする
setopt GLOB_COMPLETE

# '.' で開始するファイル名にマッチさせるとき、先頭に明示的に '.' を指定する必要がなくなる
unsetopt GLOB_DOTS

# 変数の結果を置換して得られた文字を、ファイル拡張やファイル名生成として扱う
setopt GLOB_SUBST

# 個々のコマンドの位置を、最初に実行したときに記憶する
setopt HASH_CMDS

# コマンド名がハッシュされるときに、それを含むディレクトリもハッシュする
setopt HASH_DIRS

# コマンド補完が行われたとき、コマンドパスが最初にハッシュされるようにする
setopt HASH_LIST_ALL

# ヒストリにおいて、出力リダイレクションに '|' を加える
setopt HIST_ALLOW_CLOBBER

# 存在しないヒストリエントリにアクセスしようとしたときにビープを出す
unsetopt HIST_BEEP

# 現在のコマンド行をヒストリに追加することによって、内部のヒストリの末尾が削られるときに、ユニークなものの前に、全く同じイベントがヒストリ中に存在する、最も古いものが削除される
unsetopt HIST_EXPIRE_DUPS_FIRST

# ラインエディタでヒストリのエントリを探索するときに、一度見たことのあるエントリと同じものは、それが連続していなければ表示しない
unsetopt HIST_FIND_NO_DUPS

# コマンド行からヒストリリストに追加されたものが古いものと全く同じ場合に、古いものをリストから削除する
unsetopt HIST_IGNORE_ALL_DUPS

# 直前のイベントと全く同じものの場合、コマンド行をヒストリリストに加えない
setopt HIST_IGNORE_DUPS

# 行の最初の文字がスペースの場合、もしくはスペースから開始される拡張エイリアスの場合に、コマンド行をヒストリリストから削除する
unsetopt HIST_IGNORE_SPACE

# ヒストリリストから関数定義を除く
unsetopt HIST_NO_FUNCTIONS

# history (fc -l) コマンドをヒストリリストから取り除く
setopt HIST_NO_STORE

# ヒストリリストに追加するときに、各コマンド行の余計な空白を取り除く
setopt HIST_REDUCE_BLANKS

# ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する
unsetopt HIST_SAVE_NO_DUPS

# ヒストリ拡張から行に持ってきた場合、それを直接は実行しない ヒストリ拡張を行い、行をバッファに読み込む
setopt HIST_VERIFY

# シェル終了時に、起動中のジョブに HUP シグナルを送る
#setopt HUP

# ブレース拡張を行わない
unsetopt IGNORE_BRACES

# ファイル終端で終了しない exit か logout の実行を要求する
unsetopt IGNORE_EOF

# このオプションがセットされると、APPEND_HISTORYのように、新しいヒストリ行は$HISTFILEにインクリメンタルに(入力されるとすぐに)追加されるようになる
setopt INC_APPEND_HISTORY

# 対話的なシェルであることを意味する
# unsetopt INTERACTIVE

# 対話的なシェルでもコメントを有効にする
setopt INTERACTIVE_COMMENTS

# ksh っぽい配列の扱いをできるだけエミュレートする
unsetopt KSH_ARRAYS

# ksh の関数オートロードをエミュレートする
unsetopt KSH_AUTOLOAD

# パターンマッチにおいて、カッコの解釈は直前の '@'、'*'、'+'、'?'、'!' によって異なる
unsetopt KSH_GLOB

# オプション設定の表示方法を変える
unsetopt KSH_OPTION_PRINT

# typeset 系のコマンド、 declare、 export、 float、 integer、 local、 readonly などの引数の処理方法を変える
unsetopt KSH_TYPESET

# コマンド行から入力したプレフィクスに曖昧さがないとき、補完リストを表示することなく補完する
setopt LIST_AMBIGUOUS

# 曖昧な補完の時にビープ音を発する
#setopt LIST_BEEP

# 異なる幅のカラムを使うことで、補完リストを小さく(なるべく少ない行数に)しようとする
setopt LIST_PACKED

# 補完リストを水平にソートする
setopt LIST_ROWS_FIRST

# 補完対象となるファイルをリストアップするとき、ファイルの末尾に識別マークをつけて種類を提示する
setopt LIST_TYPES

# このオプションがセットされると、シェル関数の終了時に、すべての(このオプションを含む)オプションは復帰される
unsetopt LOCAL_OPTIONS

# このオプションがセットされていて、関数内でシグナルのトラップが設定されているとき、関数の終了時にそのシグナルの元のトラップに復帰する
unsetopt LOCAL_TRAPS

# ログインシェルであることを示す
# setopt LOGIN

# ジョブリストがデフォルトでロングフォーマットになる
unsetopt LONG_LIST_JOBS

# コマンド名のあとに表われる、クォートされていない'anything=expression' という形式の引数は、 expression のところがパラメタ割り当てであるかのように、ファイル名拡張を行う
unsetopt MAGIC_EQUAL_SUBST

# シェルが最後にチェックした後でメールファイルがアクセスされていると、警告メッセージを表示する
unsetopt MAIL_WARNING

# ファイル名生成(グロッビング)の結果のディレクトリ名に対して、 '/' を末尾に追加する
unsetopt MARK_DIRS

# 曖昧な補完の際に、可能なリストを表示してビープを鳴らすのではなく、最初にマッチしたものをいきなり挿入する
unsetopt MENU_COMPLETE

# ジョブ制御を可能にする。対話的なシェルではデフォルトでセットされる
# setopt MONITOR

# 複数のリダイレクションが行われるときに、暗黙に tee や cat が実行される
setopt MULTIOS

# ファイル名生成のパターンにマッチするものがない場合、引数リストをそのままにするのではなく、エラーを表示する
setopt NOMATCH

# バックグラウンドジョブの状態の報告を、次のプロンプトを表示するまで待つのではなく、即座に行う
setopt NOTIFY

# ファイル名生成のパターンにマッチするものがないときは、エラーを報告するのではなく、その引数リストのパターンを除去する
unsetopt NULL_GLOB

# ファイル名生成パターンから数値ファイル名がマッチしたら、ファイル名を辞書順ではなく数値順にソートする
unsetopt NUMERIC_GLOB_SORT

# 0から開始される整数は、 IEEE Std 1003.2-1992 (ISO 994502:1993) に従って8進数として解釈する
unsetopt OCTAL_ZEROES

# ラインエディタをオーバストライクモードで起動する
unsetopt OVERSTRIKE

# コマンド名にスラッシュが含まれていても、パス探索を行う
unsetopt PATH_DIRS

# このオプションがセットされているとき、組み込みコマンド command によってシェルの組み込みコマンドを実行できる
setopt POSIX_BUILTINS

# 補完リストその他でも8ビット文字を表示する
setopt PRINT_EIGHT_BIT

# セットされているとき、 '!' をプロンプト拡張で特殊文字として扱う
setopt PROMPT_BANG

# ラインエディタのプロンプトを表示する直前に復帰文字を出力する
setopt PROMPT_CR

# セットされているとき、 '%' をプロンプト拡張で特殊文字として扱う
setopt PROMPT_PERCENT

# セットされているとき、プロンプトで変数拡張、コマンド置換、計算拡張が実行される
setopt PROMPT_SUBST

# ディレクトリスタックに同じディレクトリの複数のコピーを push しない
unsetopt PUSHD_IGNORE_DUPS

# ディレクトリスタックに数を与えるとき、 '+' と '-' の意味を交換する
unsetopt PUSHD_MINUS

# pushd と popd で、ディレクトリスタックを表示しない
unsetopt PUSHD_SILENT

# pushd に引数を与えないと、 'pushd $HOME' として動作する
unsetopt PUSHD_TO_HOME

# 'foo${xx}bar' の形式で配列を置換するとき、たとえば xx の値が (a b c) だったとすると
unsetopt RC_EXPAND_PARAM

# シングルクォートで囲まれた文字列内部でシングルクォート自身を表現する時に '''' による表現を許可する
unsetopt RC_QUOTES

# 起動時に /etc/zshenv を読み込んだあとで、 .zshnv、/etc/zprofile、.zprofile、/etc/zshrc、.zshrc、/etc/zlogin、.zlogin、.zlogout など、 'Files' の章で記述されたファイルを読み込む
setopt RCS

# 補完において、曖昧さがあっても正確なマッチを認識する
unsetopt REC_EXACT

# 制限モードになる
# setopt RESTRICTED

# 'rm *' や 'rm path/*' を実行しようとする前にユーザに確認を求めない
unsetopt RM_STAR_SILENT

# 'rm *' や 'rm path/*' の実行の前のユーザへの確認時に、10秒間だけ待ち、その間のいかなる入力も無視する
unsetopt RM_STAR_WAIT

# このオプションはヒストリファイルから新しいコマンドをインポートするのと、入力したコマンドをヒストリファイルに書き出すのの両方を行う
#setopt SHARE_HISTORY

# ファイル名拡張(~拡張など)は、変数拡張やコマンド置換、計算拡張やブレース拡張の前に行う
unsetopt SH_FILE_EXPANSION

# 変数やコマンド置換結果得られたグロッビングにおいて、またシェルがパターンを受け付ける他の場所のいくつかで、 '('、'|'、')' および '<' の特殊な意味を無効化する
unsetopt SH_GLOB

# 変数やコマンド置換結果得られたグロッビングにおいて、またシェルがパターンを受け付ける他の場所のいくつかで、 '('、'|'、')' および '<' の特殊な意味を無効化する 
# setopt SHIN_STDIN

# リダイレクションの差異に NULLCMD や READNULLCMD の値を使うのではなく、 ':' コマンドを使う
unsetopt SH_NULLCMD

# このオプションがセットされると、シェルは単一文字オプション(set や setopt で利用される)を ksh のように解釈する
unsetopt SH_OPTION_LETTERS

# for、repeat、select、if、function などの短形式を許す
setopt SHORT_LOOPS

# クォートされていない変数拡張が行われたあとで、フィールド分割を行う
unsetopt SH_WORD_SPLIT

# シェルが標準入力から読み込んでいるとき、1つのコマンドを実行したら終了する。また、コマンド行から INTERACTIVE オプションが明示的に指定されない限り、シェルは対話的でなくなる
unsetopt SINGLE_COMMAND

# 複数行ではなく、単一コマンド行編集にする
unsetopt SINGLE_LINE_ZLE

# 行がバッククォートで終端し、この行に奇数個のバッククォートがあるとき、末尾のバッククォートを無視する
unsetopt SUN_KEYBOARD_HACK

# コマンド行を受け入れたときに、右プロンプトを削除する
unsetopt TRANSIENT_RPROMPT

# 解除されていると、オプションなしで 'typeset' 系のコマンドを実行したり、割当てる値なしに既存の変数名のリストを渡したりすると、その変数の値を表示する
unsetopt TYPESET_SILENT

# 置換するときに、内容のない変数を空白として扱う
setopt UNSET

# 入力された行を表示する
unsetopt VERBOSE

# ZLE がロードされていると、このオプションをセットするのは 'bindkey -v' と同じ効果を持つ
# unsetopt VI

# 実行されるコマンドと引数を表示する
unsetopt XTRACE

# zsh line editor を利用する
setopt ZLE


# zprof実行時に使う
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
