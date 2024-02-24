{ pkgs, ... }:

let mypg = pkgs.postgresql_12;

in
{
    enable = false;
    package = mypg;

    extraPlugins = with mypg.pkgs; [
      # (pkgs.postgis.override { postgresql = pkgs.postgresql_10; })
      # postgis
    ];

    enableTCPIP = true;

    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host  all all 127.0.0.1/32  trust
      host  all all ::1/128       trust
    '';

    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE jon WITH LOGIN CREATEDB;
      CREATE DATABASE jon;
      GRANT ALL PRIVILEGES ON DATABASE jon TO jon;
    '';
}
