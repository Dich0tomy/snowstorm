{
  pkgs,
  ...
}: let
  iosevka-b4mbus = pkgs.fetchzip {
    url = "https://github.com/B4mbus/snowstorm/releases/download/0.1.0/iosevka-b4mbus.zip";
    sha256 = "1vlfz4c5r5q7jadq8lxzzjv62rzsrmy4rmriqs4pjk4xbl37mhvk";
  };
in {
  fonts = {
    fontDir.enable = true;
    fonts = [
      pkgs.maple-mono-NF
      iosevka-b4mbus
    ];
  };
}
