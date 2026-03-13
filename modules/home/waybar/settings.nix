{ host, pkgs, ... }:
let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#928374";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    opacity = "1";
    indicator_height = "2px";
  };

  btopCommand =
    "hyprctl dispatch exec '[float; center; size 950 650] ghostty -e btop'";

  systemResourcesScript = pkgs.writeShellScript "waybar-system-resources" ''
    #!${pkgs.bash}/bin/bash

    cpu_state_dir="''${XDG_RUNTIME_DIR:-/tmp}"
    if [[ ! -w "$cpu_state_dir" ]]; then
      cpu_state_dir="/tmp"
    fi
    cpu_state_file="$cpu_state_dir/waybar-system-resources.cpu"

    read_cpu_stat() {
      awk '
        /^cpu / {
          idle = $5 + $6
          total = 0
          for (i = 2; i <= NF; i++) {
            total += $i
          }
          print total, idle
        }
      ' /proc/stat
    }

    read -r total idle <<< "$(read_cpu_stat)"
    if [[ -r "$cpu_state_file" ]]; then
      read -r prev_total prev_idle < "$cpu_state_file"
    else
      sleep 0.2
      read -r prev_total prev_idle <<< "$(read_cpu_stat)"
    fi
    printf '%s %s\n' "$total" "$idle" > "$cpu_state_file"

    total_diff=$((total - prev_total))
    idle_diff=$((idle - prev_idle))
    if (( total_diff > 0 )); then
      cpu_usage=$((((100 * (total_diff - idle_diff)) + (total_diff / 2)) / total_diff))
    else
      cpu_usage=0
    fi

    mem_total_kb="$(awk '/^MemTotal:/ { print $2 }' /proc/meminfo)"
    mem_available_kb="$(awk '/^MemAvailable:/ { print $2 }' /proc/meminfo)"
    mem_used_kb=$((mem_total_kb - mem_available_kb))
    mem_usage=$((((100 * mem_used_kb) + (mem_total_kb / 2)) / mem_total_kb))
    mem_used_gib="$(awk -v kib="$mem_used_kb" 'BEGIN { printf "%.1f", kib / 1048576 }')"
    mem_total_gib="$(awk -v kib="$mem_total_kb" 'BEGIN { printf "%.1f", kib / 1048576 }')"

    temp_input_file=""
    for label_file in /sys/class/hwmon/hwmon*/temp*_label; do
      [[ -r "$label_file" ]] || continue
      if [[ "$(cat "$label_file")" == "Package id 0" ]]; then
        temp_input_file="''${label_file%_label}_input"
        break
      fi
    done

    if [[ -z "$temp_input_file" ]]; then
      for zone_dir in /sys/class/thermal/thermal_zone*; do
        [[ -r "$zone_dir/type" ]] || continue
        if [[ "$(cat "$zone_dir/type")" == "x86_pkg_temp" && -r "$zone_dir/temp" ]]; then
          temp_input_file="$zone_dir/temp"
          break
        fi
      done
    fi

    temp_text="N/A"
    temp_class="normal"
    if [[ -n "$temp_input_file" && -r "$temp_input_file" ]]; then
      temp_raw="$(cat "$temp_input_file")"
      if (( temp_raw >= 1000 )); then
        temp_c=$(((temp_raw + 500) / 1000))
      else
        temp_c="$temp_raw"
      fi

      temp_text="''${temp_c}C"
      if (( temp_c >= 85 )); then
        temp_class="critical"
      elif (( temp_c >= 75 )); then
        temp_class="warning"
      fi
    fi

    text="<span foreground='${custom.green}'> </span>''${cpu_usage}% <span foreground='${custom.cyan}'>󰟜 </span>''${mem_usage}% <span foreground='${custom.orange}'> </span>''${temp_text}"
    tooltip="CPU: ''${cpu_usage}% | RAM: ''${mem_usage}% (''${mem_used_gib}/''${mem_total_gib} GiB) | Temp: ''${temp_text}"

    printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$text" "$tooltip" "$temp_class"
  '';
in
{
  programs.waybar.settings.mainBar = with custom; {
    position = "bottom";
    layer = "top";
    height = 28;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
      "tray"
    ];
    modules-center = [ "clock" ];
    modules-right = [
      "custom/system-resources"
      (if (host == "desktop") then "disk" else "")
      "pulseaudio"
      "custom/blue-light"
      "network"
      "battery"
      "hyprland/language"
      "custom/notification"
      "custom/power-menu"
    ];
    clock = {
      calendar = {
        format = {
          today = "<span color='#98971A'><b>{}</b></span>";
        };
      };
      format = "  {:%H:%M}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "  {:%d/%m}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "I";
        "2" = "II";
        "3" = "III";
        "4" = "IV";
        "5" = "V";
        "6" = "VI";
        "7" = "VII";
        "8" = "VIII";
        "9" = "IX";
        "10" = "X";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
      };
    };
    "custom/system-resources" = {
      return-type = "json";
      format = "{}";
      escape = false;
      exec = "${systemResourcesScript}";
      interval = 2;
      on-click = btopCommand;
      on-click-right = btopCommand;
    };
    disk = {
      # path = "/";
      format = "<span foreground='${orange}'>󰋊 </span>{percentage_used}%";
      interval = 60;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    network = {
      format-wifi = "<span foreground='${magenta}'> </span> {signalStrength}%";
      format-ethernet = "<span foreground='${magenta}'>󰀂 </span>";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "<span foreground='${magenta}'>󰖪 </span>";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "<span foreground='${blue}'> </span> {volume}%";
      format-icons = {
        default = [ "<span foreground='${blue}'> </span>" ];
      };
      scroll-step = 2;
      on-click = "pamixer -t";
      on-click-right =
        "hyprctl dispatch exec '[float; center; size 950 650] ghostty -e wiremix'";
    };
    "custom/blue-light" = {
      return-type = "json";
      format = "{}";
      align = 0.5;
      justify = "center";
      exec = "blue-light-status";
      interval = 2;
      on-click = "blue-light-toggle";
      on-click-right = "systemctl --user restart wlsunset.service";
    };
    battery = {
      format = "<span foreground='${yellow}'>{icon}</span> {capacity}%";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
      format-charging = "<span foreground='${yellow}'> </span>{capacity}%";
      format-full = "<span foreground='${yellow}'> </span>{capacity}%";
      format-warning = "<span foreground='${yellow}'> </span>{capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    "hyprland/language" = {
      tooltip = true;
      tooltip-format = "Keyboard layout";
      format = "<span foreground='#FABD2F'> </span> {}";
      format-en = "US";
      on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
    };
    "custom/launcher" = {
      format = "";
      on-click = "random-wallpaper";
      tooltip = "true";
      tooltip-format = "Random Wallpaper";
    };
    "custom/notification" = {
      tooltip = true;
      tooltip-format = "Notifications";
      format = "{icon}";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
    "custom/power-menu" = {
      tooltip = true;
      tooltip-format = "Power menu";
      format = "<span foreground='${red}'> </span>";
      on-click = "power-menu";
    };
  };
}
