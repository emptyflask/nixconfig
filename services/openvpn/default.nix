{
  servers = {
    # systemctl {start|stop} openvpn-{attr}.service
    pia-us-texas = import ./pia/us/texas;
    pia-uk-london = import ./pia/uk/london;
    # sxsw = { config = '' config /root/vpn/sxsw/sxsw.ovpn ''; };
  };
}
