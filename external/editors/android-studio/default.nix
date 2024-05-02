{ callPackage, makeFontsConf, gnome2, buildFHSEnv, tiling_wm ? false }:

let
  mkStudio = opts:
    callPackage (import ./common.nix opts) {
      fontsConf = makeFontsConf { fontDirectories = [ ]; };
      inherit (gnome2) GConf gnome_vfs;
      inherit buildFHSEnv;
      inherit tiling_wm;
    };
  stableVersion = {
    version = "2023.3.1.18"; # "Android Studio Jellyfish | 2023.3.1.18"
    sha256Hash = "sha256-Rqm0oxGCCywYQREK/6KG1lZlrJ+JcP2enrkDw9eqQ24=";
  };
  betaVersion = {
    version = "2023.3.1.17"; # "Android Studio Jellyfish | 2023.3.1.1 RC 2"
    sha256Hash = "sha256-zROBKzQiP4V2P67HgOIkHgn8q/M0zy5MkZozVSiQsWU=";
  };
  latestVersion = {
    version = "2024.1.1.4"; # "Android Studio Koala | 2024.1.1 Canary 6"
    sha256Hash = "sha256-lfig7lFyF7XZowTQKpo6zGeR23VHq/f7vvUDWCs7jeo=";
  };
in {
  # Attributes are named by their corresponding release channels

  stable = mkStudio (stableVersion // {
    channel = "stable";
    pname = "android-studio";
  });

  beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });

  dev = mkStudio (latestVersion // {
    channel = "dev";
    pname = "android-studio-dev";
  });

  canary = mkStudio (latestVersion // {
    channel = "canary";
    pname = "android-studio-canary";
  });
}
