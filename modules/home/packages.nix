{
  inputs,
  pkgs,
  config,
  ...
}: let vencord-discord = (pkgs.discord.override {
  nss = pkgs.nss_latest; # Open links with firefox
  withOpenASAR = true; # Faster startup, more privacy, some mods
  # withVencord = true; # Cool client mod
}); in {
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
    vencord-discord
    pkgs.pcmanfm

    pkgs.ytmdesktop

    pkgs.obs-studio

    pkgs.gromit-mpx

    pkgs.fd
    pkgs.eza
    pkgs.ripgrep
    pkgs.bat
    pkgs.broot

    pkgs.veracrypt
    pkgs.keepassxc

    pkgs.atuin
    pkgs.dmenu
    pkgs.starship
    pkgs.scrot
    pkgs.gh
    pkgs.xclip
  ];
}

# Hello. I'm using Nix and trying to use vencord, This is my package:
# ```nix
# let vencord-discord = (pkgs.discord.override {
#   nss = pkgs.nss_latest; # Open links with firefox
#   withOpenASAR = true; # Faster startup, more privacy, some mods
#   # withVencord = true; # Cool client mod
# });
# ```
# No matter what I do, if I disable/enable OpenAsar, leave the default nss version etc. vencord gets stuck at the second discord screen and doesn't go any further.
