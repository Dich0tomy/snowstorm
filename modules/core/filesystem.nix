{ ... }: {
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/Data";
    fsType = "ntfs";
  };
}
