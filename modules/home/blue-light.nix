{ pkgs, ... }:
let
  blueLightStatus = pkgs.writeShellScriptBin "blue-light-status" ''
    if systemctl --user --quiet is-active wlsunset.service; then
      echo '{"text":"󰖔","tooltip":"Blue light filter: on","class":"on"}'
    else
      echo '{"text":"󰖨","tooltip":"Blue light filter: off","class":"off"}'
    fi
  '';

  blueLightToggle = pkgs.writeShellScriptBin "blue-light-toggle" ''
    if systemctl --user --quiet is-active wlsunset.service; then
      systemctl --user stop wlsunset.service
    else
      systemctl --user start wlsunset.service
    fi
  '';
in
{
  home.packages = with pkgs; [
    wlsunset
    blueLightStatus
    blueLightToggle
  ];

  systemd.user.services.wlsunset = {
    Unit = {
      Description = "Wayland blue light filter";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.wlsunset}/bin/wlsunset -t 4000 -T 6500 -s 07:00 -S 21:00";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install.WantedBy = [ "default.target" ];
  };
}
