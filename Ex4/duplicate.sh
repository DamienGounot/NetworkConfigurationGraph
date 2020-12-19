#!/bin/bash

awk 'BEGIN{

	interface_name = "";
	hostname_name = "";
}
{
	if($4 == "allowed" && $5 =="vlan")
	{

		interface_name = $3;
		hostname_name = $1;

		for(i = 6;i<=NF;i++)
		{
			print hostname_name " interface "  interface_name  " allowed vlan " $i
		}
	}else
	{
		print $0	
	}

	




}END{

}' $*

