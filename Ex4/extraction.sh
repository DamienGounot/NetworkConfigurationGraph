#!/bin/bash

awk 'BEGIN{

    hostname_name ="";

    in_interface = 0;
    interfacename ="";
    allowed_vlan = "";
    access_vlan = "";

}
{
    
    if($1 == "!")
    {
        if(in_interface)
        {
		    in_interface = 0;
        }
        
    }

	if($1 == "interface")
	{
        	in_interface = 1;
		interfacename = $2;
	}

    if($1 == "hostname")
	{
        	hostname_name = $2;
	}


    if(in_interface && $0 ~ /^[ ]/)
    {
        if($3 == "allowed" && $4 == "vlan")
        {
            allowed_vlan = $5;
            print hostname_name " interface " interfacename " allowed vlan " allowed_vlan
        }

	if($2 == "access" && $3 == "vlan")
	{
	    access_vlan = $4;
	    print hostname_name " interface " interfacename " access vlan " access_vlan
	}

    }

}END{

}' $*

