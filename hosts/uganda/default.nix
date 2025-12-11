{
  pkgs,
  ...
} : {
  imports = [
    ./hardware-configuration.nix
    ../common
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
  stylix.targets = {
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
}
