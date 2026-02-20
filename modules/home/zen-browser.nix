{ inputs, pkgs, lib, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser.enable = true;

  # Migrate Zen config from ~/.zen to ~/.config/zen (required as of 18.18.6b). Runs on switch when ~/.zen exists.
  home.activation.zenBrowserXdgMigration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/.zen" ]; then
      echo "Migrating Zen Browser config: ~/.zen -> ~/.config/zen"
      run mkdir -p "$HOME/.config/zen"
      run cp -an "$HOME/.zen"/. "$HOME/.config/zen/"
      run rm -rf "$HOME/.zen"
      for f in "$HOME/.config/zen/extensions.json" "$HOME/.config/zen/pkcs11.txt" "$HOME/.config/zen/chrome_debugger_profile/pkcs11.txt"; do
        if [ -f "$f" ]; then
          run sed -i 's|\.zen|\.config/zen|g' "$f"
        fi
      done
      echo "Done. Run: zen-beta --safe-mode (once), then close the browser."
    fi
  '';

  xdg.mimeApps =
    let
      value =
        let
          system = pkgs.stdenv.hostPlatform.system;
          zen-browser = inputs.zen-browser.packages.${system}.beta;
        in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (
        map (name: { inherit name value; }) [
          "application/x-extension-shtml"
          "application/x-extension-xhtml"
          "application/x-extension-html"
          "application/x-extension-xht"
          "application/x-extension-htm"
          "x-scheme-handler/unknown"
          "x-scheme-handler/mailto"
          "x-scheme-handler/chrome"
          "x-scheme-handler/about"
          "x-scheme-handler/https"
          "x-scheme-handler/http"
          "application/xhtml+xml"
          "application/json"
          "text/html"
        ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };
}
