#!/bin/bash

awk '
BGEINFILE {
    hostname = "";
    current_client = "";
}
{
    if ($1 == "hostname") {
        hostname = $2;
    }
    if ($1 == "ip" && $2 == "vrf") {
        current_client = hostname"-"$3;
    }

    if (current_client != "" && $1 == "route-target") {
        print current_client" "$2" "$3;
    }

    if (current_client != "" && $0 == "!") {
        current_client = "";
    }
}
' $*
