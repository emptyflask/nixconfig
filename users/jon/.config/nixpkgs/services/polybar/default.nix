{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in

with pkgs;
{
  services.polybar = {
    enable = true;
    package = unstable.polybar.override {
      alsaSupport = true;
      githubSupport = true;
      mpdSupport = true;
    };
    config = {
      "colors" = {
        background     = "#282828";
        background-alt = "#1d2021";
        foreground     = "#ebdbb2";
        foreground-alt = "#a89984";

        primary        = "#fe8019";
        secondary      = "#b16286";
        alert          = "#fb4934";

        fg        = "#f9f7dd";
        bg        = "#cc282828";
        lightGray = "#888888";
        darkGray  = "#474747";
        red       = "#ff5a5f";
        green     = "#86cb92";
        yellow    = "#f1f0cc";
        blue      = "#07a0c3";
        purple    = "#a761c2";
        cyan      = "#6e98a4";
        black     = "#000000";
      };

      "commonbar" = {
        width        = "100%";
        height       = 27;
        offset-x     = 0;
        offset-y     = 0;
        top          = true;
        radius       = 0;
        fixed-center = true;

        background = "\${colors.bg}";
        foreground = "\${colors.foreground}";

        line-size  = 3;
        line-color = "\${colors.primary}";

        border-size  = 0;
        border-color = "#00000000";

        padding-left  = 2;
        padding-right = 2;

        module-margin-left  = 1;
        module-margin-right = 2;

        font-0 = "IBM Plex Sans:size=10;0";
        font-1 = "Fira Mono:size=10;0";
        font-2 = "Font Awesome 5 Free:style=Regular:pixelsize=10;1";
        font-3 = "Font Awesome 5 Free:style=Solid:pixelsize=10;1";
        font-4 = "Font Awesome 5 Brands:pixelsize=10;1";
        font-5 = "Noto Sans Symbols2:size=13;2";
        font-6 = "Noto Color Emoji:style=Regular:scale=12:antialias=false:size=1;2";

        tray-position = "right";
        tray-padding  = 4;
        tray-detached = false;
        tray-scale    = "1.0";

        enable-ipc    = false;
      };

      "bar/laptop" = {
        "inherit"      = "commonbar";
        modules-left   = "xmonad-workspaces";
        modules-center = "cpu temperature memory swap";
        modules-right  = "battery backlight volume date openvpn-status";
      };

      "bar/desktop" = {
        "inherit"      = "commonbar";
        modules-left   = "xmonad-workspaces xmonad-title";
        modules-center = "cpu memory swap";
        modules-right  = "mpd volume popup-calendar openvpn-status";
      };

      "module/xmonad" = {
        type = "custom/script";
        exec = "${pkgs.dbus}/bin/dbus-monitor type='signal',path='/user/xmonad/log',interface='user.xmonad.log',member='DynamicLogWithPP' | sed -En -u 's/^.*string..([^:].*)\".*$/\1/p'";
        tail = true;
      };

      "module/xmonad-workspaces" = {
        type        = "custom/script";
        exec        = "${pkgs.coreutils}/bin/tail -F /tmp/.xmonad-workspace-log";
        exec-if     = "[ -p /tmp/.xmonad-workspace-log ]";
        tail        = true;
        label-font  = 2;
      };

      "module/xmonad-title" = {
        type    = "custom/script";
        exec    = "${pkgs.coreutils}/bin/tail -F /tmp/.xmonad-title-log";
        exec-if = "[ -p /tmp/.xmonad-title-log ]";
        tail    = true;
      };

      "module/xwindow" = {
        type             = "internal/xwindow";
        label            = "%title:0:60:...%";
        format-padding   = 4;
        format-underline = "\${colors.lightGray}";
      };

      "module/cpu" = {
        type             = "internal/cpu";
        interval         = 1;
        label            = "%percentage-cores%";
        format           = "<ramp-coreload>";
        format-underline = "\${colors.cyan}";
        format-padding   = 1;

        ramp-coreload-0 = "▁";
        ramp-coreload-1 = "▂";
        ramp-coreload-2 = "▃";
        ramp-coreload-3 = "▄";
        ramp-coreload-4 = "▅";
        ramp-coreload-5 = "▆";
        ramp-coreload-6 = "▇";
        ramp-coreload-7 = "█";
        ramp-coreload-0-foreground = "\${colors.darkGray}";
        ramp-coreload-1-foreground = "\${colors.lightGray}";
        ramp-coreload-2-foreground = "\${colors.yellow}";
        ramp-coreload-3-foreground = "\${colors.yellow}";
        ramp-coreload-4-foreground = "\${colors.yellow}";
        ramp-coreload-5-foreground = "\${colors.yellow}";
        ramp-coreload-6-foreground = "\${colors.red}";
        ramp-coreload-7-foreground = "\${colors.red}";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;

        format-prefix = " ";
        format-prefix-foreground = "\${colors.yellow}";
        format-underline = "\${colors.green}";
        label = "%percentage_used%% %gb_used%";
      };

      "module/swap" = {
        type = "custom/script";
        exec = "free | grep Swap | awk '{printf(\"%d%\"), $3/$2 * 100}'";
        interval = 3;
        format-underline = "\${colors.yellow}";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;

        date = "%A  %Y-%m-%d  %I:%M %p";
        label = "%date%";

        format-padding = 2;
        format-underline = "\${colors.blue}";
      };

      "module/popup-calendar" = {
        type = "custom/script";
        exec = "~/.config/polybar/popup-calendar.sh";
        interval = 1;
        click-left = "~/.config/polybar/popup-calendar.sh --popup &";
        format-padding = 2;
        format-underline = "\${colors.blue}";
      };

      "module/openvpn-status" = {
        type = "custom/script";
        exec = "printf 'VPN: ' && (pgrep -a openvpn$ | ${pkgs.coreutils}/bin/head -n 1 | awk '{path=$NF;n=split(path,A,\"-\");print A[n]}' | ${pkgs.coreutils}/bin/cut -f 1 && echo down) | ${pkgs.coreutils}/bin/head -n 1";
        interval = 5;
        label = "%output:0:15:...%";
        format = "<label>";
        format-underline = "#268bd2";
        format-prefix = "🖧 ";
        format-prefix-foreground = "#5b";
        click-left = "sudo systemctl start openvpn-sxsw";
        click-right = "sudo systemctl stop openvpn-sxsw";
      };

      "module/backlight" = {
        type = "internal/xbacklight";

        label = " %percentage%%";

        format-padding = 2;
        format-underline = "\${colors.blue}";
      };

      "module/volume" = {
        type = "internal/alsa";

        format-volume = "<ramp-volume> <label-volume>";
        format-volume-underline = "\${colors.cyan}";

        format-muted-underline = "\${colors.lightGray}";
        format-muted-prefix = " ";
        format-muted-prefix-foreground = "\${colors.lightGray}";

        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        ramp-volume-0-foreground = "\${colors.cyan}";
        ramp-volume-1-foreground = "\${colors.cyan}";
        ramp-volume-2-foreground = "\${colors.blue}";

        label-muted = "%percentage%%";
        label-volume = "%percentage%%";
      };

      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;
        warn-temperature = 65;

        format = "<label>";
        format-prefix = "  ";
        format-prefix-foreground = "\${colors.cyan}";
        format-underline = "\${colors.cyan}";
        format-warn = "<label-warn>";
        format-warn-prefix = "  ";
        format-warn-foreground = "\${colors.red}";
        format-warn-underline = "\${colors.red}";

        label = "%temperature%";
        label-warn = "%temperature%";
      };

      "module/battery" = {
        type = "internal/battery";
        poll-interval = 5;

        full-at = 99;

        battery = "BAT0";
        adapter = "ADP1";

        format-charging = "<label-charging>";
        format-charging-underline = "\${colors.green}";
        format-charging-prefix = " ";
        format-charging-prefix-foreground = "\${colors.green}";
        format-discharging = "<label-discharging>";
        format-discharging-underline = "\${colors.red}";
        format-discharging-prefix = " ";
        format-discharging-prefix-foreground = "\${colors.red}";
        format-full = "<label-full>";
        format-full-underline = "\${colors.green}";
        format-full-prefix = " ";
        format-full-prefix-foreground = "\${colors.green}";

        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "%percentage%%";
      };

      "module/mpd" = {
        type = "internal/mpd";
        host = "127.0.0.1";
        interval = 2;
        format-online = "<label-time>  <label-song>    <icon-prev>  <icon-stop>  <toggle>  <icon-next>";
        format-online-underline = "\${colors.green}";
        format-playing = "\${self.format-online}";
        format-paused = "\${self.format-online}";
        format-stopped = "\${self.format-online}";
        label-offline = "🎜 mpd is offline";
        label-song = "%artist% - %title%";
        label-song-maxlen = 40;
        icon-play = "⏵";
        icon-pause = "⏸";
        icon-stop = "⏹";
        icon-prev = "⏮";
        icon-next = "⏭";
        toggle-on-foreground = "#ff";
        toggle-off-foreground = "#55";
      };

      "module/powermenu" = {
        type = "custom/text";
        content = "⏻ ";
        click-left = "rofi-power";
      };

      "settings" = {
        screenchange-reload = true;
      };

      "global/wm" = {
        margin-top = 0;
        margin-bottom = 0;
      };
    };

    script = ''
      export PATH=${lib.makeBinPath [ gawk gnugrep gnused procps-ng ]}:$PATH
      polybar desktop &
    '';
  };

  xdg.configFile."polybar/popup-calendar.sh" = {
    text = ''
      #!/bin/sh

      BAR_HEIGHT=27  # polybar height
      BORDER_SIZE=0  # border size from your wm settings
      YAD_WIDTH=222  # 222 is minimum possible value
      YAD_HEIGHT=193 # 193 is minimum possible value
      DATE="$(${pkgs.coreutils}/bin/date +"%A  %Y-%m-%d  %I:%M %p")"

      case "$1" in
      --popup)
          if [ "$(${pkgs.xdotool}/bin/xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
              exit 0
          fi

          eval "$(${pkgs.xdotool}/bin/xdotool getmouselocation --shell)"
          eval "$(${pkgs.xdotool}/bin/xdotool getdisplaygeometry --shell)"

          # X
          if [ "$((X + YAD_WIDTH / 2 + BORDER_SIZE))" -gt "$WIDTH" ]; then #Right side
              : $((pos_x = WIDTH - YAD_WIDTH - BORDER_SIZE))
          elif [ "$((X - YAD_WIDTH / 2 - BORDER_SIZE))" -lt 0 ]; then #Left side
              : $((pos_x = BORDER_SIZE))
          else #Center
              : $((pos_x = X - YAD_WIDTH / 2))
          fi

          # Y
          if [ "$Y" -gt "$((HEIGHT / 2))" ]; then #Bottom
              : $((pos_y = HEIGHT - YAD_HEIGHT - BAR_HEIGHT - BORDER_SIZE))
          else #Top
              : $((pos_y = BAR_HEIGHT + BORDER_SIZE))
          fi

          ${pkgs.yad}/bin/yad \
            --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
            --width=$YAD_WIDTH --height=$YAD_HEIGHT --posx=$pos_x --posy=$pos_y \
            --class="yad-calendar" --borders=0 >/dev/null &
          ;;
      *)
          echo "$DATE"
          ;;
      esac
    '';
    executable = true;
  };

}
