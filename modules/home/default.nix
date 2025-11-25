{ ... }:
{
  imports = [
    ./audacious/audacious.nix         # music player
    ./azure-cli.nix
    ./zen-browser.nix                 # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./bluetui.nix                     # bluetooth tui
    ./cava.nix                        # audio visualizer
    ./cursor.nix
    ./dbeaver.nix
    ./fastfetch/fastfetch.nix         # fetch tool
    ./fzf.nix                         # fuzzy finder
    ./ghostty/ghostty.nix             # terminal
    ./git.nix                         # version control
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./nix-search/nix-search.nix       # TUI to search nixpkgs
    ./nvim.nix                        # neovim editor
    ./packages                        # other packages
    ./ssh.nix                         # ssh config
    ./superfile/superfile.nix         # terminal file manager
    ./swaylock.nix                    # lock screen
    ./swaync/swaync.nix               # notification deamon
    ./waybar                          # status bar
    ./waypaper.nix                    # GUI wallpaper picker
    ./teams-for-linux.nix
    ./vicinae.nix                     # launcher
    ./xdg-mimes.nix                   # xdg config
    ./zsh                             # shell
  ];
}
