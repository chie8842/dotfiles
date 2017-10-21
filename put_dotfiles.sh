#/bin/bash
date=`date +%Y%m%d-%k%M%S`
dotfile_dir=`echo $(cd $(dirname $0) && pwd)`/files
array=(
    ".bash"
    ".bashrc"
    ".bin"
    ".config"
    ".git_template"
    ".gitconfig"
    ".gitignore_global"
    ".jupyter"
    ".profile"
    ".sheets"
    ".ssh"
    ".tmux"
    ".tmux.conf"
    ".vim"
    ".vimrc"
    ".vnc"
    ".zsh"
    ".zshrc"
)

function ln_loop() {
    local org_dir=$1
    local org_files=`ls -1 $org_dir`
    for org_file in $org_files; do
        ln -sfv $org_dir/$org_file ${HOME}/$file/$org_file
    done
}

for file in ${array[@]}; do
    echo $file
    if [ -e ${HOME}/$file ]; then
        echo "${HOME}/$file exists"
        mkdir -p ${HOME}/backup
        cp -pr ${HOME}/$file ${HOME}/backup/$file.$date
        # rm -rf ${HOME}/$file
    fi
    if [ -d ${HOME}/$file ]; then
        ln_loop $dotfile_dir/$file
    else
        ln -sfv $dotfile_dir/$file ${HOME}/$file
    fi
done
