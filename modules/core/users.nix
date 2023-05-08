{
  config,
  pkgs,
  ...
}: {
  users.users.b4mbus = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "systemd-journal"
      "audio"
      "plugdev"
      "video"
      "input"
      "lp"
      "networkmanager"
      "power"
      "nix"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvkKM0pCOfJOuTJo8EUOWy6ckl1Gffkus3RHf1D4LSo danielzaradny@gmail.com"
    ];
  };
}
