# Exa-BGP
This is used to learn and test policies with the Internet routing table.

Default ExaBGP configuration.
```
process announce-routes {
    run python3 fullbgptable.py;
    encoder json;
}

template {
    neighbor exabgp {
        router-id 192.168.0.1;
        local-as 65000;
        local-address 192.168.0.1;
        family {
          ipv4 unicast;
        }
    }
}

neighbor 192.168.0.2 {
    inherit exabgp;
    peer-as 65001;
    family {
      ipv4 unicast;
    }
     capability {
		graceful-restart 1200;
	 }
}

neighbor 192.168.0.3 {
    inherit exabgp;
    peer-as 65002;
    family {
      ipv4 unicast;
    }
    capability {
		graceful-restart 1200;
	}
}
```
Configure neighbor node to match one listed
