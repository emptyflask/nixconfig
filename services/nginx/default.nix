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

    sslDhparam = "/root/ssl/certs/dhparam.pem";

    virtualHosts = let
      base = locations: {
        inherit locations;

        addSSL = true;

        sslCertificate    = "/root/ssl/certs/_wildcard.sxsw.localhost+4.pem";
        sslCertificateKey = "/root/ssl/private/_wildcard.sxsw.localhost+4-key.pem";
        # sslCertificate    = "/root/ssl/certs/sxsw.localhost.crt";
        # sslCertificateKey = "/root/ssl/private/sxsw.localhost.key";
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

      # "fake-image-manager.sxsw.localhost" = {
      #   addSSL = true;
      #   sslCertificate    = "/root/ssl/certs/_wildcard.sxsw.localhost+4.pem";
      #   sslCertificateKey = "/root/ssl/private/_wildcard.sxsw.localhost+4-key.pem";
      #   root = "/home/jon/dev/sxsw/fake-image-manager";

        # locations."/" = {
        #   extraConfig = ''
        #     rewrite ^ /response.json break;
        #   '';
        # };

        # example:
        # server {
        #   root /tmp/root;
        #   server {
        #     listen 8080;
        #     location /static {
        #       try_files $uri =404;
        #     }
        #     location / {
        #       rewrite ^ /static/index_debug.html break;
        #     }
        #   }
        # }
      # };

    };
  }
