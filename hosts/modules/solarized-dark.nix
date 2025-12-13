{
  pkgs,
  ...
} : {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
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
      url = "https://getwallpapers.com/wallpaper/full/c/3/2/574046.jpg";
      hash = "sha256-0gGOY2Mje1r1MPxLAZT2iQNfxq4EFRQfHG1fB9nuzCE=";
    };
  };
}
