{
  self,
  pkgs,
  ...
}: {
  home.pointerCursor = {
    package = self.packages.${pkgs.system}.lyrap-cursors;
    name = "LyraP Cursors";
    gtk.enable = true;
    x11.enable = true;
  };
}
