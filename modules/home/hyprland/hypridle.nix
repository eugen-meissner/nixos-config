{ pkgs, ... }:
let
  hyprPostSleep = pkgs.writeShellScriptBin "hypr-post-sleep" ''
    # Thunderbolt re-enumeration on resume is slow enough that Hyprland can
    # briefly bring back the laptop panel before the Studio Display is ready.
    sleep 6
    ${pkgs.systemd}/bin/systemctl --user restart kanshi.service || true
    /run/current-system/sw/bin/hyprctl dispatch dpms on || true
  '';
in
{
  home.packages = with pkgs; [
    hypridle
    hyprPostSleep
  ];

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      after_sleep_cmd = hypr-post-sleep
    }

    listener {
      timeout = 900
      on-timeout = loginctl lock-session
    }

    listener {
      timeout = 1800
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }
  '';
}
