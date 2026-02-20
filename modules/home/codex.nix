{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.codex.packages.${pkgs.system}.default
  ];
}
