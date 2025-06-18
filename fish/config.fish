set fish_greeting ""
set -gx TERM wezterm
# set -gx TERM xterm-256color
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /usr/bin/java
fish_add_path $HOME/www/offerbox/public_html/vendor/bin/
# for gulp
fish_add_path $HOME/www/offerbox/public_html/node_modules/.bin
set -gx PROFILE $HOME/.config/fish/config.fish
fish_add_path $HOME/.deno/bin
fish_add_path $HOME/.npm-global/bin

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
alias php_container='INIT=true docker compose exec php bash'
alias v2php_container='cd ~/www/offerbox/public_html && docker compose exec -it v2_php bash'
alias nginx_v2='cd ~/www/offerbox/public_html && docker compose exec -it v2_nginx bash'
alias docker_up='cd ~/www/common_on_local && docker-compose up -d && cd ~/www/offerbox/public_html && docker-compose up -d'
alias docker_down='cd ~/www/offerbox/public_html && docker-compose down && cd ~/www/common_on_local && docker-compose down'
alias docker_stop='cd ~/www/offerbox/public_html && docker compose stop && cd ~/www/common_on_local && docker compose stop'
# anyenvの用途は主にgulp sass がnode 9.4.0が必要だから
# nodenvでnodeのバージョンを切り替える
# nodenvで使いたいバージョンがなかったら、最新をpullする-> git -C /Users/erikomishina/.anyenv/envs/nodenv/plugins/node-build pull
alias anyenv_init='eval (anyenv init - fish| source)'
alias tmuxp='tmuxp load ~/.config/tmux/dev.yaml'
alias admin_fe_node='docker exec -i -t node /bin/sh'
alias admin_fe_playwright='docker exec -i -t playwright /bin/sh'
alias admin_fe_up='cd ~/www/offerbox-admin-frontend && docker compose -f compose.local-ofb.yml up -d'

# anyenv setup
# It's too slow below
# source (anyenv init -|psub)

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

#set nightflyTheme
# source $HOME/.config/fish/themes/nightfly.fish

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

function ps9
    if test (count $argv) -eq 0
        return 1
    end
    cd ~/www/offerbox/public_html/offerbox-v2 && APP_ENV=local ./vendor/bin/phpstan analyse --level=9 -c ./phpstan.neon.dist --memory-limit=2G $argv
end
