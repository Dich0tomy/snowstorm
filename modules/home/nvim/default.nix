{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    extraPackages = [
      pkgs.gcc
      pkgs.ripgrep
      pkgs.fd
    ];
  };

  xdg.configFile."nvim".source = ./nvim;

  packages = [
    pkgs.sumneko-lua-language-server
  ];
}
