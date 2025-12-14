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

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux = {
        enableShellIntegration = true;
      };
    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };

    programs.git = {
      enable = true;
      settings = {
        core = {
          editor = "nvim";
        };
        commit = {
          gpgsign = true;
        };
        color = {
          ui = true;
        };
        credential = {
          helper = "!pass-git-helper $@";
        };
        difftool = {
          prompt = true;
        };
        diff = {
          tool = "nvimdiff";
        };
        difttool."nvimdiff" = {
          cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };
        merge = {
          tool = "nvim";
        };
        mergetool."nvim" = {
          cmd = "nvim -d -c \"wincmd l\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
          keepBackup = false;
        };
        init = {
          defaultBranch = "main";
        };
        pack = {
          windowMemory = "2g";
          packSizeLimit = "1g";
        };
        pull = {
          rebase = true;
        };
        push = {
          default = "simple";
        };
        tag = {
          gpgSign = true;
        };
        user = {
          name = "alexforsale";
          email = "alexforsale@yahoo.com";
          signingkey = "CDBB05B232787FCC";
        };
      };
    };

    programs.mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            uosc
            sponsorblock
            youtube-upnext
            youtube-chat
            thumbnail
            mpv-notify-send
            mpv-cheatsheet
            mpris
            autosubsync-mpv
            autosub
          ];

          mpv = pkgs.mpv-unwrapped.override {
            waylandSupport = true;
            ffmpeg = pkgs.ffmpeg-full;
          };
        }
      );

    };

    home.sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };

    home.packages = with pkgs; [
      pass-git-helper
    ];

    services.syncthing = {
      enable = true;
    };

  };
}
