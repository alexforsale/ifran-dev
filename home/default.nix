{
  user,
  hostName,
  ...
} : {
  home-manager.users.${user} = {
    inputs, output, lib, config, pkgs, ...
  }: {
    imports = [
      ./${hostName}
    ];
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.self.overlays.additions
        inputs.self.overlays.modifications
        inputs.self.overlays.unstable-packages
      ];
    };
    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";
    home.stateVersion = "25.11";
};
}
