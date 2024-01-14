{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "Jetbrains Mono";
      size = 11;
    };

    extraConfig = ''
      # Pomicons
      symbol_map U+E000-U+E00D Symbols Nerd Font Mono

      # Powerline
      symbol_map U+e0a0-U+e0a2,U+e0b0-U+e0b3 Symbols Nerd Font Mono

      # Powerline Extra
      symbol_map U+e0a3-U+e0a3,U+e0b4-U+e0c8,U+e0cc-U+e0d2,U+e0d4-U+e0d4 Symbols Nerd Font Mono

      # Symbols original
      symbol_map U+e5fa-U+e62b Symbols Nerd Font Mono

      # Devicons
      symbol_map U+e700-U+e7c5 Symbols Nerd Font Mono

      # Font awesome
      symbol_map U+f000-U+f2e0 Symbols Nerd Font Mono

      # Font awesome extension
      symbol_map U+e200-U+e2a9 Symbols Nerd Font Mono

      # Octicons
      symbol_map U+f400-U+f4a8,U+2665-U+2665,U+26A1-U+26A1,U+f27c-U+f27c Symbols Nerd Font Mono

      # Font Linux
      symbol_map U+F300-U+F313 Symbols Nerd Font Mono

      # Nerd Fonts - Font Power Symbols
      symbol_map U+23fb-U+23fe,U+2b58-U+2b58 Symbols Nerd Font Mono

      # Material Design Icons
      symbol_map U+f500-U+fd46 Symbols Nerd Font Mono

      # Weather Icons
      symbol_map U+e300-U+e3eb Symbols Nerd Font Mono

      # Misc Code Point Fixes
      symbol_map U+21B5,U+25B8,U+2605,U+2630,U+2632,U+2714,U+E0A3,U+E615,U+E62B Symbols Nerd Font Mono


      ## name: Kanagawa
      ## license: MIT
      ## author: Tommaso Laurenzi
      ## upstream: https://github.com/rebelot/kanagawa.nvim/


      background #1F1F28
      foreground #DCD7BA
      selection_background #2D4F67
      selection_foreground #C8C093
      url_color #72A7BC
      cursor #C8C093

      # Tabs
      active_tab_background #1F1F28
      active_tab_foreground #C8C093
      inactive_tab_background  #1F1F28
      inactive_tab_foreground #727169
      #tab_bar_background #15161E

      # normal
      color0 #16161D
      color1 #C34043
      color2 #76946A
      color3 #C0A36E
      color4 #7E9CD8
      color5 #957FB8
      color6 #7A9589
      color7 #C8C093

      # bright
      color8  #727169
      color9  #E82424
      color10 #98BB6C
      color11 #E6C384
      color12 #7FB4CA
      color13 #938AA9
      color14 #7AA89F
      color15 #DCD7BA


      # extended colors
      color16 #FFA066
      color17 #FF5D62
    '';

    settings = {
      disable_ligatures = "cursor";

      open_url_with = "default";

      # top right bottom left
      window_padding_width = 0;
    };
  };
}
