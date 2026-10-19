# vim:set ft=tmux:
# Midnight Web Classic for tmux.
#
# This is a standalone, Catppuccin/tmux-inspired status line. It intentionally
# has no plugin dependency; all colors come from the Neovim Classic palette.

# Midnight Web Classic palette.
set -g @midnight_web_bg "#080F1C"
set -g @midnight_web_surface "#101B2B"
set -g @midnight_web_surface_alt "#142238"
set -g @midnight_web_selection "#233750"
set -g @midnight_web_line "#101A29"
set -g @midnight_web_border "#26374C"
set -g @midnight_web_tree_line "#55687F"

set -g @midnight_web_fg "#CBD6E6"
set -g @midnight_web_fg_soft "#A8BBCD"
set -g @midnight_web_muted "#71849D"

set -g @midnight_web_red "#D97B87"
set -g @midnight_web_blue "#86B6E0"
set -g @midnight_web_cyan "#9CC2CF"
set -g @midnight_web_green "#A4C2A4"
set -g @midnight_web_amber "#D9B77E"
set -g @midnight_web_lavender "#B7A3D6"

# Status line.
set -g status-position top
set -g status-interval 1
set -g status-justify left
set -g status-left-length 100
set -g status-right-length 140
set -gF status-style "bg=#{@midnight_web_bg},fg=#{@midnight_web_muted}"

# Session badge.
set -g status-left "#[fg=#{@midnight_web_blue},bg=#{@midnight_web_bg}]#[fg=#{@midnight_web_bg},bg=#{@midnight_web_blue},bold] #S #[fg=#{@midnight_web_blue},bg=#{@midnight_web_bg}]"

# Rounded window badges, following Catppuccin's visual hierarchy.
set -g window-status-separator " "
set -g window-status-format "#[fg=#{@midnight_web_surface},bg=#{@midnight_web_bg}]#[fg=#{@midnight_web_muted},bg=#{@midnight_web_surface},bold] #I #[fg=#{@midnight_web_fg},bg=#{@midnight_web_surface}]#W #[fg=#{@midnight_web_surface},bg=#{@midnight_web_bg}]"
set -g window-status-current-format "#[fg=#{@midnight_web_selection},bg=#{@midnight_web_bg}]#[fg=#{@midnight_web_lavender},bg=#{@midnight_web_selection},bold] #I #[fg=#{@midnight_web_fg},bg=#{@midnight_web_selection},bold]#W #[fg=#{@midnight_web_selection},bg=#{@midnight_web_bg}]"
set -gF window-status-activity-style "fg=#{@midnight_web_bg},bg=#{@midnight_web_amber},bold"
set -gF window-status-bell-style "fg=#{@midnight_web_bg},bg=#{@midnight_web_red},bold"

# Current pane path and clock.
set -g status-right "#[fg=#{@midnight_web_cyan},bg=#{@midnight_web_bg}]#[fg=#{@midnight_web_bg},bg=#{@midnight_web_cyan}] #{b:pane_current_path} #[fg=#{@midnight_web_cyan},bg=#{@midnight_web_bg}] #[fg=#{@midnight_web_muted},bg=#{@midnight_web_bg}]%H:%M "

# Pane, popup, message, and copy-mode styling.
set -gF pane-border-style "fg=#{@midnight_web_border}"
set -gF pane-active-border-style "fg=#{@midnight_web_blue}"
set -gF display-panes-colour "#{@midnight_web_muted}"
set -gF display-panes-active-colour "#{@midnight_web_blue}"
set -gF window-style "bg=#{@midnight_web_bg},fg=#{@midnight_web_fg}"
set -gF window-active-style "bg=#{@midnight_web_bg},fg=#{@midnight_web_fg}"
set -gF popup-style "bg=#{@midnight_web_surface},fg=#{@midnight_web_fg}"
set -gF popup-border-style "fg=#{@midnight_web_border}"
set -gF message-style "bg=#{@midnight_web_surface_alt},fg=#{@midnight_web_fg},fill=#{@midnight_web_surface_alt}"
set -gF message-command-style "bg=#{@midnight_web_surface_alt},fg=#{@midnight_web_fg},fill=#{@midnight_web_surface_alt}"
set -gF menu-style "bg=#{@midnight_web_surface},fg=#{@midnight_web_fg}"
set -gF menu-border-style "bg=#{@midnight_web_surface},fg=#{@midnight_web_border}"
set -gF menu-selected-style "bg=#{@midnight_web_selection},fg=#{@midnight_web_fg},bold"
set -gF mode-style "bg=#{@midnight_web_green},fg=#{@midnight_web_bg},bold"
set -gF clock-mode-colour "#{@midnight_web_cyan}"
