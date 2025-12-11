{
  ...
} : {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 53 9993 1716 22000 ];
    allowedUDPPorts = [ 22 53 9993 1716 22000 ];
  };

  networking.nftables = {
    enable = true;
  };

}
