#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# shell prompt
PS1='> '

# system aliases
alias nm0='sudo systemctl disable --now NetworkManager && sudo systemctl mask NetworkManager'
alias nm1='sudo systemctl unmask NetworkManager && sudo systemctl enable --now NetworkManager'
alias ol0='systemctl --user disable --now ollama.service'
alias ol1='systemctl --user enable --now ollama.service'
alias off='systemctl --user disable --now ollama.service && sudo systemctl disable --now NetworkManager && sudo systemctl mask NetworkManager && sudo systemctl disable --now bluetooth && sudo systemctl mask bluetooth && sudo systemctl poweroff'
alias on='systemctl --user disable --now ollama.service && sudo systemctl disable --now NetworkManager && sudo systemctl mask NetworkManager && sudo systemctl disable --now bluetooth && sudo systemctl mask bluetooth && sudo systemctl reboot'
alias x1='startx'
alias x2='nm1 && startx'
alias x3='nm1 && bt1 && startx'
alias bt0='sudo systemctl disable --now bluetooth && sudo systemctl mask bluetooth'
bt1() {
  sudo systemctl unmask bluetooth
  sudo systemctl enable --now bluetooth
  sleep 0.5
  bluetoothctl connect $(sudo cat $HOME/.files/device)
}

# navigation aliases
alias grep='grep --color=auto'
alias ls='ls -a --color=auto'
cd() {
  builtin cd "$@" && ls -a
}

# pacman aliases
alias qq='pacman -Qq'
alias rns='sudo pacman -Rns'
alias s='sudo pacman -S'
alias sc='sudo pacman -Sc'
alias se='pacman -Ss'
alias syu='sudo pacman -Syu'

# package aliases
alias nvim='export NVIM_LISTEN_ADDRESS="/tmp/nvim-$$.sock" && nvim --listen "$NVIM_LISTEN_ADDRESS"'
alias ranger='ranger --choosedir=$HOME/.files/.rangerdir; LASTDIR=`cat $HOME/.files/.rangerdir`; cd "$LASTDIR"'
alias torc='curl https://check.torproject.org'
alias torr='sudo systemctl restart tor'
alias tors='systemctl status tor'
hear() {
  echo "$@" | text2wave -scale 0.5 | paplay
}

# exports
export EDITOR=nvim
export VISUAL=nvim
