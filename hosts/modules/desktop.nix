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
    gnome-software
    vdhcoapp
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.id_ID
    hyphen
    hyphenDicts.en_US
  ];
}
