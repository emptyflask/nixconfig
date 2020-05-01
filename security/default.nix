{ config, lib, pkgs, ... }:

let

  vpns = lib.concatMap (x: [
    "openvpn-${x}"
    "openvpn-${x}.service"
  ]) (builtins.attrNames config.services.openvpn.servers);

  systemctl = cmd: unit: {
    command = "${pkgs.systemd}/bin/systemctl ${cmd} ${unit}";
    options = [ "NOPASSWD" "SETENV" ];
  };

in

{
  # security.polkit.enable = true;

  security.sudo.extraRules = lib.mkAfter [
    {
      groups = [ "wheel" ];

      commands = lib.concatMap (unit: [
        (systemctl "start" unit)
        (systemctl "restart" unit)
        (systemctl "stop" unit)
      ]) vpns;
    }
  ];

  security.pki.certificateFiles = [
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    ./ssl/certs/rootCA.pem
  ];

  # security.dhparams.enable = true;
}
