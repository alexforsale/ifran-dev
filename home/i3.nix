{
  config,
  pkgs,
  lib,
  ...
}:
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = {
      modifier = "Mod4";
      floating.modifier = "Mod4";
      menu = "${pkgs.rofi}/bin/rofi -show drun";
      startup = [
        {
          command = "no-startup-id dbus-update-activation-environment --all";
          always = true;
          notification = false;
        }
        {
          command = "sleep 3 && volumeicon";
          always = true;
          notification = false;
        }
        {
          command = "flameshot";
          always = true;
        }
        {
          command = "blueman-applet";
          always = true;
        }
        {
          command = "nm-applet";
          always = true;
        }
        {
          command = "greenclip daemon";
          always = true;
        }
      ];
      gaps = {
        inner = 2;
        outer = 2;
        smartGaps = true;
      };
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        }
      ];
      workspaceAutoBackAndForth = true;
      keybindings = let 
        modifier = config.xsession.windowManager.i3.config.modifier; 
      in lib.mkOptionDefault {
        "${modifier}+Shift+S" = "exec flameshot gui";
        "${modifier}+v" = "exec pwvucontrol";
        "${modifier}+Mod1+f" = "exec firefox";
        "${modifier}+Mod1+p" = "exec rofi-pass";
        "${modifier}+Mod1+c" = "exec rofi -show calc -modi calc -no-show-match -no-sort -theme ${./scripts/i3-rofi-calc.rasi}";
        "${modifier}+Mod1+n" = "exec emacs";
        "${modifier}+Control+n" = "exec alacritty -e emacsclient -t -a emacs";
        "${modifier}+e" = "exec thunar";
        "${modifier}+Return" = "exec alacritty";
        "${modifier}+Shift+Return" = "exec alacritty -e tmux new -A -s main";
        "${modifier}+Shift+F4" = "kill";
        "${modifier}+c" = "exec rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}' -theme ${./scripts/i3-rofi-clipboard.rasi}";
        "${modifier}+Shift+w" = "exec rofi -show windowcd -theme ${./scripts/i3-rofi-window.rasi}";
        "${modifier}+w" = "exec rofi -show window -theme ${./scripts/i3-rofi-window.rasi}";
        "${modifier}+Mod1+s" = "exec screenkey";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        "${modifier}+Mod1+Tab" = "focus right";
        "${modifier}+Mod1+Shift+Tab" = "focus left";
        "${modifier}+Shift+h" = "focus left";
        "${modifier}+Shift+j" = "focus down";
        "${modifier}+Shift+k" = "focus up";
        "${modifier}+Shift+l" = "focus right";
        "${modifier}+Shift+Left" = "focus left";
        "${modifier}+Shift+Down" = "focus down";
        "${modifier}+Shift+Up" = "focus up";
        "${modifier}+Shift+Right" = "focus right";
        "${modifier}+Control+h" = "split h; exec notify-send 'horizontal split'";
        "${modifier}+Control+v" = "split v; exec notify-send 'vertical split'";
        "${modifier}+f" = "fullscreen toggle; exec notify-send 'fullscreen toggle'";
        "${modifier}+Control+s" = "layout stacking; exec notifiy-send 'layout stacking'";
        "${modifier}+Control+w" = "layout tabbed; exec notifiy-send 'layout tabbed'";
        "${modifier}+Control+e" = "layout toggle split; exec notifiy-send 'split toggle'";
        "${modifier}+space" = "focus mode_toggle; exec notify-send 'window focus toggle'";
        "${modifier}+Control+a" = "focus parent; exec notify-send 'focus parent container'";
        "${modifier}+Control+d" = "focus child; exec notify-send 'focus child container'";
        "${modifier}+Shift+minus" = "move scratchpad; exec notify-send 'moved to scratchpad'";
        "${modifier}+minus" = "scratchpad show; exec notify-send 'show scratchpad'";
        "${modifier}+bracketleft" = "workspace prev";
        "${modifier}+bracketright" = "workspace next";
        "${modifier}+Tab" = "workspace back_and_forth";
        "${modifier}+Shift+Tab" = "move container3 to workspace back_and_forth";
        "${modifier}+Shift+e" = "exec rofi -show p -modi p:rofi-power-menu -theme ${./scripts/i3-rofi-logout.rasi}";
        "${modifier}+q" = "exec rofi -show p -modi p:rofi-power-menu -theme ${./scripts/i3-rofi-logout.rasi}";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+F3" = "exec picom-trans -c +5";
        "${modifier}+F2" = "exec picom-trans -c -5";
        "${modifier}+Mod1+grave" = "exec dunstctl history-pop";
        "${modifier}+Shift+grave" = "exec dunstctl context";
        "${modifier}+Control+grave" = "exec dunstctl close";
        "${modifier}+grave" = "exec dunstctl action";
        "${modifier}+period" = "exec rofi -show emoji";
        #"XF86MonBrightnessUp" = "exec brightnessctl s +1%";
        #"XF86MonBrightnessDown" = "exec brightnessctl s 1%-";
        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+0" = "workspace 10";
        "${modifier}+Shift+1" = "move container to workspace 1";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5";
        "${modifier}+Shift+6" = "move container to workspace 6";
        "${modifier}+Shift+7" = "move container to workspace 7";
        "${modifier}+Shift+8" = "move container to workspace 8";
        "${modifier}+Shift+9" = "move container to workspace 9";
        "${modifier}+Shift+0" = "move container to workspace 10";
        #"XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ .01-";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${./scripts/dunst-volume.sh} -d 1";
        #"XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ .01+";
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${./scripts/dunst-volume.sh} -i 1";
        #"XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMute" = "exec --no-startup-id ${./scripts/dunst-volume.sh} -t";
        "XF86AudioMicMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "${modifier}+F7" = "exec --no-startup-id ${./scripts/dunst-volume.sh} -t";
        "${modifier}+F8" = "exec --no-startup-id ${./scripts/dunst-volume.sh} -d 1";
        "${modifier}+F9" = "exec --no-startup-id ${./scripts/dunst-volume.sh} -i 1";
        "${modifier}+F11" = "exec playerctl play-pause";
        "${modifier}+F12" = "exec playerctl next";
        "${modifier}+F10" = "exec playerctl previous";
        "Print" = "exec flameshot gui";
        "XF86MyComputer" = "exec firefox";
        "XF86Mail" = "exec thunderbird";
        "${modifier}+Mod1+t" = "exec thunderbird";
        "${modifier}+Mod1+m" = "exec io.github.quodlibet.QuodLibet";
        "${modifier}+Mod1+v" = "exec alacritty --class vim -e nvim";
        "XF86ScreenSaver" = "exec --no-startup-id i3lock-fancy-rapid 1 pixel";
        "${modifier}+Print" = "exec ${./scripts/i3-screencast.sh}";
        "XF86MonBrightnessUp" = "exec ${./scripts/dunst-brightness.sh} +1%";
        "XF86MonBrightnessDown" ="exec ${./scripts/dunst-brightness.sh} 1%-"; 
        "${modifier}+Shift+t" = "exec ${./scripts/ocr.sh}";
      };
      window = {
        commands = [
          {
            criteria = {
              class = ".*";
            };
            command = "border pixel 0";
          }
          {
            criteria = {
              instance = "(?i)pavucontrol";
            };
            command = "floating enable";
          }
          {
            criteria = {
              window_role= "pop-up";
            };
            command = "floating enable";
          }
          {
            criteria = {
              instance = "(?i)engrampa";
            };
            command = "floating enable";
          }
          {
            criteria = {
              window_role= "GtkFileChooserDialog";
            };
            command = "floating enable";
          }
          {
            criteria = {
              title = "(?i)alsamixer";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)qtconfig-qt4";
            };
            command = "floating enable";
          }
          {
            criteria = {
              title = "(?i)nmtui";
            };
            command = "floating enable";
          }
          {
            criteria = {
              window_role = "buddy_list";
            };
            command = "floating enable";
          }
          {
            criteria = {
              window_role = "conversation";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)blueman.*";
            };
            command = "floating enable; resize set 512 256";
          }
          {
            criteria = {
              class = "(?i)evolution-alarm.*";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)kooha";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)org.kde.polkit-.*";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "thunderbird";
              title = "status";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "thunderbird";
              title = "(.*)Reminders";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "thunderbird";
              title = "Write.*";
            };
            command = "floating enable; resize set 680 680";
          }
          {
            criteria = {
              class = "thunderbird";
              title = "Search.*";
            };
            command = "floating enable; resize set 600 680";
          }
          {
            criteria = {
              class = "thunderbird";
              title = "Confirm.*";
            };
            command = "floating enable; resize set 600 200";
          }
          {
            criteria = {
              class = "thunderbird";
              title = "Send.*";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "Msgcompose.*";
            };
            command = "floating enable; resize set 680 680";
          }
          {
            criteria = {
              class = "QtPass";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)zoom";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)file-roller";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)fileroller";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)ncmpcpp";
            };
            command = "floating enable; move scratchpad";
          }
          {
            criteria = {
              class = "(?i)khal";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)khal";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)htop";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)nmtui";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)vim";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)org.kde.kdeconnect.app";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "kdeconnect-indicator";
            };
            command = "floating enable; resize set 600 600";
          }
          {
            criteria = {
              title = "(?i)File Operation Progress";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)showmethekey-gtk";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)screenkey";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)bitwarden";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)authy.*";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)transmission.*";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)anydesk.*";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)lxappearance";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "(?i)virt-manager";
            };
            command = "floating enable; resize set 680 680; move position center";
          }
          {
            criteria = {
              class = "(?i)steam.*";
            };
            command = "floating enable; resize set 680 680; move position center";
          }
          {
            criteria = {
              class = ".*vokoscreenNG";
            };
            command = "floating enable; resize set 680 680; move position center; move scratchpad";
          }
          {
            criteria = {
              class = ".*easyeffects";
            };
            command = "floating enable; resize set 680 680; move position center";
          }
          {
            criteria = {
              class = ".*Cheese";
            };
            command = "floating enable; resize set 680 680; move position center";
          }
          {
            criteria = {
              class = ".*Cheese";
            };
            command = "floating enable; resize set 680 680; move position center";
          }
          {
            criteria = {
              class = ".*pwvucontrol";
            };
            command = "floating enable; resize set 680 680; move position center";
          }
          {
            criteria = {
              class = ".*(?i)anki";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "Gvim";
            };
            command = "floating disable";
          }
          {
            criteria = {
              class = "org.remmina.Remmina";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "org.remmina.Remmina";
              title = "Remmina Remote Desktop Client";
            };
            command = "floating disable";
          }
          {
            criteria = {
              class = ".*";
              title = "Open File.*";
            };
            command = "floating enable; resize set 600 600";
          }
          {
            criteria = {
              class = ".*";
              title = "Select Directories";
            };
            command = "floating enable; resize set 600 600";
          }
          {
            criteria = {
              class = "*.QuodLibet";
              title = "Plugins";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "firefox";
            };
            command = "floating disable";
          }
        ];
      };
      assigns = {
        "3" = [ { class = "firefox"; } ];
        "4" = [ { class = "thunderbird"; } ];
        "5" = [ { class = "(?i)thunar"; } ];
        "9" = [ { class = ".*Remmina"; } ];
      };
    };
    #extraConfig = ''
    #  '';
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        theme = "nord-dark";
        icons = "material-nf";
        blocks = [
          {
            block = "cpu";
            info_cpu = 20;
            warning_cpu = 50;
            critical_cpu = 90;
          }
          {
            block = "memory";
            format = " $icon $mem_used_percents.eng(w:1) ";
            format_alt = " $icon_swap $swap_free.eng(w:3,u:B,p:Mi)/$swap_total.eng(w:3,u:B,p:Mi)($swap_used_percents.eng(w:2)) ";
            interval = 30;
            warning_mem = 70;
            critical_mem = 90;
          }
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            alert_unit = "GB";
            interval = 30;
            warning = 20;
            alert = 10;
            format = " $icon root: $available.eng(w:2) ";
          }
          {
            block = "backlight";
            device = "acpi_video0";
            missing_format = "";
          }
          {
            block = "bluetooth";
            mac = "74:DE:2B:E9:27:13";
            disconnected_format = "";
            format = " $icon ";
          }
          {
            block = "sound";
            click = [
              {
                button = "left";
                cmd = "pwvucontrol";
              }
            ];
          }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
        ];
      };
    };
  };

  programs.rofi = {
    enable = true;
    cycle = true;
    #font = "Iosevka Nerd Font Mono 12";
    modes = [
      "window"
      "drun"
      "run"
      "ssh"
      "combi"
    ];
    pass = {
      enable = true;
      package = pkgs.rofi-pass;
    };
    terminal = "\${pkgs.alacritty}/bin/alacritty";
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
      pkgs.rofi-top
    ];
    extraConfig = {
      line-margin = "10";
      display-ssh = "";
      display-run = "";
      display-drun = "";
      display-window = "";
      display-combi = "";
      show-icons = true;
    };
  };

  services.picom = {
    enable = true;
    backend = "xrender";
    fade = true;
    shadow = true;
    shadowOpacity = 0.75;
    vSync = true;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.unclutter = {
    enable = true;
  };

  services.screen-locker = {
    enable = true;
    #inactiveInterval = 2;
    lockCmd = "i3lock-fancy-rapid 1 pixel";
  };

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "paper-icon-theme";
      package = pkgs.paper-icon-theme;
      size = "32x32";
    };
    settings = {
      global = {
        width = "(0, 300)";
        height = "(0, 200)";
        origin = "top-right";
        offset = "(10, 10)";
        scale = 0;
        notification_limit = "4";
        progress_bar = "true";
        progress_bar_height = 5;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 0;
        progress_bar_max_width = 444;
        progress_bar_corners = "all";
        progress_bar_corner_radius = 0;
        icon_corner_radius = 8;
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 0;
        padding = 8;
        horizontal_padding = 11;
        text_icon_padding = 0;
        frame_width = 0;
        frame_color = "#e5e9f0";
        gap_size = 1;
        #separator_color = "#e5e9f0";
        sort = "yes";
        #font = "JetBrainsMonoNL Nerd Font Mono 8";
        line_height = 0;
        markup = "full";
        format = "<span size='x-large' font_desc='Cantarell,JetBrainsMonoNL Nerd Font Mono 10' weight='bold' foreground='#2aa198'>%s</span>\n<span foreground='#f9f9f9'>%b</span>\n<span foreground='#859900' font_style='italic' font_stretch='condensed'>%a</span>";
        alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = "true";
        hide_duplicate_count = "true";
        show_indicators = "yes";
        sticky_history = "yes";
        history_length = 20;
        always_run_script = "true";
        title = "Dunst";
        class = "Dunst";
        corner_radius = "10";
        corners = "all";
        ignore_dbusclose = "false";
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_current";
      };
      urgency_low = {
        #background = "#3b4252";
        #foreground = "#4c566a";
        default_icon = "dialog-information";
      };
      urgency_normal = {
        #background = "#434c5e";
        #foreground = "#e5e9f0";
        override_pause_level = 30;
        default_icon = "dialog-information";
      };
      urgency_critical = {
        #background = "#bf616a";
        #foreground = "#eceff4";
        default_icon = "dialog-warning";
      };
      transient_history_ignore = {
        match_transient = "yes";
        history_ignore = "yes";
      };
      fullscreen_show_critical = {
        msg_urgency = "critical";
        fullscreen = "show";
      };
    };
  };

  gtk = {
    enable = true;
    #iconTheme.name = "Papirus-Dark";
    #iconTheme.package = pkgs.papirus-nord;
    #cursorTheme.name = "Bibata-Modern-Ice";
    #cursorTheme.package = pkgs.bibata-cursors;
  };

  home.packages = with pkgs; [
    font-awesome
    pwvucontrol
    playerctl
    flameshot
    volumeicon
    brightnessctl
    networkmanagerapplet
    haskellPackages.greenclip
    screenkey
    libnotify
    rofi-power-menu
    paper-icon-theme
    xorg.xprop
    cheese
    xorg.xev
    thunderbird
    xclip
    ffmpeg_7-full
    libcanberra-gtk3
    pamixer
    pinentry-qt
    tesseract4
    maim
  ];
}
