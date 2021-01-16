{pkgs, lib, system, ...}:

let
  notBroken = (p: lib.isDerivation p && !(p.meta.broken or false));

in
{
  services.hoogle = {
    enable = true;
    port = 8081;
    packages = haskellPackages: builtins.filter notBroken (pkgs.callPackage ./package-list.nix { inherit haskellPackages; });
  };
}
