{ ... }:
let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#F5F5F5";
    background_0 = "#000000";
    background_1 = "#111111";
    border_color = "#F5F5F5";
    red = "#F5F5F5";
    green = "#F5F5F5";
    yellow = "#F5F5F5";
    blue = "#F5F5F5";
    magenta = "#F5F5F5";
    cyan = "#F5F5F5";
    orange = "#F5F5F5";
    orange_bright = "#F5F5F5";
    opacity = "1";
    indicator_height = "2px";
  };
in
{
  programs.waybar.style = with custom; ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      font-family: ${font};
      font-weight: ${font_weight};
      opacity: ${opacity};
      font-size: ${font_size};
    }

    window#waybar {
      background: ${background_0};
      border-bottom: 1px solid rgba(245, 245, 245, 0.18);
    }

    tooltip {
      background: ${background_1};
      border: 1px solid rgba(245, 245, 245, 0.2);
    }
    tooltip label {
      margin: 5px;
      color: ${text_color};
    }

    #workspaces {
      padding-left: 10px;
    }
    #workspaces button {
      color: rgba(245, 245, 245, 0.45);
      padding: 0 8px;
      margin-right: 6px;
    }
    #workspaces button.empty {
      color: rgba(245, 245, 245, 0.3);
    }
    #workspaces button.active {
      color: ${text_color};
      background: ${text_color};
      color: ${background_0};
    }
    #workspaces button:hover {
      background: rgba(245, 245, 245, 0.12);
      color: ${text_color};
    }

    #clock {
      color: ${text_color};
      letter-spacing: 0.08em;
    }

    #tray {
      margin-left: 8px;
      color: ${text_color};
    }
    #tray menu {
      background: ${background_1};
      border: 1px solid ${border_color};
      padding: 8px;
    }
    #tray menuitem {
      padding: 1px;
    }

    #pulseaudio, #custom-blue-light, #network, #disk, #battery, #language, #custom-notification, #custom-power-menu {
      padding-left: 4px;
      padding-right: 4px;
      margin-right: 10px;
      color: ${text_color};
    }

    #pulseaudio, #custom-blue-light, #language, #custom-notification {
      margin-left: 12px;
    }

    #custom-blue-light.on {
      color: ${yellow};
    }

    #custom-blue-light.off {
      color: ${text_color};
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
      color: ${text_color};
      font-weight: bold;
      margin-left: 14px;
      padding-right: 12px;
    }
  '';
}
