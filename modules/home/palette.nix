{
  # Green-dark theme. Single source of truth for all UI.
  # Matches waybar's original scheme: black bg, green accent.
  bg        = "#000000";   # deepest background
  bgAlt     = "#090E09";   # raised surface (waybar bg_1)
  bgElev    = "#111811";   # elevated / hover
  border    = "#243C24";   # subtle green border
  borderSoft = "#1A2B1A";  # even softer border
  fg        = "#9CEEA8";   # primary green (waybar text/border)
  fgRgb     = "156, 238, 168"; # fg as comma-separated rgb, for rgba() strings
  fgDim     = "#73AF7B";   # muted green (waybar secondary)
  fgBright  = "#BDFFC9";   # highlight green
  red       = "#E06C75";
  orange    = "#D7A878";
  yellow    = "#D7C878";
  cyan      = "#79DAC8";
  blue      = "#7FA8D0";
  magenta   = "#C792EA";
  warning   = "#E8C75A";
  critical  = "#F0716B";
  success   = "#9CEEA8";

  # ANSI terminal palette (foot, ghostty, cava, etc.)
  ansi = [
    "#101410" #  0 black
    "#E06C75" #  1 red
    "#73AF7B" #  2 green
    "#D7C878" #  3 yellow
    "#7FA8D0" #  4 blue
    "#C792EA" #  5 magenta
    "#79DAC8" #  6 cyan
    "#C8E8C8" #  7 white
    "#5C665C" #  8 bright black
    "#FF7B8A" #  9 bright red
    "#9CEEA8" # 10 bright green
    "#E8E0A0" # 11 bright yellow
    "#9FC8E8" # 12 bright blue
    "#D8B0F0" # 13 bright magenta
    "#A0E8D8" # 14 bright cyan
    "#FFFFFF" # 15 bright white
  ];

  # cava gradient (dim -> bright green, subtle hint of cyan)
  cava = [
    "#243C24"
    "#3E6A3E"
    "#559155"
    "#73AF7B"
    "#8CCF94"
    "#9CEEA8"
    "#AEF8B8"
    "#BDFFC9"
  ];
}
