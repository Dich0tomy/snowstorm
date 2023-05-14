{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}: {
  config.home.stateVersion = "22.11";

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
