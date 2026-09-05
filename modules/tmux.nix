{...}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    focusEvents = true;
    clock24 = true;
    escapeTime = 10;
    historyLimit = 100000;

    # Linux runtime directories can disappear on logout, preventing reattachment.
    secureSocket = false;

    extraConfig = ''
      set -g renumber-windows on
      set -g detach-on-destroy off
      set -g destroy-unattached off
      set -s exit-unattached off
      setw -g remain-on-exit failed

      set -s set-clipboard external
      set -as terminal-features ',xterm-256color:RGB,xterm-ghostty:RGB'

      bind c new-window -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      set -g status-left-length 60
      set -g status-left '#[fg=cyan]#h #[fg=green]#S #[default]'
      set -g status-right '%H:%M %d-%m'
      setw -g window-status-current-format '#[fg=green,bold]#I:#W#F#[default]'
    '';
  };
}
