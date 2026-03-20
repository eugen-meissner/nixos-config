{ pkgs, ... }:
let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      coreutils
      grimblast
      libnotify
      swappy
    ];
    text = ''
      set -euo pipefail

      usage() {
        echo "Usage: screenshot [copy|save|copysave|edit] [area|active|output|screen]"
      }

      action="copy"
      target="area"

      if [[ $# -gt 0 ]]; then
        case "$1" in
          copy|save|copysave|edit)
            action="$1"
            shift
            ;;
          --copy)
            action="copy"
            shift
            ;;
          --save)
            action="save"
            shift
            ;;
          --copysave)
            action="copysave"
            shift
            ;;
          --swappy|--edit)
            action="edit"
            shift
            ;;
          -h|--help)
            usage
            exit 0
            ;;
        esac
      fi

      if [[ $# -gt 0 ]]; then
        target="$1"
        shift
      fi

      if [[ $# -gt 0 ]]; then
        usage >&2
        exit 1
      fi

      case "$target" in
        area|active|output|screen)
          ;;
        *)
          usage >&2
          exit 1
          ;;
      esac

      screenshots_dir="''${HOME}/Pictures/Screenshots"
      mkdir -p "$screenshots_dir"

      timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
      file="$screenshots_dir/''${timestamp}.png"

      case "$action" in
        copy)
          grimblast copy "$target"
          notify-send "Screenshot copied" "Copied ''${target} capture to the clipboard."
          ;;
        save)
          grimblast save "$target" "$file"
          notify-send "Screenshot saved" "$file"
          ;;
        copysave)
          grimblast copysave "$target" "$file"
          notify-send "Screenshot saved and copied" "$file"
          ;;
        edit)
          temp_file="$(mktemp --suffix=.png)"
          trap 'rm -f "$temp_file"' EXIT
          grimblast save "$target" "$temp_file"
          swappy -f "$temp_file"
          ;;
        *)
          usage >&2
          exit 1
          ;;
      esac
    '';
  };
in
{
  home.packages = with pkgs; [
    swww
    screenshot
    grimblast
    hyprpicker
    grim
    slurp
    wl-clip-persist
    cliphist
    wf-recorder
    glib
    wayland
    direnv
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    xwayland = {
      enable = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };
}
