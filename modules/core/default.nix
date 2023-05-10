{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./schizo.nix
    ./nix.nix
    ./users.nix
    ./openssh.nix
    ./blocker.nix
    ./fonts.nix
    ./filesystem.nix
  ];
}
