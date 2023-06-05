
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _correct
zstyle ':completion:*' format 'fd %d'
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/d3/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install