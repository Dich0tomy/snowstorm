{
  inputs,
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    gsettings-desktop-schemas
    spotify
    zip
    unzip
    direnv
    easyeffects
    picom
    librewolf
    brave
    discord
    pcmanfm

    obs-studio

    fd
    exa
    ripgrep
    bat

    veracrypt
    keepassxc

    atuin
    dmenu
    starship
    scrot
    gh
    xclip

    ghostscript
    imagemagick_light
  ];
}
