# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# For python3-pip
PATH=$PATH:~/.local/bin

# For .NET
PATH=$PATH:~/src/dotnet:~/.dotnet/tools
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 
export DOTNET_CLI_TELEMETRY_OPTOUT=1

PATH=$PATH:~/src/omnisharp-server/OmniSharp/bin/Debug

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000

#setopt autocd
#unsetopt beep

### PLUGINS ### START
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
### PLUGINS ### END


# Basic auto/tab complete:
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.
# vi mode
bindkey -v
export KEYTIMEOUT=1
# Make Emacs the default editor for programs like git
export VISUAL=e
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^ ' autosuggest-accept
# If can't find from history, find from auto-tab
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# ZSH_AUTOSUGGEST_STRATEGY=completion

# Alt-. like in Bash, which inserts last argument of previous command
bindkey -M viins '\e.' insert-last-word
# source /usr/share/kubectl/completion.zsh


### FZF ### START
if [ -n "\${commands[fzf-share]}" ]; then
	source '/usr/share/fzf/key-bindings.zsh'
	source '/usr/share/fzf/completion.zsh'
fi
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude \".git\" . \"$1\"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude \".git\" . \"$1\"
}
# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift
  
  case \"$command\" in
  	  cd)           fzf \"$@\" --preview 'tree -C {} | head -200' ;;
  	  export|unset) fzf \"$@\" --preview \"eval 'echo \$'{}\" ;;
  	  ssh)          fzf \"$@\" --preview 'dig {}' ;;
  	  *)            fzf \"$@\" ;;
  esac
}
### FZF ### END


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


### Custom Functions ### START
e_client () {
	emacsclient -c -a "" $1 &
}

xs () { 
    xpkg -a | fzf -m --preview 'xq {1}' --preview-window=right:66%:wrap | xargs -ro sudo xbps-install -Su #xi
}

github_pass () {
  eval `keychain --eval --agents ssh id_github`
}
gitlab_pass () {
  eval `keychain --eval --agents ssh id_gitlab`
}
codeberg_pass () {
  eval `keychain --eval --agents ssh id_codeberg`
}

# # Find & Open Files
# fo () {
# 	xdg-open  $(fd . '/' | fzf)
# }
# # Find & Open Files Here (in current directory)
# foh () {
# 	xdg-open  $(fd | fzf)
# }
# Find All Files
ff () {
	xdg-open $(fd -tf . '/' | fzf)
}
# Find All Files (including Hidden) (d for dotfile)
ffd (){
	xdg-open $(fd -HI -tf . '/' | fzf)
}
# Find Files Here (in current directory) (including hidden)
ffh () {
	xdg-open $(fd -tf | fzf)
}
## Find Files Fast (in current directory)
#ffhf () {
#	xdg-open $(fd -tf | fzf)
#}
# Find & CD into Directories
fcd () {
    cd $(fd . '/' -td | fzf)	
}
# Find & CD into Directories (including hidden)
fdd () {
    cd $(fd -HI . '/' -td | fzf)	
}
# Find & CD into Directories Here (in current directory)
fdh () {
    cd $(fd -HI -td | fzf)	
}
### Custom Functions ### END


### VTERM ### START
# Directory tracking etc. NOTE: I had to put extra backslashes for it work
vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
# Clear Scrollback
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi
# Prompt Tracking & Dir Tracking
vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
# Evaluate commands like: (message 'Hello World!')
vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
        vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
        shift
    done
    vterm_printf "51;E$vterm_elisp"
}
find_file() {
    vterm_cmd find-file "$(realpath "${@:-.}")"
}
say() {
    vterm_cmd message "%s" "$*"
}
vterm_set_directory() {
	vterm_cmd update-pwd "$PWD/"
}
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ vterm_set_directory }

# Always find the VTerm Library
#if [[ "$INSIDE_EMACS" = 'vterm' ]] \\
	#&& [[ -n $EMACS_VTERM_PATH ]] \\
	#&& [[ -f $EMACS_VTERM_PATH/etc/emacs-vterm-bash.sh ]]; then
	#source $EMACS_VTERM_PATH/etc/emacs-vterm-bash.sh
#fi

### VTERM ### END


# For Lorri w/ Nix (Amazingggggg)
# eval "$(direnv hook zsh)"

DOTFILES=/home/hamza/wrk/dotfiles

### ALIASES ### START
alias cl="clear";
alias ls="exa";
alias ll="ls -l";
alias la="ls -la";
alias update="home-manager switch";
alias e="e_client";
# alias ffe="find_file";
alias gpass="codeberg_pass";
alias ghpass="github_pass"
alias glpass="gitlab_pass";
alias cbpass="codeberg_pass";
alias y="mpv --ytdl-raw-options=format-sort='res:1080'";
alias y7="mpv --ytdl-raw-options=format-sort='res:720'";
alias y4="mpv --ytdl-raw-options=format-sort='res:480'";
alias cachefd="fd -HI -tf . '/' > /dev/null"; # Cache for quick file searching
alias mypipes="cpipes -p30 -c 'cc241d' -c '98971a' -c 'd79921' -c '458588' -c 'b16286' -c '689d6a' -c 'd65d0e'"
alias gitdf='git --git-dir=$DOTFILES --work-tree=$HOME'
### ALIASES ### END


## Basic auto/tab complete:
## autoload -U compinit
#zstyle ':completion:*' menu select
#zmodload zsh/complist
## compinit
#_comp_options+=(globdots)		# Include hidden files.

## End of lines configured by zsh-newuser-install
## The following lines were added by compinstall
#zstyle :compinstall filename '/home/hamza/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Build Own LibreOffice extensions with UNO
# source /home/hamza/libreoffice_sdk/Hamzas-PC/setsdkenv_unix.sh
# OO_SDK_HOME=~/src/libreoffice/odk/settings

# pnpm
export PNPM_HOME="/home/hamza/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


###TMP TMP TMP TMP STABLE DIFFUSION
alias python=python310
