set fish_greeting ""
set -gx TERM xterm-256color
# set -gx TERM wezterm

fish_add_path $HOME/.cargo/bin
fish_add_path /usr/bin/java
set -gx PROFILE $HOME/.config/fish/config.fish
fish_add_path $HOME/.deno/bin

set -gx BREW /opt/homebrew/bin
fish_add_path $BREW

fish_add_path $HOME/go/bin

# for building php-src
fish_add_path /opt/homebrew/opt/bison/bin

alias g='git'
alias v='nvim'
# alias v='fd --type f --hidden --exclude .git |fzf-tmux -p |xargs nvim'
alias l='eza -la -g --icons --header --git'
alias lt='eza --tree --level=2 --long --icons --git'
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


export XDG_CONFIG_HOME="$HOME/.config"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# mkcd
function mkcd
    set new_dir $argv[1]

    if test -d "$new_dir"
        echo "'$new_dir' already exists."
        return 1
    end

    mkdir "$new_dir"
    if test $status -eq 0
        cd "$new_dir"
    else
        echo "Error creating directory '$new_dir'."
        return 1
    end
end

# jethrokuan/fzf config instead of PatrickF1/fzf.fish
fzf --fish | source
