{ pkgs, ... }:
with pkgs;
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      githubSupport = true;
    };
    config = {
      "colors" = {
        background     = "#2c3e50";
        background-alt = "#235";
        foreground     = "#ecf0f1";
        foreground-alt = "#eff";

        fg        = "#f9f7dd";
        bg        = "#cc2f2f2f";
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
        foreground = "\${colors.fg}";

        line-size  = 3;
        line-color = "\${colors.red}";

        border-size  = 0;
        border-color = "#00000000";

        padding-left  = 2;
        padding-right = 2;

        module-margin-left  = 1;
        module-margin-right = 2;

        font-0 = "IBM Plex Sans:size=10;0";
        font-1 = "Fira Mono:size=10;0";
        font-2 = "FontAwesome:size=10;1";
        font-3 = "FontAwesome;pixelsize=10;1";

        tray-position = "right";
        tray-padding  = 2;
        tray-detached = false;
        tray-scale    = "1.0";

        enable-ipc    = false;
      };

      "bar/laptop" = {
        "inherit"      = "commonbar";
        modules-left   = "xmonad-workspaces";
        modules-center = "cpu temperature memory swap";
        modules-right  = "battery backlight volume date";
      };

      "bar/desktop" = {
        "inherit"      = "commonbar";
        modules-left   = "xmonad-workspaces xmonad-title";
        modules-center = "cpu memory swap";
        modules-right  = "volume date";
      };

      "module/xmonad" = {
        type = "custom/script";
        exec = "dbus-monitor type='signal',path='/user/xmonad/log',interface='user.xmonad.log',member='DynamicLogWithPP' | sed -En -u 's/^.*string..([^:].*)\".*$/\1/p'";
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
        format-underline = "\${colors.yellow}";
        format-padding   = 1;

        ramp-coreload-0 = "▁";
        ramp-coreload-1 = "▂";
        ramp-coreload-2 = "▃";
        ramp-coreload-3 = "▄";
        ramp-coreload-4 = "▅";
        ramp-coreload-5 = "▆";
        ramp-coreload-6 = "▇";
        ramp-coreload-7 = "█";
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
        format-underline = "\${colors.yellow}";
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

      "settings" = {
        screenchange-reload = true;
      };

      "global/wm" = {
        margin-top = 0;
        margin-bottom = 0;
      };
    };

    script = ''
      export PATH=${lib.makeBinPath [ pkgs.gnused pkgs.dbus pkgs.procps-ng pkgs.gnugrep pkgs.gawk ]}:$PATH
      polybar desktop &
    '';
  };
}
