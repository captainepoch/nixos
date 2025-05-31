{ config, lib, pkgs, ... }:

let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      amsmath capt-of dvisvgm dvipng # for preview and export as html
      enumitem hyperref paracol pdfx preprint scheme-medium ulem wrapfig xmpincl
      xifthen ifmtarg xstring fontawesome5 roboto sourcesanspro tcolorbox
      tikzfill fontspec;
  });

in { environment.systemPackages = with pkgs; [ tex texstudio ]; }
