{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    extraLuaPackages = p: [p.luarocks p.magick];

    extraPackages = [
      pkgs.gcc
      pkgs.ripgrep
      pkgs.fd
    ];
  };

  xdg.configFile."nvim".source = ./nvim;

  home.packages = [
    pkgs.ast-grep
    pkgs.luarocks
    pkgs.imagemagick_light
    pkgs.luajitPackages.magick
    pkgs.sumneko-lua-language-server
  ];
}
