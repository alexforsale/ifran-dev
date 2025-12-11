{
  ...
} : {
  programs.alacritty = {
    enable = true;
    theme = "nord";
    settings = {
      general.live_config_reload = true;
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding.x = 25;
        padding.y = 25;
        blur = true;
        decorations_theme_variant = "Dark";
      };
      bell = {
        animation = "EaseOutCirc";
        duration = 1;
      };
      mouse = {
        hide_when_typing = true;
      };
      selection.save_to_clipboard = true;
      env.TERM = "xterm-256color";
    };
  };
}
