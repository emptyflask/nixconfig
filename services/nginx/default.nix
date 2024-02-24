{
  enable = false;

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
        };
      };

      proxyWithVite = appPort: wsPort: base {
        "/" = {
          proxyPass = "http://127.0.0.1:" + toString(appPort) + "/";
        };
        "/vite-dev/" = {
          proxyPass = "http://127.0.0.1:" + toString(wsPort) + "/vite-dev/";
          proxyWebsockets = true;
        };
      };

    in {
      "id.sxsw.localhost"            = proxyWithVite 5000 7000 // { default = true; };
      "cart.sxsw.localhost"          = proxyWithVite 5001 7001 // {};
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
      "fif.sxsw.localhost"           = proxyWithVite 5012 7012 // {};
      "artist.sxsw.localhost"        = proxy 5013 // {};
      "spg.sxsw.localhost"           = proxy 5014 // {};
      "rsvp.sxsw.localhost"          = proxy 5015 // {};
      "sxxpress.sxsw.localhost"      = proxy 5016 // {};
      "mmx-broker.sxsw.localhost"    = proxy 5017 // {};

      "usenet.localhost"             = proxy 6789 // {};
      "hoogle.localhost"             = proxy 6800 // {};
    };
}
