{
  pkgs,
  ...
} : {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../modules/zerotier.nix
    ../modules/bluetooth.nix
    ../modules/nord.nix
    ../../home
  ];
  networking.hostName = "kenya";
  systemd.tmpfiles.rules = 
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ];
  };

  programs.hyprland.enable = true;

  security.pam.services = {
    hyprlock.enable = true;
  };
  fonts = {
    fontDir.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
    packages = with pkgs; [
      material-symbols
      rubik
      nerd-fonts.iosevka
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11,*";
  };

  stylix = {
    enable = true;
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    icons = {
      enable = true;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
      package = pkgs.papirus-nord;
    };
    targets = {
      console = {
        enable = true;
        colors.enable = true;
      };
      font-packages = {
        enable = true;
        fonts.enable = true;
      };
      fontconfig = {
        enable = true;
        fonts.enable = true;
      };
      grub = {
        enable = true;
      };
      gtk = {
        enable = true;
      };
      lightdm = {
        enable = true;
        image.enable = true;
        useWallpaper = false;
      };
    };
  };
}
