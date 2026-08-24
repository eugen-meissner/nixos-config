{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  palette = import ../palette.nix;
  pdfPreviewDeps = [ pkgs.poppler-utils ];
  # Build superfile using buildGoModule to handle dependencies properly
  # This avoids the vendor directory issues with the flake's build
  superfile = (pkgs.buildGoModule.override { go = pkgs.go_1_26; }) rec {
    pname = "superfile";
    version = "1.5.0";
    # Get source from the flake input
    src = inputs.superfile;
    # Vendor hash calculated by Nix (from the error message)
    vendorHash = "sha256-nkKvb62+tv44iX7gPpDpinL1vqEkOhGyAen87O+qZnM=";
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postFixup = ''
      wrapProgram $out/bin/superfile \
        --prefix PATH : ${pkgs.lib.makeBinPath pdfPreviewDeps}
    '';
    doCheck = false;
  };
in
{
  home.packages = [
    superfile
  ] ++ pdfPreviewDeps;

  xdg.desktopEntries.superfile = {
    name = "Superfile";
    genericName = "File Manager";
    comment = "Open directories in superfile";
    exec = "ghostty -e superfile %f";
    mimeType = [ "inode/directory" ];
    categories = [
      "ConsoleOnly"
      "FileManager"
      "System"
    ];
    terminal = false;
  };

  xdg.configFile."superfile/config.toml".source = ./config.toml;

  xdg.configFile."superfile/theme/green-dark.toml".text = ''
    ##############################################
    #                                            #
    #            Green Dark Theme                #
    #                                            #
    ##############################################

    # Matches the shared waybar green-dark palette

    ###############################################################################
    #                           Code Syntax Highlighting                          #
    ###############################################################################

    code_syntax_highlight = "gruvbox"

    ###############################################################################
    #                                 Base Colors                                 #
    ###############################################################################

    #-- Full Screen
    full_screen_fg = "${palette.fgBright}"
    full_screen_bg = "${palette.bg}"

    #-- Gradient
    gradient_color = ["${palette.fgDim}", "${palette.fg}"]
    directory_icon_color = ""

    #-- File Panel
    file_panel_fg = "${palette.fgBright}"
    file_panel_bg = "${palette.bg}"
    file_panel_border = "${palette.fgDim}"
    file_panel_border_active = "${palette.fg}"
    file_panel_top_directory_icon = "${palette.fg}"
    file_panel_top_path = "${palette.fgDim}"
    file_panel_item_selected_fg = "${palette.bg}"
    file_panel_item_selected_bg = "${palette.fg}"

    #-- Footer
    footer_fg = "${palette.fgBright}"
    footer_bg = "${palette.bgAlt}"
    footer_border = "${palette.border}"
    footer_border_active = "${palette.fg}"

    #-- Sidebar
    sidebar_fg = "${palette.fgBright}"
    sidebar_bg = "${palette.bgAlt}"
    sidebar_title = "${palette.fg}"
    sidebar_border = "${palette.border}"
    sidebar_border_active = "${palette.fg}"
    sidebar_item_selected_fg = "${palette.bg}"
    sidebar_item_selected_bg = "${palette.fg}"
    sidebar_divider = "${palette.border}"

    #-- Modals
    modal_fg = "${palette.fgBright}"
    modal_bg = "${palette.bg}"
    modal_border_active = "${palette.fg}"
    modal_cancel_fg = "${palette.critical}"
    modal_cancel_bg = ""
    modal_confirm_fg = "${palette.fg}"
    modal_confirm_bg = ""

    #-- Help Menu
    help_menu_hotkey = "${palette.fg}"
    help_menu_title = "${palette.fgDim}"

    #-- Special
    cursor = "${palette.fg}"
    correct = "${palette.fg}"
    error = "${palette.critical}"
    hint = "${palette.cyan}"
    cancel = "${palette.fgDim}"
  '';
}
