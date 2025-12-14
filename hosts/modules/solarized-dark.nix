{
  config,
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
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };
    image = pkgs.fetchurl {
      url = "https://r4.wallpaperflare.com/wallpaper/474/140/1011/stars-sea-clouds-night-wallpaper-7bede9caa0ccfc6d8a1eb0759c9972b0.jpg";
      hash = "sha256-ugnjfKCIpyH0enWB5l52j+1pWG1FwX8X5BeRh68NRuE=";
    };
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [ config.stylix.fonts.monospace.name ];
    sansSerif = [ config.stylix.fonts.sansSerif.name ];
    serif = [ config.stylix.fonts.serif.name ];
  };
}
