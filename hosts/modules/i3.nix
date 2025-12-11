{
  pkgs,
  ...
}: {
  imports = [
    ./desktop.nix
  ];
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3blocks
        i3lock-fancy-rapid
      ];
    };
  };
  services.displayManager.defaultSession = "none+i3";
  security.pam.services = {
    i3lock-fancy-rapid.enable = true;
  };
}
