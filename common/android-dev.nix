{
  config,
  lib,
  pkgs,
  ...
}:

let
  androidStudioPackages = lib.recurseIntoAttrs (
    pkgs.callPackage ../external/editors/android-studio { }
  );
  android-studio = androidStudioPackages.stable;
in
{
  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
  ];
}
