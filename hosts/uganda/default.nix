{
  pkgs,
  ...
} : {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../modules/desktop.nix
    ../modules/zerotier.nix
    ../modules/i3.nix
    ../modules/thunar.nix
    ../modules/libinput.nix
    ../modules/bluetooth.nix
    ../modules/nord.nix
    ../../home
  ];
  networking.hostName = "uganda";
  xdg.portal.extraPortals = [
    pkgs.kdePackages.xdg-desktop-portal-kde
    pkgs.xdg-desktop-portal-gtk
  ];
  fonts = {
    fontDir.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
    packages = with pkgs; [
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-sans
      nerd-fonts.ubuntu-mono
      nerd-fonts.iosevka
      nerd-fonts.symbols-only
    ];
  };
  stylix = {
    enable = true;
    cursor = {
      name = "Nordzy-catppuccin-frappe-dark";
      package = pkgs.nordzy-cursor-theme;
      size = 32;
    };
    icons = {
      enable = true;
      dark = "Nordzy-purple-dark";
      light = "Nordzy-purple";
      package = pkgs.nordzy-icon-theme;
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
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters = {
      gtk = {
        enable = true;
        theme = {
          name = "Nordic";
          package = pkgs.nordic;
        };
        iconTheme = {
          name = "Nordzy-purple-dark";
          package = pkgs.nordzy-icon-theme;
        };
        cursorTheme = {
          name = "Nordzy-catppuccin-frappe-dark";
          package = pkgs.nordzy-cursor-theme;
          size = 32;
        };
      };
    };
  };
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "lock";
  };
  services.auto-cpufreq.enable = true;
}
