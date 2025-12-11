{
  pkgs,
  ...
}:
{
# TODO: hyprpaper
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        systemd = {
          enable = true;
          variables = [ "--all" ];
          enableXdgAutostart = true;
        };
        xwayland.enable = true;
        portalPackage = pkgs.xdg-desktop-portal-hyprland;
        settings = {
          "$mainMod" = "SUPER";

          bind = [
            "$mainMod, return, exec, alacritty"
            "$mainMod, d, exec, wofi --show drun"
            "$mainMod Alt, t, exec, thunderbird"
            "$mainMod Alt, f, exec, firefox"
            "$mainMod Alt, n, exec, emacsclient -c -a 'emacs'"
            "$mainMod Alt, q, exec, hyprlock"
            "$mainMod, C, exec, cliphist list | wofi -dmenu -p \"Clipboard:\" | cliphist decode | wl-copy"
            "$mainMod, F4, killactive"
            "Alt, F4, killactive"
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"
            "$mainMod, h, movefocus, l"
            "$mainMod, l, movefocus, r"
            "$mainMod, k, movefocus, u"
            "$mainMod, j, movefocus, d"
            "$mainMod, F, fullscreen, 0"
            "$mainMod Shift, F, fullscreen, 1"
            "$mainMod Control, F, fullscreenstate, -1 -1"
            "$mainMod, Space, togglefloating"
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"
            "$mainMod, TAB, workspace, previous"
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"
            "$mainMod SHIFT, TAB, movetoworkspace, previous"
          ];
        };
      };
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      "$font_family" = "Rubik Light";
      "$font_family_clock" = "Rubik Light";
      "$font_material_symbols" = "Material Symbols Rounded";

      label = [
        {
          position = "0, 240";
          halign = "center";
          valign = "center";

          text = "<span foreground='##D8DEE9'>Hi there,</span><span foreground='##8FBCBB'> <i>$DESC</i></span>";
          shadow_passes = 1;
          shadow_boost = 0.5;

          font_family = "$font_family";
        }
        {
          position = "0, 65";
          halign = "center";
          valign = "bottom";

          text = "lock";
          font_family = "$font_material_symbols";
        }
        {
          position = "0, 300";
          halign = "center";
          valign = "center";

          text = "$TIME";
          shadow_passes = 1;
          shadow_boost = 0.5;
          font_family = "$font_family_clock";
        }
      ];
      input_field = [
        {
          position = "0, 20";
          halign = "center";
          valign = "center";

          size = "250, 50";
          dots_size = 0.1;
          dots_spacing = 0.3;
          outline_thickness = 2;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "pidof hyprlock || hyprlock";
        ignore_dbus_inhibit = false;
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 155;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.hyprsunset = {
    enable = true;
    settings = {
      max-gamma = 150;

      profile = [
        {
          time = "7:30";
          identity = true;
        }
        {
          time = "21:00";
          temperature = 5000;
          gamma = 0.8;
        }
      ];
    };
  };

  services.hyprpolkitagent.enable = true;

  services.mako = {
    enable = true;
  };

  programs.ashell = {
    enable = true;
    settings = {
      outputs = "Active";
      position = "Top";
      modules = {
        left = [
          "Workspaces"
        ];
        center = [
          "Window Title"
        ];
        right = [
          "Tray"
          [
            "SystemInfo"
            "MediaPlayer"
            "Privacy"
            "Settings"
            "Clock"
          ]
        ];
      };
    };
  };

  programs.wofi = {
    enable = true;
  };

  services.cliphist = {
    enable = true;
  };

  home.packages = with pkgs; [
    thunderbird
    hyprland-qt-support
    hyprsysteminfo
    hyprpicker
    wl-clipboard
    kdePackages.dolphin
  ];
}
