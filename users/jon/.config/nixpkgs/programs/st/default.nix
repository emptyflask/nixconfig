let
  pkgs = import <nixos> {};
in

{
  nixpkgs.overlays = [
    (self: super: {
      st = pkgs.st.override {

        extraLibs = with pkgs; [
          harfbuzz # Ligature support for Fira Code
        ];

        patches = [
          ./st-alpha-0.8.2.diff
          # ./st-gruvbox-dark-0.8.2.diff
          ./st-fira-code.diff
        ];
      };
    })
  ];
}
