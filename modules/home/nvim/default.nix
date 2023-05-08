{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = ./config;

  packages = [
    pkgs.sumneko-lua-language-server
  ];
}
