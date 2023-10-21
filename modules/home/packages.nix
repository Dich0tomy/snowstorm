{
  inputs,
  pkgs,
  config,
  ...
}: let vencord-discord = pkgs.discord.override {
  nss = pkgs.nss_latest;
  withOpenASAR = true;
  withVencord = true;
}; in {
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.gsettings-desktop-schemas
    pkgs.spotify
    pkgs.zip
    pkgs.unzip
    pkgs.direnv
    pkgs.easyeffects
    pkgs.picom
    pkgs.librewolf
    pkgs.brave
    vencord-discord
    pkgs.pcmanfm

    pkgs.obs-studio

    pkgs.prismlauncher

    pkgs.fd
    pkgs.eza
    pkgs.ripgrep
    pkgs.bat

    pkgs.veracrypt
    pkgs.keepassxc

    pkgs.atuin
    pkgs.dmenu
    pkgs.starship
    pkgs.scrot
    pkgs.gh
    pkgs.xclip

    pkgs.ghostscript
    pkgs.imagemagick_light
  ];
}
