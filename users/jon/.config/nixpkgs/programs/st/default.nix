let
  pkgs = import <nixos-unstable> {};
in

{
  nixpkgs.overlays = [
    (self: super: {
      st = pkgs.st.override {

        extraLibs = with pkgs; [
          harfbuzz # Ligature support for Fira Code
        ];

        patches = [ ./st-custom-0.8.3.diff ];
      };
    })
  ];
}
