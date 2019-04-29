pkgs:
with pkgs;
{
    enable = true;
    package = pkgs.postgresql_10;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE jon WITH LOGIN CREATEDB;
      CREATE DATABASE jon;
      GRANT ALL PRIVILEGES ON DATABASE jon TO jon;
    '';
}
