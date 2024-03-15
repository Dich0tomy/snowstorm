{pkgs, ...}: let
  iosevka-b4mbus = pkgs.fetchzip {
    url = "https://github.com/B4mbus/snowstorm/releases/download/0.1.0/iosevka-b4mbus.zip";
    sha256 = "1vlfz4c5r5q7jadq8lxzzjv62rzsrmy4rmriqs4pjk4xbl37mhvk";
  };
  nerd-fonts-symbols-only = pkgs.fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/NerdFontsSymbolsOnly.zip";
    stripRoot = false;
    sha256 = "0p15sgg6i2aac8l35dh4zpa5cz6achxy76n6n1y6gd1dip0xplly";
  };
in {
  fonts = {
    fontDir.enable = true;

    packages = [
      nerd-fonts-symbols-only
      iosevka-b4mbus

      pkgs.maple-mono-NF
      pkgs.roboto
      pkgs.profont
      pkgs.spleen
      pkgs.jetbrains-mono

      # basic set of fonts
      pkgs.noto-fonts
      pkgs.corefonts
    ];
  };
}
