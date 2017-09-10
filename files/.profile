# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH=$PYENV_ROOT/bin:$PATH:/usr/local/go/bin:~/go/bin
export GOPATH=$HOME/go

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
export LANG=ja_JP.UTF-8
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.pyenv/versions/anaconda3-4.2.0/pkgs/arrow-cpp-0.2.post-0/lib/

