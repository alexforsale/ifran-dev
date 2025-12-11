{
  pkgs,
  ...
} : {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";
    fonts = {
      sizes = {
        terminal = 10;
        popups = 10;
        applications = 10;
        desktop = 10;
      };
      monospace = {
        package = pkgs.nerd-fonts.ubuntu-mono;
        name = "UbuntuMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    image = pkgs.fetchurl {
      url = "https://getwallpapers.com/wallpaper/full/4/e/6/674005.jpg";
      hash = "sha256-JVuaF2TEwEbDJGBooMAn8gWH4gzNKh2jdraVqPydAF4=";
    };
  };
}
