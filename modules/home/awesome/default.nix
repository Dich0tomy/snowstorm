{
  config,
  pkgs,
  ...
}: {
  services.picom.enable = true;

  xsession.windowManager.awesome.enable = true;

  xdg.configFile."awesome".source = ./awesome;
}
