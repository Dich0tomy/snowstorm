{
  inputs,
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    spotify
    zip
    unzip
    direnv
    easyeffects
    picom
    brave
    discord
    pcmanfm
    fd
    exa
    ripgrep
    tmux
    atuin
    dmenu
    starship
    scrot
    gh
    xclip
  ];
}
