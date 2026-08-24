{ host, pkgs, ... }:
let
  palette = import ./palette.nix;
  c = i: builtins.elemAt palette.cava i;
in
{
  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      rocmSupport = host == "desktop";
    };

    settings = {
      color_theme = "green-dark";
      custom_gpu_name0 = "AMD Radeon RX 7800 XT";
      theme_background = false;
      update_ms = 500;
      rounded_corners = false;
    };
  };

  xdg.configFile."btop/themes/green-dark.theme".text = ''
    # Theme: green-dark
    # Matches waybar green-dark palette

    # Main bg
    theme[main_bg]="${palette.bg}"
    # Main text color
    theme[main_fg]="${palette.fgBright}"
    # Title color for boxes
    theme[title]="${palette.fg}"
    # Highlight color for keyboard shortcuts
    theme[hi_fg]="${palette.fg}"
    # Background color of selected item in processes box
    theme[selected_bg]="${palette.bgAlt}"
    # Foreground color of selected item in processes box
    theme[selected_fg]="${palette.fg}"
    # Color of inactive TTY (usually same as main_bg)
    theme[inactive_fg]="${palette.fgDim}"
    # Color of graph text
    theme[graph_text]="${palette.fgDim}"
    # Background color of the meters
    theme[meter_bg]="${palette.bgAlt}"
    # Process misc info background
    theme[proc_misc]="${palette.fgDim}"
    # CPU box color
    theme[cpu_box]="${palette.fg}"
    # Memory box color
    theme[mem_box]="${palette.fg}"
    # Network box color
    theme[net_box]="${palette.fg}"
    # Process box color
    theme[proc_box]="${palette.fg}"
    # Divider line color
    theme[div_line]="${palette.border}"
    # Temperature graph colors
    theme[temp_start]="${c 3}"
    theme[temp_mid]="${palette.warning}"
    theme[temp_end]="${palette.critical}"
    # CPU graph colors
    theme[cpu_start]="${c 3}"
    theme[cpu_mid]="${palette.fg}"
    theme[cpu_end]="${palette.fgBright}"
    # Mem available colors
    theme[free_start]="${c 1}"
    theme[free_mid]="${c 4}"
    theme[free_end]="${palette.fg}"
    # Mem used colors
    theme[used_start]="${palette.fg}"
    theme[used_mid]="${c 4}"
    theme[used_end]="${c 1}"
    # Download colors
    theme[download_start]="${c 4}"
    theme[download_mid]="${palette.fg}"
    theme[download_end]="${palette.fgBright}"
    # Upload colors
    theme[upload_start]="${palette.fgDim}"
    theme[upload_mid]="${c 5}"
    theme[upload_end]="${palette.fg}"
    # Process colors
    theme[proc_start]="${c 3}"
    theme[proc_mid]="${palette.fg}"
    theme[proc_end]="${palette.fgBright}"
    # Battery colors
    theme[battery_start]="${c 3}"
    theme[battery_mid]="${palette.fg}"
    theme[battery_end]="${palette.fgBright}"
  '';

  home.packages = with pkgs; [ nvtopPackages.intel ];
}
