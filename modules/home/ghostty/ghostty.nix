{ host, ... }:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      ##### Font #####
      font-family = [
        "Iosevka Nerd Font Mono"
        "Iosevka Nerd Font"
      ];
      font-size = "${if (host == "laptop") then "12" else "14"}";
      font-feature = [
        "calt"
        "cv66"
        "ss05"
      ];

      ##### Theme #####
      theme = "moonfly";
      background-opacity = 0.5;
      adjust-cursor-thickness = 1;

      selection-clear-on-copy = true;
      mouse-hide-while-typing = true;

      ##### Window #####;
      window-padding-balance = true;
      window-padding-color = "extend";
      window-decoration = "none";
      window-theme = "ghostty";
      window-inherit-working-directory = false;

      resize-overlay = "never";
      confirm-close-surface = false;
      app-notifications = "no-clipboard-copy";

      bell-features = "no-attention,no-audio,no-system,no-title,no-border";

      gtk-single-instance = false;
      gtk-tabs-location = "bottom";
      gtk-wide-tabs = false;
      gtk-custom-css = "styles/tabs.css";

      auto-update = "off";

      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-paste-protection = false;

      ##### Keybinds #####
      keybind = [
        "clear"

        "ctrl+shift+a=select_all"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"

        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_tab:this"
        "alt+digit_1=goto_tab:1"
        "alt+digit_2=goto_tab:2"
        "alt+digit_3=goto_tab:3"
        "alt+digit_4=goto_tab:4"

        "ctrl+equal=increase_font_size:1"
        "ctrl++=increase_font_size:1"
        "ctrl+-=decrease_font_size:1"
        "ctrl+0=reset_font_size"

        "shift+page_down=scroll_page_down"
        "shift+page_up=scroll_page_up"
      ];
    };

    themes.moonfly = {
      background = "080808";
      foreground = "bdbdbd";

      cursor-color = "9e9e9e";
      cursor-text = "080808";

      selection-background = "b2ceee";
      selection-foreground = "080808";

      palette = [
        "0=323437"
        "1=ff5454"
        "2=8cc85f"
        "3=e3c78a"
        "4=80a0ff"
        "5=cf87e8"
        "6=79dac8"
        "7=c6c6c6"

        "8=949494"
        "9=ff5189"
        "10=36c692"
        "11=c6c684"
        "12=74b2ff"
        "13=ae81ff"
        "14=85dc85"
        "15=e4e4e4"
      ];
    };
  };

  xdg.configFile."ghostty/styles/tabs.css".source = ./styles/tabs.css;
}
