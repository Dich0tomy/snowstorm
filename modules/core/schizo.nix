# Lol sioodmy you a madman fr
{
  config,
  pkgs,
  lib,
  ...
}:
# this makes our system more secure
# note that it might break some stuff, eg webcam

{
  programs.ssh.startAgent = true;

  security = {
    protectKernelImage = true;
    lockKernelModules = false;
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };
  };
}
