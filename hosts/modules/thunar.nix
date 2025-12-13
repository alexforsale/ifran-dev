{
  pkgs,
  ...
} : {
  programs.thunar = {
    enable = true;
    plugins = 
      with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
  };

  programs.xfconf.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
