set fish_greeting ""
# set -gx TERM xterm-256color
set -gx TERM wezterm

fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /usr/bin/java
set -gx PROFILE $HOME/.config/fish/config.fish
fish_add_path $HOME/.deno/bin

alias g='git'
alias v='nvim'
# alias v='fd --type f --hidden --exclude .git |fzf-tmux -p |xargs nvim'
alias l='exa -la -g --icons --header --git'
alias lt='exa --tree --level=2 --long --icons --git'
alias gl='git log --graph --all'
alias gs='git status'
alias gc='git commit -m'
alias rm='rm -i'
alias cl='clear'
alias cd1='cd ..'
alias cd2='cd ../../'
alias cd3='cd ../../../'
alias cd4='cd ../../../../'
alias cd5='cd ../../../../../'

#theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# use vim keybind in fish
set -g fish_key_bindings fish_vi_key_bindings
bind -M insert \cc 'clear; commandline -f repaint'

# tide config
set -U tide_git_icon 
set -U tide_pwd_icon 
set -U tide_os_icon 
set tide_left_prompt_items os pwd git newline time character

#set nightflyTheme
source $HOME/.config/fish/themes/nightfly.fish

# Mac setup for pomo
# Requires https://github.com/caarlos0/timer to be installed
# brew install terminal-notifier
# brew install caarlos0/tap/timer
alias work="timer 25m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

alias rest="timer 5m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

export XDG_CONFIG_HOME="$HOME/.config"

# fzf.fish consig
# Need to execute `fisher install PatrickF1/fzf.fish`
# Search directory keymap to Ctrl+f
fzf_configure_bindings --directory=\cf
