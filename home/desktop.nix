{
  config,
  pkgs,
  ...
} : {

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/Media/Music";
      videos = "${config.home.homeDirectory}/Media/Videos";
      pictures = "${config.home.homeDirectory}/Media/Pictures";
      templates = "${config.home.homeDirectory}/Templates";
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      desktop = "${config.home.homeDirectory}/Desktop";
      publicShare = "${config.home.homeDirectory}/Public";
      extraConfig = {
        XDG_SCREENSHOT_DIR = "${config.home.homeDirectory}/Public";
      };
    };
    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    remmina
    libnotify
    libnotify
    networkmanagerapplet
    playerctl
    quodlibet-full
    tesseract4
    ffmpeg_7-full
    thunderbird
    pwvucontrol
  ];

}
