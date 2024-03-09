{ config, lib, pkgs, ... }:

let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-medium amsmath capt-of dvisvgm
      dvipng # for preview and export as html
      enumitem hyperref paracol pdfx preprint ulem wrapfig xmpincl;
  });

in { environment.systemPackages = with pkgs; [ tex texstudio ]; }
