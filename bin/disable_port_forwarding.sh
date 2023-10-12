#! /bin/bash

cat /tmp/pf.conf.old | pfctl -ef -
pfctl -s nat
