{ ... }:
let
  palette = import ../palette.nix;
  rgba = alpha: "rgba(${palette.fgRgb}, ${alpha})";
in
{
  programs.waybar.style = with palette; ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      font-family: Maple Mono;
      font-weight: bold;
      opacity: 1;
      font-size: 18px;
    }

    window#waybar {
      background: ${bg};
      border-bottom: 1px solid ${rgba "0.18"};
    }

    tooltip {
      background: ${bgAlt};
      border: 1px solid ${rgba "0.2"};
    }
    tooltip label {
      margin: 5px;
      color: ${fg};
    }

    #workspaces {
      padding-left: 10px;
    }
    #workspaces button {
      color: ${rgba "0.45"};
      padding: 0 8px;
      margin-right: 6px;
    }
    #workspaces button.empty {
      color: ${rgba "0.3"};
    }
    #workspaces button.active {
      color: ${fg};
      background: ${fg};
      color: ${bg};
    }
    #workspaces button:hover {
      background: ${rgba "0.12"};
      color: ${fg};
    }

    #clock {
      color: ${fg};
      letter-spacing: 0.08em;
    }

    #tray {
      margin-left: 8px;
      color: ${fg};
    }
    #tray menu {
      background: ${bgAlt};
      border: 1px solid ${fg};
      padding: 8px;
    }
    #tray menuitem {
      padding: 1px;
    }

    #pulseaudio, #custom-blue-light, #network, #disk, #battery, #language, #custom-notification, #custom-power-menu {
      padding-left: 4px;
      padding-right: 4px;
      margin-right: 10px;
      color: ${fg};
    }

    #pulseaudio, #custom-blue-light, #language, #custom-notification {
      margin-left: 12px;
    }

    #custom-blue-light.on {
      color: ${yellow};
    }

    #custom-blue-light.off {
      color: ${fg};
    }

    #custom-blue-light {
      min-width: 24px;
      padding-left: 0;
      padding-right: 0;
    }

    #custom-power-menu {
      padding-right: 2px;
      margin-right: 5px;
    }

    #custom-launcher {
      font-size: 20px;
      color: ${fg};
      font-weight: bold;
      margin-left: 14px;
      padding-right: 12px;
    }
  '';
}
