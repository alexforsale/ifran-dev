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

          general = {
            gaps_in = 5;
            gaps_out = "10, 20, 10, 20";
            float_gaps = 0;
            no_focus_fallback = false;
            resize_on_border = false;
            border_size = 2;
            allow_tearing = false;
            layout = "dwindle";
            snap = {
              enabled = true;
              window_gap = 10;
              monitor_gap = 10;
              border_overlap = false;
              respect_gaps = true;
            };
          };

          input = {
            kb_layout = "us";
            numlock_by_default = true;
          };

          device = {
            name = "casue-usb-kb";
            kb_options = "scrolllock:mod3";
            numlock_by_default = true;
          };

          binds = {
            workspace_back_and_forth = true;
            allow_workspace_cycles = true;
            scroll_event_delay = 0;
          };

          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };

          cursor = {
            inactive_timeout = 2;
            hide_on_key_press = true;
          };

          xwayland = {
            enabled = true;
          };

          decoration = {
            rounding = 5;
            rounding_power = 2.0;
            active_opacity = 0.95;
            inactive_opacity = 0.85;
            fullscreen_opacity = 1.0;
            dim_modal = true;
            dim_inactive = true;
            dim_strength = 0.4;
            dim_special = 0.3;
            dim_around = 0.4;
            border_part_of_window = true;

            blur = {
              enabled = true;
              size = 8;
              passes = 1;
              ignore_opacity = true;
              new_optimizations = true;
              xray = false;
              noise = 0.0117;
              contrast = 0.8916;
              brightness = 0.8172;
              vibrancy = 0.1696;
              vibrancy_darkness = 0.0;
              special = false;
              popups = false;
              popups_ignorealpha = 0.2;
              input_methods = false;
              input_methods_ignorealpha = 0.2;
            };
            
            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
              sharp = false;
              ignore_window = true;
              offset = "0.0 0.0";
              scale = 1.0;
            };
          };

          bind = [
            "$mainMod, return, exec, alacritty"
            "$mainMod Shift, return, exec, alacritty -e tmux new -A -s main"
            "$mainMod, d, exec, wofi --show drun"
            "$mainMod, v, exec, wofi pwvucontrol"
            "$mainMod, e, exec, thunar"
            "$mainMod, q, exec, wofi-power-menu"
            "$mainMod, Comma, exec, wofi-emoji"
            "$mainMod Shift, t, exec, ${./scripts/hypr-tesseract.sh}"
            "$mainMod Alt, t, exec, thunderbird"
            "$mainMod Alt, f, exec, firefox"
            "$mainMod Alt, n, exec, emacsclient -c -a 'emacs'"
            "$mainMod Alt, q, exec, hyprlock"
            "$mainMod Alt, p, exec, wofi-pass"
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
            "$mainMod Shift, H, movewindow, l"
            "$mainMod Shift, J, movewindow, d"
            "$mainMod Shift, K, movewindow, u"
            "$mainMod Shift, L, movewindow, r"
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

            "$mainMod Alt, H, focusmonitor, l"
            "$mainMod Alt, J, focusmonitor, d"
            "$mainMod Alt, K, focusmonitor, u"
            "$mainMod Alt, L, focusmonitor, r"

            "$mainMod Control, H, movecurrentworkspacetomonitor, l"
            "$mainMod Control, J, movecurrentworkspacetomonitor, d"
            "$mainMod Control, K, movecurrentworkspacetomonitor, u"
            "$mainMod Control, L, movecurrentworkspacetomonitor, r"

            ", Print, exec, bash ${./scripts/hypr-grimshot.sh} active"
            "Control, Print, exec, bash ${./scripts/hypr-grimshot.sh} screen"
            "Alt, Print, exec, bash ${./scripts/hypr-grimshot.sh} area"
            "$mainMod SHIFT, s, exec, bash ${./scripts/hypr-grimshot.sh} area"

            "$mainMod, Print, exec, bash ${./scripts/hypr-screen-record.sh}"

            "$mainMod Control, mouse_down, exec, ${./scripts/hypr-zoom.sh} down"
            "$mainMod Control, mouse_up, exec, ${./scripts/hypr-zoom.sh} up"
          ];
          bindl = [
            ",switch:Lid Switch,exec,hyprlock"
          ];
          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];
          binde = [
            "$mainMod Control, H, resizeactive, -10 0"
            "$mainMod Control, J, resizeactive, 0 10"
            "$mainMod Control, K, resizeactive, 0 -10"
            "$mainMod Control, L, resizeactive, 10"

            "$mainMod Control, left, resizeactive, -10 0"
            "$mainMod Control, down, resizeactive, 0 10"
            "$mainMod Control, up, resizeactive, 0 -10"
            "$mainMod Control, right, resizeactive, 10"

            "$mainMod, underscore, splitratio, -0.1"
            "$mainMod, Equal, splitratio, 0.1"
            "$mainMod, Semicolon, splitratio, -0.1"
            "$mainMod, Apostrophe, splitratio, 0.1"

            "$mainMod Control, equal, exec, ${./scripts/hypr-zoom.sh} down"
            "$mainMod Control, minus, exec, ${./scripts/hypr-zoom.sh} up"
            "$mainMod Control, KP_ADD, exec, ${./scripts/hypr-zoom.sh} down"
            "$mainMod Control, KP_SUBTRACT, exec, ${./scripts/hypr-zoom.sh} up"
          ];
          bindel = [
            "$mainMod, F11, exec, playerctl play-pause"
            "$mainMod, F12, exec, playerctl next"
            "$mainMod, F10, exec, playerctl previous"
          ];
          exec-once = [
            "systemctl --user start hyprpolkitagent"
            "wl-paste --type text --watch cliphist store &"
            "wl-paste --type image --watch cliphist store &"
          ];
        };
        extraConfig = ''
         bind = $mainMod, bracketleft, changegroupactive, b
         bind = $mainMod, bracketright, changegroupactive, f
         
         bind = $mainMod, T, togglegroup
         
         bind = $mainMod, G, submap, group
         submap = group
         bind = , T, togglegroup
         bind = $mainMod Control, F, changegroupactive, f
         bind = $mainMod Control, B, changegroupactive, b
         
         bind = $mainMod, bracketleft, changegroupactive, b
         bind = $mainMod, bracketright, changegroupactive, f
         # bind = $mainMod Alt, L, lockactivegroup
         bind = $mainMod, G, lockgroups, toggle
         bind = $mainMod Alt, G, lockactivegroup, toggle
         
         bind = $mainMod Shift, left, moveintogroup, l
         bind = $mainMod Shift, right, moveintogroup, r
         bind = $mainMod Shift, up, moveintogroup, u
         bind = $mainMod Shift, down, moveintogroup, d
         
         bind = $mainMod Shift, H, moveintogroup, l
         bind = $mainMod Shift, L, moveintogroup, r
         bind = $mainMod Shift, K, moveintogroup, u
         bind = $mainMod Shift, J, moveintogroup, d
         
         bind = $mainMod Control, left, moveoutofgroup, l
         bind = $mainMod Control, right, moveoutofgroup, r
         bind = $mainMod Control, up, moveoutofgroup, u
         bind = $mainMod Control, down, moveoutofgroup, d
         
         bind = $mainMod Control, H, moveoutofgroup, l
         bind = $mainMod Control, L, moveoutofgroup, r
         bind = $mainMod Control, K, moveoutofgroup, u
         bind = $mainMod Control, J, moveoutofgroup, d
         
         bind = $mainMod, left, movefocus, l
         bind = $mainMod, right, movefocus, r
         bind = $mainMod, up, movefocus, u
         bind = $mainMod, down, movefocus, d
         
         bind = $mainMod, H, movefocus, l
         bind = $mainMod, L, movefocus, r
         bind = $mainMod, K, movefocus, u
         bind = $mainMod, J, movefocus, d
         
         bind = , escape, submap, reset
         bind = Control, G, submap, reset
         submap = reset
         
         bind = $mainMod Control, F, changegroupactive, f
         bind = $mainMod Control, B, changegroupactive, b 
        '';
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

  services.kdeconnect = {
    enable = true;
    indicator = true;
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
    settings = {
      border-size = 0;
      border-radius = 10;
      default-timeout = 2000;
      icon-location = "right";
    };
  };

  programs.ashell = {
    enable = true;
    systemd.enable = true;
    settings = {
      appearance = {
        style = "Gradient";
      };
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
          [
            "SystemInfo"
            "MediaPlayer"
            "Privacy"
            "Clock"
            "Settings"
          ]
          "Tray"
        ];
      };
      settings = {
        lock_cmd = "hyprlock &";
        remove_airplane_btn = true;
        audio_sinks_more_cmd = "pwvucontrol -t 3";
        audio_sources_more_cmd = "pwvucontrol -t 4";
        wifi_more_cmd = "nm-connection-editor";
      };
      workspaces = {
        visibility_mode = "MonitorSpecific";
      };
    };
  };

  xdg.configFile."wofi-power-menu" = {
    enable = true;
    target = "wofi-power-menu.toml";
    text = ''
      [wofi]
      extra_args = "--allow-markup --columns=1 --hide-scroll --location 3 --lines 4 --xoffset=-100"
      [menu.suspend]
      enabled = "false"
      [menu.hibernate]
      enabled = "false"
      [menu.logout]
      cmd = "hyprctl dispatch exit"
    '';
  };

  programs.wofi = {
    enable = true;
    settings = {
      allow-markup = true;
      insensitive = true;
      term = "alacritty";
      key_up="Up,Ctrl-p,Ctrl-k";
      key_down="Down,Ctrl-n,Ctrl-j";
      key_left="Left,Ctrl-b";
      key_right="Right,Ctrl-f";
      key_pgup="Page_Up,Alt-v";
      key_pgdn="Page_Down,Ctrl-f";
      key_exit="Escape,Ctrl-g,Ctrl-bracketleft";
      matching="fuzzy";
      allow_image=true;
      allow_markup=true;
      gtk_dark=true;
      dynamic_lines=false;
      close_on_focus_loss=true;
      single_click=true;
      height="30%";
      width="30%";
      columns=1;
      prompt="PROMPT";
    };
  };

  services.cliphist = {
    enable = true;
  };

  home.packages = with pkgs; [
    thunderbird
    hyprland-qt-support
    hyprsysteminfo
    hyprpicker
    hyprpolkitagent
    pwvucontrol
    wofi-pass
    wofi-emoji
    wofi-power-menu
    wl-clipboard
    cliphist
    tesseract4
    grim
    slurp
    playerctl
    sway-contrib.grimshot
    wf-recorder
    jq
    bc
    libnotify
    quodlibet-full
    networkmanagerapplet
  ];
}
