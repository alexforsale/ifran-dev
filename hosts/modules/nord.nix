{
  config,
  pkgs,
  ...
} : {
  stylix = {
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
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };
    image = pkgs.fetchurl {
      url = "https://r4.wallpaperflare.com/wallpaper/976/74/465/multiple-display-mountains-snow-nature-wallpaper-c1b4ba2a902ec5b27032d3c4aefe604d.jpg";
      hash = "sha256-+zlCkbmA6GwJStrL1+BP08GezbhDB07TTYBgu86xWOw=";
    };
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [ config.stylix.fonts.monospace.name ];
    sansSerif = [ config.stylix.fonts.sansSerif.name ];
    serif = [ config.stylix.fonts.serif.name ];
  };
}
