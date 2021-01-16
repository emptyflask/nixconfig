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
        sslCertificate    = "/etc/nixos/security/ssl/certs/_wildcard.sxsw.localhost+4.pem";
        sslCertificateKey = "/etc/nixos/security/ssl/private/_wildcard.sxsw.localhost+4-key.pem";
      };

      proxy = port: base {
        "/".proxyPass = "http://127.0.0.1:" + toString(port) + "/";
      };

    in {
      "id.sxsw.localhost"            = proxy 5000 // { default = true; };
      "cart.sxsw.localhost"          = proxy 5001 // {  };
      "social.sxsw.localhost"        = proxy 5002 // {  };
      "panelpicker.sxsw.localhost"   = proxy 5003 // {  };
      "distro.sxsw.localhost"        = proxy 5004 // {  };
      "chronos.sxsw.localhost"       = proxy 5005 // {  };
      "abraxas.sxsw.localhost"       = proxy 5006 // {  };
      "me-cart.sxsw.localhost"       = proxy 5007 // {  };
      "coupons.sxsw.localhost"       = proxy 5008 // {  };
      "nearby.sxsw.localhost"        = proxy 5009 // {  };
      "image-manager.sxsw.localhost" = proxy 5010 // {  };
      "logger.sxsw.localhost"        = proxy 5011 // {  };
      "fif.sxsw.localhost"           = proxy 5012 // {  };
      "artist.sxsw.localhost"        = proxy 5013 // {  };

      "sabnzbd.localhost"            = proxy 8080 // {  };
      "hoogle.localhost"             = proxy 8081 // {  };
    };
}
