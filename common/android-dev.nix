{ config, lib, pkgs, ... }:

let
  androidStudioPackages = lib.recurseIntoAttrs
    (pkgs.callPackage ../external/editors/android-studio { });
  android-studio = androidStudioPackages.stable;
in {
  #nixpkgs.config.packageOverrides = pkgs: {
  #  android-tools =
  #    pkgs.android-tools.overrideAttrs (oldAttrs: { version = "35.0.2"; });
  #};

  environment.systemPackages = with pkgs; [ android-studio android-tools ];
}
