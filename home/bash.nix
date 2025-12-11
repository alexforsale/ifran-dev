{
  pkgs,
  ...
} : {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = [ "ignoreboth" ];
    historyFileSize = 2000000;
    historyFile = "/home/alexforsale/.bash_history";
    historyIgnore = [
      "ls" "ll" "cd" "ls -lisah" "pwd" "clear" "history" "exit"
    ];
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
    };
    shellOptions = [
      "histappend"
      "cmdhist"
      "checkwinsize"
    ];
    logoutExtra = ''
      if [ "$SHLVL" = 1 ]; then
	[ -x /usr/bin/clear ] && /usr/bin/clear
      fi
    '';
    initExtra = ''
    NORD_BG0="\[\033[48;2;46;52;64m\]" # Nord0: Darkest background
    NORD_BG1="\[\033[48;2;59;66;82m\]" # Nord1
    NORD_BG2="\[\033[48;2;67;76;100m\]" # Nord2
    NORD_BG3="\[\033[48;2;76;86;106m\]" # Nord3

    # Foreground/Text
    NORD_FG0="\[\033[38;2;216;222;233m\]" # Nord4: Lighter text
    NORD_FG1="\[\033[38;2;229;233;240m\]" # Nord5
    NORD_FG2="\[\033[38;2;236;239;244m\]" # Nord6: Lightest text

    # Accent colors
    NORD_BLUE="\[\033[38;2;94;129;172m\]" # Nord8
    NORD_CYAN="\[\033[38;2;129;161;193m\]" # Nord7
    NORD_GREEN="\[\033[38;2;143;188;139m\]" # Nord10
    NORD_YELLOW="\[\033[38;2;235;203;139m\]" # Nord9
    NORD_ORANGE="\[\033[38;2;214;160;110m\]" # Nord11
    NORD_RED="\[\033[38;2;191;97;106m\]" # Nord12
    NORD_MAGENTA="\[\033[38;2;180;142;173m\]" # Nord13
    NORD_PURPLE="\[\033[38;2;136;192;208m\]" # Nord14

    # Reset color
    NORD_RESET="\[\033[0m\]"

    case $(hostname) in
      "kenya")
        PS1="''${NORD_PURPLE}\u@\h''${NORD_RESET}:''${NORD_BLUE}\w''${NORD_RESET}\$ "
	;;
      "uganda")
        PS1="''${NORD_MAGENTA}\u@\h''${NORD_RESET}:''${NORD_GREEN}\w''${NORD_RESET}\$ "
	;;
	*)
        PS1="''${NORD_GREEN}\u@\h''${NORD_RESET}:''${NORD_BLUE}\w''${NORD_RESET}\$ "
	;;
    esac

    [[ "$(command -v zoxide)" ]] && eval "$(zoxide init --cmd cd bash)"
    [[ -f ~/.cargo/env ]] && source ~/.cargo/env
    '';
  };
  home.packages = with pkgs; [
    zoxide
  ];
}
