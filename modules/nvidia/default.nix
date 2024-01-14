{
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = [
    "nvidia"
    "nouveau"
  ];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # environment.systemPackages = with pkgs; [
  #   vulkan-loader
  #   vulkan-validation-layers
  #   vulkan-tools
  # ];

  hardware = {
    nvidia = {
      # open = true;
      # powerManagement.enable = true;

      nvidiaSettings = true;

      modesetting.enable = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    opengl = {
      enable = true;

      extraPackages = [
        pkgs.nvidia-vaapi-driver
        pkgs.xorg.xf86videonouveau
				pkgs.mesa.drivers
      ];
    };
  };
}
