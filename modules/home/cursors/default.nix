{ self, pkgs, ...
}: let lyrap-cursors = self.packages.${pkgs.system}.lyrap-cursors; in {

  home.file.".icons/default".source = "${lyrap-cursors}/share/icons/LyraP-Cursors";

  # home.pointerCursor = {
  #   package = self.packages.${pkgs.system}.lyrap-cursors;
  #   name = "LyraP Cursors";
  #   gtk.enable = true;
  #   x11.enable = true;
  # };
}
