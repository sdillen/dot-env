# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# custom workspace variables
export WORKSPACE="$HOME/workspace"
export PATH="$WORKSPACE/bin:$PATH"

# golang variables
export GOPATH="$WORKSPACE/gocode"
export GOBIN="$GOPATH/bin"
export GOROOT="/usr/local/go"
export PATH="$GOROOT/bin:$GOBIN:$PATH"

# powerline features
function _update_ps1() {
    PS1="$($GOBIN/powerline-go -jobs $(jobs -p | wc -l))"
}

if [ "$TERM" != "linux" ] && [ -f "$GOBIN/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# git get variables
export GIT_GET_PATH="$WORKSPACE/codebase"
export GIT_GET_HOST="github.com"

# kubectl
source <(kubectl completion bash)

# kubectl krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

cd $HOME && neofetch
