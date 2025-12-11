{ pkgs,
  ...
} : {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    terminal = "tmux-256color";
	  plugins = with pkgs; [
	    tmuxPlugins.nord
      tmuxPlugins.yank
      tmuxPlugins.tmux-which-key
	  ];
    extraConfig = ''
unbind C-b
set -g prefix C-a
bind a send-prefix
bind a send-prefix
bind-key C-a last-window

set-option -g focus-events on
set-option -sg escape-time 10
set -g allow-passthrough on
setw -g xterm-keys on

setw -g automatic-rename on

set -g renumber-windows on

set -g set-titles on

set -g monitor-activity on

set -g visual-activity on

#source-file ~/.config/tmux/nord.conf

bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

bind C-c new-session

bind C-f command-prompt -p find-session 'switch-client -t %%'

bind BTab switch-client -l

bind - split-window -v

bind _ split-window -h

bind -r h select-pane -L

bind -r j select-pane -D

bind -r k select-pane -U

bind -r l select-pane -R

bind > swap-pane -D

bind < swap-pane -U

bind -r H resize-pane -L 2
bind -r J resize-pane -D 2
bind -r K resize-pane -U 2
bind -r L resize-pane -R 2

bind C-p previous-window

bind p previous-window

bind C-n next-window
bind n next-window

bind Tab last-window

set -g mouse on

set-window-option -g mode-keys vi
bind-key -T copy-mode-vi v send -X begin-selection
bind-key -T copy-mode-vi V send -X select-line
bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

        '';
  };
}
