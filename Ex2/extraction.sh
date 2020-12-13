#!/bin/bash

awk '
BGEINFILE {
    current_as = "";
    current_ip = "";
    remote_as = "";
    remote_ip = "";
}
{
    if ($1 == "ip" && $2 == "address") {
        current_ip = $3;
    }
    if ($1 == "router" && $2 == "bgp") {
        current_as = $3;
    }
    if ($1 == "neighbor" && $3 == "remote-as") {
        remote_as = $4;
        remote_ip = $2;
    }

    if (current_as != "" && $3 == "remote-as") {
        print "AS"current_as" "current_ip" AS" remote_as" "remote_ip;
    }

    if (current_as != "" && $0 == "!") {
        current_as = "";
    }
}
' $*
