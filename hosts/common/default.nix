{
  user,
  fullName,
  pkgs,
  ...
}: {
  imports = [
    ../modules/firewall.nix
  ];
  time.timeZone = "Asia/Jakarta";
  networking.networkmanager.enable = true;
  system.stateVersion = "25.11";
  services.openssh.enable = true;
  nixpkgs.config.allowUnfree = true;

  users.users.${user} = {
    isNormalUser = true;
    description = "${fullName}";
    # hashedPasswordFile = config.sops.secrets.alexforsale_passwd.path;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "lp" ];
    packages = with pkgs; [
      tree
    ];
    openssh = {
      authorizedKeys = {
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBCLH0bm4WIIGdhRgq89lpah+BCDtEv2lCeiGmyOIJpR alexforsale@yahoo.com"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    vim
    pinentry-curses
    git
    pciutils
    htop
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.logrotate = {
    enable = true;
  };

  programs.nix-ld.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = "*";
      };
    };
  };
}
