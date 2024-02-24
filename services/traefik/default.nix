{pkgs, lib, system, ...}:

{
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      api = {
        dashboard = true;
        insecure = true;
      };

      entryPoints = {
        web = {
          address = ":80";
        };
        websecure = {
          address = ":443";
          http = {
            tls = {};
            middlewares.websocket = {};
          };
        };
      };
    };

    dynamicConfigOptions = {
      tls.stores.default.defaultCertificate = {
        certFile = "/etc/nixos/security/ssl/certs/localhost+4.pem";
        keyFile = "/etc/nixos/security/ssl/private/localhost+4-key.pem";
      };

      http =
        let
          proxy = host: port: {
            routers."${host}" = {
              rule = "Host(`${host}`)";
              entryPoints = [ "web" ];
              service = host;
            };

            routers."${host}-secure" = {
              rule = "Host(`${host}`)";
              entryPoints = [ "websecure" ];
              tls = {};
              service = host;
            };

            routers."${host}-ws" = {
              # rule = "Host(`${host}`) && HeadersRegexp(`Upgrade`, `websocket`, true)";
              rule = "Host(`${host}`) && PathPrefix(`/vite-dev`)";
              middlewares = [ "websocket" ];
              service = "${host}-ws";
            };

            routers."${host}-wss" = {
              rule = "Host(`${host}`) && PathPrefix(`/vite-dev`)";
              middlewares = [ "websocket" ];
              tls = {};
              service = "${host}-ws";
            };

            services."${host}".loadBalancer.servers = [
              { url = "http://localhost:${toString port}/"; }
            ];

            services."${host}-ws".loadBalancer.servers = [
              { url = "http://localhost:${toString (port+2000)}/"; }
            ];
          };
        in
          lib.mkMerge [
            (proxy "id.sxsw.localhost"            5000)
            (proxy "cart.sxsw.localhost"          5001)
            (proxy "social.sxsw.localhost"        5002)
            (proxy "panelpicker.sxsw.localhost"   5003)
            (proxy "distro.sxsw.localhost"        5004)
            (proxy "chronos.sxsw.localhost"       5005)
            (proxy "sales.sxsw.localhost"         5006)

            (proxy "coupons.sxsw.localhost"       5008)
            (proxy "nearby.sxsw.localhost"        5009)
            (proxy "image-manager.sxsw.localhost" 5010)
            (proxy "logger.sxsw.localhost"        5011)
            (proxy "fif.sxsw.localhost"           5012)
            (proxy "artist.sxsw.localhost"        5013)
            (proxy "spg.sxsw.localhost"           5014)
            (proxy "rsvp.sxsw.localhost"          5015)
            (proxy "sxxpress.sxsw.localhost"      5016)
            (proxy "mmx-broker.sxsw.localhost"    5017)

            (proxy "usenet.localhost"             6789)
            (proxy "hoogle.localhost"             6800)
          ];
    };

  };
}
