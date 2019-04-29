{
  autoStart = false;
  updateResolvConf = true;
  config = ''
    client
    dev tun
    proto udp
    nobind
    remote vpn.sxsw.com 1194
    persist-key
    persist-tun
    resolv-retry infinite
    ca ca.crt
    ns-cert-type server
    comp-lzo
    verb 3
    auth-user-pass
    dhcp-option DNS 192.168.254.3
    dhcp-option DOMAIN sxsw.com
    dhcp-option DOMAIN-SEARCH 1.sxsw.com
    dhcp-option DOMAIN-SEARCH sxswedu.com
    dhcp-option DOMAIN-SEARCH sxsweco.com
    dhcp-option DOMAIN-SEARCH sxswv2v.com
    dhcp-option DOMAIN-SEARCH sxsw.com
  '';
}
