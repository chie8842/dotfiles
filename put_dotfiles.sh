#/bin/bash
date=`date +%Y%m%d-%k%M%S`
dotfile_dir=`echo $(cd $(dirname $0) && pwd)`/files
array=(
    ".bashrc"
    ".git_template"
    ".gitconfig"
    ".gitignore_global"
    ".jupyter"
    ".sheets"
    ".tmux.conf"
    ".vimrc"
    ".ssh/config"
    ".ssh/conf.d"
    ".vnc"
    ".zsh"
    ".zshrc"
)

function ln_loop() {
    local org_dir=$1
    local org_files=`ls -1 $org_dir`
    for org_file in $org_files; do
        if [ ! -L ${HOME}/$file/$org_file ]; then
            ln -sfv $org_dir/$org_file ${HOME}/$file/$org_file
        fi
    done
}

for file in ${array[@]}; do
    echo $file
    if [ -e ${HOME}/$file -a ! -L ${HOME}/$file ]; then
        mkdir -p ${HOME}/backup
        cp -pr ${HOME}/$file ${HOME}/backup/$file.$date
        # rm -rf ${HOME}/$file
    fi
    ln -sfv $dotfile_dir/$file ${HOME}/$file
done
