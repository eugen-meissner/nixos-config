{ username, pkgs, ... }:
let
  fallbackBg =
    "${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom}/share/backgrounds/nixos/nix-wallpaper-simple-dark-gray_bottom.png";
  waypaperConfig = "/home/${username}/.config/waypaper/config.ini";
in
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "${username}";
      };
    };
    xserver.displayManager.lightdm = {
      enable = true;
      background = "/etc/lightdm/background.png";
    };
    libinput = {
      enable = true;
    };
  };

  systemd.services.update-lightdm-bg = {
    description = "Update LightDM greeter background from active waypaper wallpaper";
    serviceConfig.Type = "oneshot";
    path = [ pkgs.coreutils pkgs.gnugrep pkgs.gnused ];
    script = ''
      CONFIG_FILE="${waypaperConfig}"
      WALLPAPER_PATH=""
      if [ -f "$CONFIG_FILE" ]; then
        WALLPAPER_PATH=$(grep '^wallpaper = ' "$CONFIG_FILE" | ${pkgs.gnused}/bin/sed 's/^wallpaper = //' | tr -d ' ')
        WALLPAPER_PATH=$(echo "$WALLPAPER_PATH" | ${pkgs.gnused}/bin/sed "s|^~|/home/${username}|")
      fi
      if [ -z "$WALLPAPER_PATH" ] || [ ! -f "$WALLPAPER_PATH" ]; then
        WALLPAPER_PATH="${fallbackBg}"
      fi
      ${pkgs.coreutils}/bin/install -m 644 -D "$WALLPAPER_PATH" /etc/lightdm/background.png
    '';
  };

  systemd.paths.update-lightdm-bg = {
    description = "Watch waypaper config for wallpaper changes";
    wantedBy = [ "multi-user.target" ];
    pathConfig.PathChanged = "${waypaperConfig}";
  };

  system.activationScripts.update-lightdm-bg = {
    deps = [ "users" ];
    text = ''
      CONFIG_FILE="${waypaperConfig}"
      WALLPAPER_PATH=""
      if [ -f "$CONFIG_FILE" ]; then
        WALLPAPER_PATH=$(grep '^wallpaper = ' "$CONFIG_FILE" | ${pkgs.gnused}/bin/sed 's/^wallpaper = //' | tr -d ' ')
        WALLPAPER_PATH=$(echo "$WALLPAPER_PATH" | ${pkgs.gnused}/bin/sed "s|^~|/home/${username}|")
      fi
      if [ -z "$WALLPAPER_PATH" ] || [ ! -f "$WALLPAPER_PATH" ]; then
        WALLPAPER_PATH="${fallbackBg}"
      fi
      ${pkgs.coreutils}/bin/install -m 644 -D "$WALLPAPER_PATH" /etc/lightdm/background.png
    '';
  };

  # To prevent getting stuck at shutdown
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}
