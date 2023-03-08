{pkgs, lib, system, ...}:

let
  notBroken = (p: lib.isDerivation p && !((p.meta or {}).broken or false));

in
{
  services.hoogle = {
    enable = true;
    port = 6800;
    packages = haskellPackages: builtins.filter notBroken (import ./package-list.nix { inherit haskellPackages; });
  };
}
