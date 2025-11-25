{ pkgs, ... }:
{
  home.packages = with pkgs; [ impala ];
}

