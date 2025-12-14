{
  pkgs,
  ...
} : {
  services.udisks2 = {
    enable = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  programs.dconf.enable = true;
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
  };
  security.rtkit.enable = true;
  programs.firefox.enable = true;
  programs.firefox.nativeMessagingHosts.packages = [
    pkgs.passff-host
  ];
  environment.systemPackages = with pkgs; [
    discord
    gnome-software
    gimp-with-plugins
    vdhcoapp
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.id_ID
    hyphen
    spotify
    hyphenDicts.en_US
    zathura
    telegram-desktop
    transmission_4-gtk
    wineWowPackages.stable
  ];
  services.deluge = {
    enable = true;
    web.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
