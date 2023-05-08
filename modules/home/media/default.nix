{
  config,
  pkgs,
  ...
}: {
  home.packages = [
   pkgs.vlc
   pkgs.playerctl
   pkgs.pavucontrol
   pkgs.imv
   pkgs.pulsemixer
  ];

  programs = {
  };
}
