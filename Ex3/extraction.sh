#!/bin/bash

awk 'BEGIN{

    hostname_name ="";

    in_interface = 0;
    interfacename ="";
    interfacecipher ="";

    in_cryptomap = 0;
    cyphername = "";
    peername = "";
}
{
    
    if($1 == "!")
    {
        if(in_interface)
        {
		    in_interface = 0;
        }
        
        if(in_cryptomap)
        {
		    in_cryptomap = 0;
        }

    }

	if($1 == "interface")
	{
        	in_interface = 1;
	}

    if($1 == "hostname")
	{
        	hostname_name = $2;
	}

	if($1 == "crypto" && $2 == "map")
	{
        	in_cryptomap = 1;
            cyphername = $3;
	}

    if(in_interface && $0 ~ /^[ ]/)
    {
        if($1 == "crypto" && $2 == "map")
        {
            interfacecipher = $3;
            print hostname_name " interface " interfacename " " interfacecipher
        }

        if($1 == "ip" && $2 == "address")
        {
            interfacename = $3;
        }
    }

    if(in_cryptomap && $0 ~ /^[ ]/)
    {
        if($1 == "set" && $2 == "peer")
        {
            peername = $3;
            print hostname_name " " cyphername " peer " peername
        }
    }

}END{

}' $*

