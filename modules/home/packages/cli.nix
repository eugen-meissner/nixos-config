{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Better core utils
    duf                               # disk information
    fd                                # find replacement
    gping                             # ping with a graph
    hexyl                             # hex viewer
    man-pages                         # extra man pages
    ncdu                              # disk space
    ripgrep                           # grep replacement
    tldr

    ## Tools / useful cli
    swappy                            # snapshot editing tool
    tdf                               # cli pdf viewer
    tokei                             # project line counter
    yt-dlp-light

    ## TUI
    epy                               # ebook reader
    programmer-calculator

    ## Multimedia
    imv
    lowfi
    mpv

    ## Utilities
    entr                              # perform action when file change
    ffmpeg
    file                              # Show file information
    jq                                # JSON processor
    killall
    libnotify
    openssl
    pamixer                           # pulseaudio command line mixer
    poweralertd
    udiskie                           # Automounter for removable media
    unzip
    wget
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    xdg-utils
  ];
}
