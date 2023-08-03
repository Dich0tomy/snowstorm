{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}: {
  /* config.nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
  ]; */

  config.home.stateVersion = "23.05";

  config.home.extraOutputsToInstall = [
    "doc"
    "devdoc"
  ];

  imports = [
    inputs.nix-index-db.hmModules.nix-index

    ./packages.nix

    ./rnnoise
    ./media

    ./gtk
    ./cursors

    ./git
    ./awesome
    ./kitty
    ./nvim
    ./shell
    ./zathura
    ./tmux
  ];
}
