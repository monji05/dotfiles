set fish_greeting ""
set -gx TERM xterm-256color

fish_add_path /opt/homebrew/bin
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin

alias g='git'
alias vim='nvim'
alias v='fd --type f --hidden --exclude .git |fzf-tmux -p |xargs nvim'
alias ll='exa -la -g --icons --header'
alias gl='git log --graph --all'
alias gs='git status'
alias gc='git commit -m'
alias rm='rm -i'
alias cl='clear'

#theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# use vim keybind in fish
set -g fish_key_bindings fish_vi_key_bindings
bind -M insert \cc 'clear; commandline -f repaint'

set -U tide_git_icon 
