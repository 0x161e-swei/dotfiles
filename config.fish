# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
# source $OMF_PATH/init.fish

source $HOME/.config/fish/conf.d/__async_prompt.fish

# set -g fish_user_paths $HOME/.linuxbrew/bin /home/skar/.miniconda3/bin /usr/lib/jvm/jdk-12.0.2/bin/ $fish_user_paths
set -g theme_nerd_fonts yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_date_timezone America/Chicago
set -g theme_newline_cursor yes
set -g theme_color_scheme dracula
set -g theme_show_exit_status yes
set -g fish_prompt_pwd_dir_length 3

set -U async_prompt_functions fish_right_prompt
alias l 'ls'
alias vi 'vim'


# set JAVA_HOME /usr/lib/jvm/jdk-12.0.2/bin/

eval (dircolors $HOME/.custom_dir_colors/dircolors | head -n 1 | sed 's/^LS_COLORS=/set -x LS_COLORS /;s/;$//')

