if [ ! -f ~/.bash/bash-wakatime.sh ]; then
  git clone https://github.com/gjsheep/bash-wakatime.git ~/.bash
fi
source ~/.bash/bash-wakatime.sh
export PATH="$HOME/.embulk/bin:$PATH":$HOME/gradle-3.5/bin
