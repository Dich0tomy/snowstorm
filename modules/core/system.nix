{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    dbus = {
      packages = [
        pkgs.dconf
        pkgs.gcr
        pkgs.udisks2
      ];

      enable = true;
    };

    udev.packages = [
      pkgs.gnome.gnome-settings-daemon
      pkgs.android-udev-rules
      pkgs.ledger-udev-rules
    ];

    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

    udisks2.enable = true;

    xserver = {
      enable = true;

      windowManager.awesome.enable = true;

      displayManager = {
        defaultSession = "none+awesome";

        sddm.enable = true;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
  };

  # compress half of the ram to use as swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  environment = {
    systemPackages = [
      pkgs.neovim
      pkgs.ntfs3g
      pkgs.wget
      pkgs.feh
      pkgs.zip
      pkgs.unzip
    ];

    variables = {
      EDITOR = "nvim";
      BROWSER = "brave";
    };
  };

  time = {
    timeZone = "Europe/Warsaw";
    hardwareClockInLocalTime = true;
  };

  i18n = let
    defaultLocale = "en_US.UTF-8";
    pl = "pl_PL.UTF-8";
  in {
    inherit defaultLocale;
    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;
      LC_TIME = defaultLocale;

      LC_ADDRESS = pl;
      LC_IDENTIFICATION = pl;
      LC_MEASUREMENT = pl;
      LC_MONETARY = pl;
      LC_NAME = pl;
      LC_NUMERIC = pl;
      LC_PAPER = pl;
      LC_TELEPHONE = pl;
    };
  };

  programs.dconf.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      openssl
      curl
      glib
      util-linux
      glibc
      icu
      libunwind
      libuuid
      zlib
      libsecret
      # graphical
      freetype
      libglvnd
      libnotify
      SDL2
      vulkan-loader
      gdk-pixbuf
      xorg.libX11
    ];
  };

  systemd = let
    extraConfig = ''
      DefaultTimeoutStopSec=15s
    '';
  in {
    inherit extraConfig;
    user = {inherit extraConfig;};
    services."getty@tty1".enable = false;
    services."autovt@tty1".enable = false;
    services."getty@tty7".enable = false;
    services."autovt@tty7".enable = false;
    # Systemd OOMd
    # Fedora enables these options by default. See the 10-oomd-* files here:
    # https://src.fedoraproject.org/rpms/systemd/tree/acb90c49c42276b06375a66c73673ac3510255
    oomd = {
      enableRootSlice = true;
      enableUserServices = true;
    };
  };
}
