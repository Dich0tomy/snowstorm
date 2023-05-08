{
  inputs,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;

    shell = "${pkgs.fish}/bin/fish";

    keyMode = "vi";
    mouse = true;

    baseIndex = 1;

    prefix = "C-a";

    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; let
  tokyo-night-tmux = mkTmuxPlugin {
    pluginName = "tokyo-night-tmux";
    version = "0.1.0";
    src = inputs.tokyo-night-tmux;
  };
in [
      sensible
      yank
      fpp

      tokyo-night-tmux

      # [Switch to session by name]: <prefix> + g
      # [Creates new session by name]: <prefix> + C
      # [Delete session without exiting tmux]: <prefix> + X
      # [Switch to the last session]: <prefix> + S
      # [Promote window to session]: <prefix> + @
      sessionist

      # [To save]: <prefix> + C-s
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }

      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];

    extraConfig = ''
      CONFIG_DIR="~/.config/tmux/"
      CONFIG_PATH=$CONFIG_DIR/tmux.conf

      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Renumber windows on window close
      set -g renumber-windows on

      bind C-h select-pane -L
      bind C-l select-pane -R
      bind C-k select-pane -U
      bind C-j select-pane -D

      bind c new-window -c $CONFIG_DIR "nvim $CONFIG_PATH" \; rename-window "tmux.conf"

      bind q kill-window

      bind | split-window -h -c "#{pane_current_path}"
      unbind %

      bind - split-window -c "#{pane_current_path}"
      unbind '"'

      bind "'" new-window -c "~"

      bind r source-file $CONFIG_PATH


      ##### TOKYONIGHT THEME REWORK FOR TMUX

      FG_BL_DARK=#ad11ad
      FG_BL_LIGHT=#cf33cf
      BG=#13131f
      FG_GR_LIGHT=#a9b1d6
      FG_GR_DARK=#3b4261

      set -g mode-style "fg=$FG_BL_DARK,bg=#3b4261"

      set -g message-style "fg=$FG_BL_LIGHT,bg=#3b4261"
      set -g message-command-style "fg=$FG_BL_LIGHT,bg=#3b4261"

      set -g pane-border-style "fg=#3b4261"
      set -g pane-active-border-style "fg=$FG_BL_LIGHT"

      set -g status "on"
      set -g status-justify "left"

      set -g status-style "fg=$FG_BL_LIGHT,bg=$BG"

      set -g status-left-length "100"
      set -g status-right-length "100"

      set -g status-left-style NONE
      set -g status-right-style NONE
      set -g status-right ""

      set -g status-right "#{pomodoro_status}%Y-%m-%d %A #[fg=$FG_GR_LIGHT]❮ #[fg=$FG_BL_LIGHT]%I:%M %p "
      set -g status-left "#[fg=$FG_BL_LIGHT,bold] [#S] "

      setw -g window-status-separator " "
      setw -g window-status-style "NONE,fg=$FG_BL_LIGHT,bg=$BG"
      setw -g window-status-activity-style "fg=$FG_GR_LIGHT,bg=$BG"

      setw -g window-status-format "#[fg=$FG_GR_LIGHT] #I:#W #F"
      setw -g window-status-current-format "#[bold, bg=$_BG] #I:#W #F"
    '';
  };
}
