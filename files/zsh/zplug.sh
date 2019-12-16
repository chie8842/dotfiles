export ZPLUG_HOME=~/.zsh/zplug

if [ ! -d $ZPLUG_HOME ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
if [ -f $ZPLUG_HOME/init.zsh ]; then
  source $ZPLUG_HOME/init.zsh

  zplug "wbinglee/zsh-wakatime"

  # syntax
  #zplug "chrissicool/zsh-256color"
  #zplug "Tarrasch/zsh-colors"
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "ascii-soup/zsh-url-highlighter"

  # application
  # zplug "voronkovich/mysql.plugin.zsh"
  zplug "tcnksm/docker-alias", use:zshrc
  zplug "mollifier/cd-gitroot"

  # utils
  # zplug "marzocchi/zsh-notify"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "tymm/zsh-directory-history", \
    as:command, \
    use:'dir{hist,log}', \
    hook-build:'chmod 755 dir{hist,log}'
  zplug "zsh-users/zsh-autosuggestions", \
    use:'dist/autosuggestions.zsh'
  zplug "mollifier/anyframe"
  #zplug "b-ryan/powerline-shell"

  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi
  zplug load
fi

#-----anyframe settings-----

# expressly specify to use fzf-tmux
zstyle ":anyframe:selector:" use fzf-tmux
# expressly specify to use fzf
zstyle ":anyframe:selector:" use fzf

## よく移動するディレクトリ一覧をインクリメントサーチ & 移動
bindkey '^@' anyframe-widget-cdr
 
## bash history一覧インクリメントサーチ & 実行
bindkey '^r' anyframe-widget-execute-history
 
## branch一覧をインクリメントサーチ & checkout
bindkey '^x^b' anyframe-widget-checkout-git-branch
 
## プロセス一覧をインクリメントサーチ & kill
bindkey '^x^k' anyframe-widget-kill


##------powerline settings----
#function powerline_precmd() {
#    PS1="$(powerline-shell --shell zsh $?)"
#}
#
#function install_powerline_precmd() {
#  for s in ${precmd_functions[@]}; do
#    if [ "$s" = "powerline_precmd" ]; then
#      return
#    fi
#  done
#  precmd_functions+=(powerline_precmd)
#}
#
#if [ "$TERM" != "linux" ]; then
#    install_powerline_precmd
#fi
