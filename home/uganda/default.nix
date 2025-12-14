{
  ...
} : {
  imports = [
    ../desktop.nix
    ../bash.nix
    ../nvim.nix
    ../tmux.nix
    ../emacs.nix
    ../i3.nix
    ../alacritty.nix
  ];
  xsession.windowManager.i3.config.terminal = "alacritty";
  stylix.targets = {
    alacritty = {
      enable = true;
      fonts.enable = true;
      opacity.enable = true;
      colors.enable = true;
    };
    dunst = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
      opacity.enable = true;
    };
    emacs = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
      opacity.enable = true;
    };
    font-packages = {
      enable = true;
      fonts.enable = true;
    };
    fontconfig = {
      enable = true;
      fonts.enable = true;
    };
    fzf = {
      enable = true;
      colors.enable = true;
    };
    gtk = {
      enable = true;
      colors.enable = true;
      flatpakSupport.enable = true;
      fonts.enable = true;
    };
    i3 = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };
    mpv = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };
    rofi = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
      opacity.enable = true;
    };
    tmux = {
      enable = true;
      colors.enable = true;
      inputs.enable = true;
    };
    xresources = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };
  };
}
