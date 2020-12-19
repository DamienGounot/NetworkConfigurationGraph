#!/bin/bash

awk '
BEGIN {
    
    ligne = 0
}
{
    for (word=0;word<NF;word++)
    {
        TAB[ligne][word] = $(word+1);
    }
    


    ligne ++;
}
END{
    allowed_ligne = 0;
    access_ligne = 0;
    catalyst_index = 0;
    currentConf = "";

    for(j=0;j<ligne;j++)
    {
        if(TAB[j][0] != currentConf)
        {
            currentConf = TAB[j][0];
            CATALYST[catalyst_index] = currentConf;
            catalyst_index++;
        }

        if(TAB[j][3]=="allowed")
        {
            ALLOWED[allowed_ligne][0] = TAB[j][0];
            ALLOWED[allowed_ligne][1] = TAB[j][1];
            ALLOWED[allowed_ligne][2] = TAB[j][2];
            ALLOWED[allowed_ligne][3] = TAB[j][3];
            ALLOWED[allowed_ligne][4] = TAB[j][4];
            ALLOWED[allowed_ligne][5] = TAB[j][5];

            allowed_ligne ++;
        }

        if(TAB[j][3]=="access")
        {
            ACCESS[access_ligne][0] = TAB[j][0];
            ACCESS[access_ligne][1] = TAB[j][1];
            ACCESS[access_ligne][2] = TAB[j][2];
	    ACCESS[access_ligne][3] = TAB[j][3];
	    ACCESS[access_ligne][4] = TAB[j][4];
	    ACCESS[access_ligne][5] = TAB[j][5];
            access_ligne ++;
        }
    }

    #--------------------Fin Init des tableaux ------------------------------------



current_cat = "";
current_ether = "";
current_vlan = "";
is_allowed = 0;

		for(i= 0; i < catalyst_index ; i++)
		{
			current_cat = CATALYST[i];

			for(j= 0; j < access_ligne ; j++)
			{
				if(current_cat == ACCESS[j][0])
				{
					current_ether = ACCESS[j][2];
					current_vlan = ACCESS[j][5];
					is_allowed = "FALSE"

					for(f= 0; f < allowed_ligne ; f++)
					{
						if(current_cat == ALLOWED[f][0])
						{
							if(current_vlan == ALLOWED[f][5])
							{	is_allowed = 1;
								print current_cat " " current_ether " " current_vlan " ALLOWED"
															
							}
					
						}
					}


					if(is_allowed != 1)
					{
						print current_cat " " current_ether " " current_vlan " NOT_ALLOWED"
					}
				}

			}
			
		}
	


}
' $*
