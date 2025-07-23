# shell.nix
{ pkgs ? import <nixpkgs> { } }:
(pkgs.buildFHSEnv {
  name = "vivado-env";
  targetPkgs = pkgs: (
 with pkgs; [
   ncurses5
   zlib libuuid
   bash coreutils zlib stdenv.cc.cc
   xorg.libXext xorg.libX11 xorg.libXrender xorg.libXtst
   xorg.libXi xorg.libXft xorg.libxcb xorg.libxcb
   freetype fontconfig glib gtk2 gtk3
   graphviz gcc unzip nettools
 ]
  );
  runScript = ''
 env LIBRARY_PATH=/usr/lib \
   C_INCLUDE_PATH=/usr/include \
   CPLUS_INCLUDE_PATH=/usr/include \
   CMAKE_LIBRARY_PATH=/usr/lib \
   CMAKE_INCLUDE_PATH=/usr/include \
   zsh
  '';
}).env
