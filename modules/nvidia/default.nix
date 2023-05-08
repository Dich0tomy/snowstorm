{
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = [ "nvidia" ];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = [
   pkgs.vulkan-loader
   pkgs.vulkan-validation-layers
   pkgs.vulkan-tools
  ];

  hardware = {
    nvidia = {
      open = true;
      powerManagement.enable = true;
      modesetting.enable = true;
    };
    opengl.extraPackages = [ pkgs.nvidia-vaapi-driver ];
  };
}
