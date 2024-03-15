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
    ./networking.nix
    ./fonts.nix
  ];
}
