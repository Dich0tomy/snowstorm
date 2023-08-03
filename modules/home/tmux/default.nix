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

    plugins = with pkgs; let
      tokyo-night-tmux = tmuxPlugins.mkTmuxPlugin {
        pluginName = "tokyo-night-tmux";
        rtpFilePath = "tokyo-night.tmux";
        version = "0.1.0";
        src = fetchFromGitHub {
          owner = "B4mbus";
          repo = "tokyo-night-tmux";
          rev = "master";
          sha256 = "R1t6E5Dd3Zq0MPdXnYyvU0+juC2/0pt6r+Hi3QeMKm4=";
        };
      };

      cowboy = tmuxPlugins.mkTmuxPlugin {
        pluginName = "tmux-cowbowy";
        rtpFilePath = "cowboy.tmux";
        version = "0.1.0";
        src = fetchFromGitHub {
          owner = "tmux-plugins";
          repo = "tmux-cowboy";
          rev = "master";
          sha256 = "sha256-KJNsdDLqT2Uzc25U4GLSB2O1SA/PThmDj9Aej5XjmJs=";
        };
      };
    in [
      tokyo-night-tmux
      cowboy

      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.fpp

      # [Switch to session by name]: <prefix> + g
      # [Creates new session by name]: <prefix> + C
      # [Delete session without exiting tmux]: <prefix> + X
      # [Switch to the last session]: <prefix> + S
      # [Promote window to session]: <prefix> + @
      tmuxPlugins.sessionist

      # [To save]: <prefix> + C-s
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }

      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];

    extraConfig = ''
      CONFIG_DIR="~/.config/tmux/"
      CONFIG_PATH=$CONFIG_DIR/tmux.conf

      set-option -g allow-passthrough on

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
    '';
  };
}
