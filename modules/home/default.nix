{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}: {
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
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
    ./neovim
    ./shell
    ./zathura
    ./tmux
  ];
}
