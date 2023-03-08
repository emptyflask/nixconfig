{
  enable = true;

  recommendedGzipSettings   = true;
  recommendedOptimisation   = true;
  recommendedProxySettings  = true;
  recommendedTlsSettings    = true;

  resolver = {
    addresses = ["8.8.8.8" "8.8.4.4"];
    valid = "300s";
  };

  sslDhparam = "/etc/nixos/security/ssl/certs/dhparam.pem";

  virtualHosts =
    let
      base = locations: {
        inherit locations;
        addSSL = true;
        sslCertificate    = "/etc/nixos/security/ssl/certs/localhost+4.pem";
        sslCertificateKey = "/etc/nixos/security/ssl/private/localhost+4-key.pem";
      };

      proxy = port: base {
        "/" = {
          proxyPass = "http://127.0.0.1:" + toString(port) + "/";
          proxyWebsockets = true;
        };

        # for webpack-dev-server, starting at port 3035
        # "/sockjs-node" = {
        #   proxyPass = "http://127.0.0.1:" + toString(port - 1965);
        #   proxyWebsockets = true;
        #   extraConfig = ''
        #     proxy_set_header   X-Forwarded-For $remote_addr;
        #     proxy_set_header   Host $host;
        #     proxy_redirect off;
        #     proxy_set_header Upgrade $http_upgrade;
        #     proxy_set_header Connection "upgrade";
        #   '';
        # };
        # "/__webpack_dev_server__" = {
        #   proxyPass = "http://127.0.0.1:" + toString(port - 1965);
        # };
      };

      proxyWithVite = appPort: wsPort: base {
        "/" = {
          proxyPass = "http://127.0.0.1:" + toString(appPort) + "/";
          # proxyWebsockets = true;
        };
        "/vite-dev" = {
          proxyPass = "http://127.0.0.1:" + toString(wsPort) + "/";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header   X-Forwarded-For $remote_addr;
            proxy_set_header   Host $host;
            proxy_redirect off;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
          '';
        };
      };

    in {
      "id.sxsw.localhost"            = proxy 5000 // { default = true; };
      "cart.sxsw.localhost"          = proxy 5001 // {};
      "social.sxsw.localhost"        = proxy 5002 // {};
      "panelpicker.sxsw.localhost"   = proxy 5003 // {};
      "distro.sxsw.localhost"        = proxyWithVite 5004 7004 // {};
      "chronos.sxsw.localhost"       = proxyWithVite 5005 7005 // {};
      "abraxas.sxsw.localhost"       = proxy 5006 // {};
      "me-cart.sxsw.localhost"       = proxy 5007 // {};
      "coupons.sxsw.localhost"       = proxy 5008 // {};
      "nearby.sxsw.localhost"        = proxy 5009 // {};
      "image-manager.sxsw.localhost" = proxy 5010 // {};
      "logger.sxsw.localhost"        = proxy 5011 // {};
      "fif.sxsw.localhost"           = proxy 5012 // {};
      "artist.sxsw.localhost"        = proxy 5013 // {};
      "spg.sxsw.localhost"           = proxy 5014 // {};
      "rsvp.sxsw.localhost"          = proxy 5015 // {};
      "sxxpress.sxsw.localhost"      = proxy 5016 // {};

      "usenet.localhost"             = proxy 6789 // {};
      "hoogle.localhost"             = proxy 6800 // {};
    };
}
