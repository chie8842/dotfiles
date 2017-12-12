if [ ! -f ~/.bash/bash-wakatime.sh ]; then
  mkdir -p ~/.bash
  git clone https://github.com/gjsheep/bash-wakatime.git ~/.bash
fi
# Mac brew
PATH="/usr/local/bin:$PATH"

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

# ckpd brew
PATH=/opt/brew/Homebrew/bin:/opt/brew/bin:$PATH

# Embulk
# PATH=$PATH:$HOME/.embulk/bin

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH

# other utils
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.pyenv/versions/anaconda3-4.2.0/pkgs/arrow-cpp-0.2.post-0/lib:~/work/jars/jni
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$HOME/work/jars/jni:/opt/brew/Homebrew/opt/pcre/lib
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export PATH

source ~/.bash/bash-wakatime.sh
