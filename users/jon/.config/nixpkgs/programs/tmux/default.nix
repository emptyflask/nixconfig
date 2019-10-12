{ config, lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "Space";
    baseIndex = 1;

    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
      copycat
      open
    ];

    extraConfig = ''
      # reload tmux.conf
      bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

      set -g renumber-windows on

      # Clear buffer
      # bind -n C-k clear-history

      # Mouse works as expected
      set -g mouse on
      bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"

      # Mouse based copy
      bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
      bind-key -T copy-mode MouseDragEnd1Pane send -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy" 

      # Scrolling works as expected
      set -g terminal-overrides 'xterm*:smcup@:rmcup@'

      set -g status-position top
      set -g status-interval 1

      set -g status-fg colour231
      set -g status-bg colour234
      set -g status-left-length 20
      set -g status-left '#[fg=colour16,bg=colour254,bold] #S #[fg=colour254,bg=colour234,nobold]'
      set -g status-right '#(eval ~/.tmux/status.sh `tmux display -p "#{client_width}"`)'
      set -g status-right-length 150

      set -g window-status-format "#[fg=colour244,bg=colour234]#I #[fg=colour240] #[default]#W "
      set -g window-status-current-format "#[fg=colour234,bg=colour31]#[fg=colour117,bg=colour31] #I  #[fg=colour231,bold]#W #[fg=colour31,bg=colour234,nobold]"

      set-window-option -g window-status-fg colour249
      set-window-option -g window-status-activity-attr none
      set-window-option -g window-status-bell-attr none
      set-window-option -g window-status-activity-fg yellow
      set-window-option -g window-status-bell-fg red

      # Smart pane switching with awareness of vim splits
      is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(diff)?$"'
      bind -n M-h if-shell "$is_vim" "send-keys M-h" "select-pane -L"
      bind -n M-j if-shell "$is_vim" "send-keys M-j" "select-pane -D"
      bind -n M-k if-shell "$is_vim" "send-keys M-k" "select-pane -U"
      bind -n M-l if-shell "$is_vim" "send-keys M-l" "select-pane -R"

      bind -n C-h if-shell "$is_vim" "send-keys M-h" "select-pane -L"
      bind -n C-j if-shell "$is_vim" "send-keys M-j" "select-pane -D"
      bind -n C-k if-shell "$is_vim" "send-keys M-k" "select-pane -U"
      bind -n C-l if-shell "$is_vim" "send-keys M-l" "select-pane -R"

      unbind-key h
      bind-key h if-shell "$is_vim" "send-keys M-h" "select-pane -L"
      unbind-key j
      bind-key j if-shell "$is_vim" "send-keys M-j" "select-pane -D"
      unbind-key k
      bind-key k if-shell "$is_vim" "send-keys M-k" "select-pane -U"
      unbind-key l
      bind-key l if-shell "$is_vim" "send-keys M-l" "select-pane -R"

      # Use vim keybindings in copy mode
      setw -g mode-keys vi

      # Setup 'v' to begin selection as in Vim
      bind-key -T copy-mode-vi v send -X begin-selection

      # New window with default path set to last path
      bind '"' split-window -v -c "#{pane_current_path}"
      bind %   split-window -h -c "#{pane_current_path}"
      bind -   split-window -v -c "#{pane_current_path}"
      bind |   split-window -h -c "#{pane_current_path}"
      bind c   new-window   -c    "#{pane_current_path}"

      # Send the same input to all panes
      bind-key a set-window-option synchronize-panes
    '';
  };
}
