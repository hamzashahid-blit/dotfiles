# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

# Created by `pipx` on 2024-01-24 03:33:15
export PATH="$PATH:/home/hamza/.local/bin"

# For .NET
# PATH=$PATH:~/src/dotnet:~/.dotnet/tools
export DOTNET_ROOT=$HOME/src/dotnet
export PATH=$PATH:$DOTNET_ROOT/tools
export PATH=$PATH:$DOTNET_ROOT
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 
export DOTNET_CLI_TELEMETRY_OPTOUT=1
