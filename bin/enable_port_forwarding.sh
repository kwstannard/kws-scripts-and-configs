#! /bin/bash

pfctl -s nat > /tmp/pf.conf.old
echo "$(pfctl -s nat)
rdr pass inet proto tcp from any to any port 80 -> 127.0.0.1 port 8080
" | pfctl -ef -
pfctl -s nat
