{
  pkgs,
  lib,
  ...
}: {
  boot = {
    tmp.cleanOnBoot = true;

    kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;

    loader = {
      systemd-boot = {
        enable = false;
        configurationLimit = 5;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;

        device = "nodev";

        theme = null;
        backgroundColor = null;
        splashImage = null;
      };
    };
  };
}
