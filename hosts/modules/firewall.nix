{
  ...
} : {
  networking.firewall = rec {
    enable = true;
    allowedTCPPorts = [ 22 53 9993 22000 21027 57621 5353 8384 ];
    allowedUDPPorts = allowedTCPPorts;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  networking.nftables = {
    enable = true;
  };
}
