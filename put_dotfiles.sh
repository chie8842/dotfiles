#/bin/bash
date=`date +%Y%m%d-%k%M%S`

array=(
    ".vimrc"
    ".zshrc"
    ".tmux.conf"
    ".gitconfig"
    ".jupyter"
    ".ssh"
    ".vnc"
    ".zsh"
    ".tmux"
)

for file in ${array[@]}; do
    echo $file
    if [ -e ${HOME}/$file ]; then
      echo "${HOME}/$file exists"
      mkdir -p ${HOME}/backup
      cp -pr ${HOME}/$file ${HOME}/backup/$file.$date
      rm -rf ${HOME}/$file
      if [ -d ${HOME}/$file ]; then
        cp -pr ${HOME}/backup/$file.$date/* "$(pwd)"/files/$file/
      fi
    fi
    ln -sfv "$(pwd)"/files/$file ${HOME}/$file
done

