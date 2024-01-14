{
  inputs,
  pkgs,
  config,
  ...
}: let 

vencord-discord = pkgs.discord.override {
  nss = pkgs.nss_latest; # Open links with firefox
  withOpenASAR = true; # Faster startup, more privacy, some mods
  # withVencord = true; # Cool client mod
}; 

in {
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.gsettings-desktop-schemas
    pkgs.spotify
    pkgs.zip
    pkgs.unzip
    pkgs.easyeffects
    pkgs.picom
    pkgs.librewolf
    pkgs.discord
    pkgs.pcmanfm

    pkgs.ytmdesktop

    pkgs.obs-studio

    pkgs.gromit-mpx

    pkgs.fd
    pkgs.eza
    pkgs.ripgrep
    pkgs.bat
    pkgs.broot
    pkgs.comma

    pkgs.veracrypt
    pkgs.keepassxc

    pkgs.atuin
    pkgs.dmenu
    pkgs.starship
    pkgs.scrot
    pkgs.gh
    pkgs.xclip

    pkgs.cachix
  ];
}
