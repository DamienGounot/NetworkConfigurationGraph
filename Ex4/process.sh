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
currentConf ="";
allowed_ligne = 0;
not_allowed_ligne = 0;
catalyst_index = 0;

	for(i=0;i<ligne;i++)
        {

        if(TAB[i][0] != currentConf)
        {
            currentConf = TAB[i][0];
            CATALYST[catalyst_index] = currentConf;
            catalyst_index++;
        }
		if(TAB[i][3] == "ALLOWED")
		{
			ALLOWED[allowed_ligne][0] = TAB[i][0];
			ALLOWED[allowed_ligne][1] = TAB[i][1];
			ALLOWED[allowed_ligne][2] = TAB[i][2];
			ALLOWED[allowed_ligne][3] = TAB[i][3];

			allowed_ligne++;
		}

		if(TAB[i][3] == "NOT_ALLOWED")
		{
			NOT_ALLOWED[not_allowed_ligne][0] = TAB[i][0];
			NOT_ALLOWED[not_allowed_ligne][1] = TAB[i][1];
			NOT_ALLOWED[not_allowed_ligne][2] = TAB[i][2];
			NOT_ALLOWED[not_allowed_ligne][3] = TAB[i][3];

			not_allowed_ligne++;
		}
        }

#----------------------------------------------------------------------------------
#	print " "	
#	print "TAB:"
#	print " "
   
        for(j=0;j<ligne;j++)
        {
#		print TAB[j][0] " " TAB[j][1] " " TAB[j][2] " " TAB[j][3]
        }

#	print " "
#	print "ALLOWED:"
#	print " "
   
        for(k=0;k<allowed_ligne;k++)
        {
#		print ALLOWED[k][0] " " ALLOWED[k][1] " " ALLOWED[k][2] " " ALLOWED[k][3]
        }

#	print " "
#	print "NOT_ALLOWED:"
#	print " "
   
        for(l=0;l<not_allowed_ligne;l++)
        {
#		print NOT_ALLOWED[l][0] " " NOT_ALLOWED[l][1] " " NOT_ALLOWED[l][2] " " NOT_ALLOWED[l][3] " " NOT_ALLOWED[l][4] " " NOT_ALLOWED[l][5]
        }	

#	print " "
#	print "CATALYST:"
#	print " "

        for(m=0;m<catalyst_index;m++)
        {
#		print CATALYST[m]
	}
#----------------------------------------------------------------------------------
current_CAT = "";
current_INTER = "";
current_VLAN = "";
is_alone = 1;

	for(n=0;n<allowed_ligne;n++)
	{
		current_CAT = ALLOWED[n][0];
		current_INTER = ALLOWED[n][1];
		current_VLAN = ALLOWED[n][2];
		
			for(p=0;p<allowed_ligne;p++)
			{

					if(((current_CAT != ALLOWED[p][0]) || (current_INTER != ALLOWED[p][1])) && (current_VLAN == ALLOWED[p][2]))
					{
						print current_CAT "-" current_INTER " " ALLOWED[p][0] "-" ALLOWED[p][1]
						is_alone = 0;
					}
			}

		if(is_alone)
		{
			print current_CAT "-" current_INTER " SOLO"
		}
		is_alone = 1;
	}

#--------------------------------------- PARTIE NOT ALLOWED ----------------------------------

current_CAT = "";
current_INTER = "";
current_VLAN = "";
is_alone = 1;




	for(q=0;q<catalyst_index;q++)
	{
		current_CAT = CATALYST[q];

		for(r=0;r<not_allowed_ligne;r++)
		{
		
         	  	 if(NOT_ALLOWED[r][0] == current_CAT)
		  	 {
				
				current_INTER = NOT_ALLOWED[r][1];
				current_VLAN = NOT_ALLOWED[r][2];

				for(s=0;s<not_allowed_ligne;s++)
				{

					if(current_CAT == NOT_ALLOWED[s][0])
					{

						if(current_VLAN == NOT_ALLOWED[s][2] && current_INTER != NOT_ALLOWED[s][1])
						{
						print current_CAT "-" current_INTER " " NOT_ALLOWED[s][0] "-" NOT_ALLOWED[s][1]
						is_alone = 0;
						}
						
					}
				}
				
				if(is_alone)
				{
					print current_CAT "-" current_INTER " SOLO"
				}
				is_alone = 1;
		
		  	}
		}



	}



	











}
' $*
