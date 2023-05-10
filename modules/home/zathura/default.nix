{...}: {
  programs.zathura = {
    enable = true;
    options = {
      font = "Iosevka B4mbus 15";

      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      smooth-scroll = true;
      zoom-min = "10";
      guioptions = "none";
    };
  };
}
