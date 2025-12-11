{ ... }:
{
  nixpkgs = {
    config = {
      allowUnfreePredicate = (_: true);
    };
  };

  # sops.secrets.zerotierone_network = {
  #   path = "/run/secrets/zerotierone_network";
  #   owner = "root";
  #   mode = "0644";
  # };

  services.zerotierone = {
    enable = true;
  };

  # systemd.services."zerotier-join" = {
  #   description = "Join ZeroTier network with secret network ID";
  #   after = [ "zerotierone.service" ];
  #   wants = [ "zerotierone.service" ];
  #   serviceConfig.Type = "oneshot";

  #   script = ''
  #     zerotier-cli join "$(cat /run/secrets/zerotierone_network)"
  #     '';
  # };
}
