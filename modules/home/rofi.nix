{ pkgs, ... }:
{
  home.packages = with pkgs; [ rofi ];

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun";
      show-icons: true;
      display-drun: "";
      drun-display-format: "{name}";
      font: "Maple Mono Bold 18";
    }

    @theme "theme"
  '';

  xdg.configFile."rofi/theme.rasi".text = ''
    * {
      background: #000000;
      background-alt: #111111;
      foreground: #F5F5F5;
      foreground-muted: #737373;
      border-color: #2E2E2E;
      selected-background: #F5F5F5;
      selected-foreground: #000000;
    }

    window {
      width: 42%;
      location: center;
      anchor: center;
      border: 1px;
      border-color: @border-color;
      border-radius: 0px;
      background-color: @background;
      padding: 0px;
    }

    mainbox {
      background-color: @background;
      padding: 14px;
      spacing: 10px;
      children: [inputbar, listview];
    }

    inputbar {
      background-color: @background-alt;
      border: 1px;
      border-color: @border-color;
      border-radius: 0px;
      padding: 8px 10px;
      spacing: 8px;
      children: [prompt, entry];
    }

    prompt {
      enabled: true;
      text-color: @foreground-muted;
      background-color: transparent;
    }

    entry {
      text-color: @foreground;
      background-color: transparent;
      placeholder: "Search";
      placeholder-color: @foreground-muted;
    }

    listview {
      background-color: @background;
      columns: 1;
      lines: 8;
      fixed-height: true;
      scrollbar: false;
      spacing: 2px;
    }

    element {
      background-color: transparent;
      text-color: @foreground;
      border-radius: 0px;
      padding: 7px 9px;
      spacing: 10px;
    }

    element selected {
      background-color: @selected-background;
      text-color: @selected-foreground;
    }

    element-icon {
      background-color: transparent;
      size: 24px;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      vertical-align: 0.5;
    }
  '';
}
