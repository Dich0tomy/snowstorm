{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/Data";
    fsType = "ntfs";
  };

}
