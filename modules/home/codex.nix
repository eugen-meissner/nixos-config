{ pkgs, inputs, ... }:
{
  home.packages = [
    (inputs.codex.packages.${pkgs.system}.default.overrideAttrs (old: {
      buildInputs = (old.buildInputs or []) ++ [ pkgs.libcap ];
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.pkg-config ];
    }))
  ];
}
