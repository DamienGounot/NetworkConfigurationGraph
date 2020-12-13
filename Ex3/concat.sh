#!/bin/bash

awk 'BEGIN{
    ligne =0;
}
{
    for (word=0;word<(NF);word++)
    {
        TAB[ligne][word] = $(word+1);
    }
    ligne ++;
}
END{

    interface_ligne = 0;
    peer_ligne = 0;
    conf_index = 0;
    currentConf = "";

    for(j=0;j<ligne;j++)
    {
        if(TAB[j][0] != currentConf)
        {
            currentConf = TAB[j][0];
            CONF[conf_index] = currentConf;
            conf_index++;
        }

        if(TAB[j][1]=="interface")
        {
            INTERFACE[interface_ligne][0] = TAB[j][0];
            INTERFACE[interface_ligne][1] = TAB[j][2];
            INTERFACE[interface_ligne][2] = TAB[j][3];
            interface_ligne ++;
        }

        if(TAB[j][2]=="peer")
        {
            PEER[peer_ligne][0] = TAB[j][0];
            PEER[peer_ligne][1] = TAB[j][1];
            PEER[peer_ligne][2] = TAB[j][3];
            peer_ligne ++;
        }
    }

    #--------------------Fin Init des tableaux ------------------------------------

# print "TAB: "
# print " "

    for(m=0;m<ligne;m++)
    {
#        print TAB[m][0] " " TAB[m][1] " " TAB[m][2] " " TAB[m][3] " " TAB[m][4]
    }

#    print " "
#    print "INTERFACE: "
#    print " "

    for(k=0;k<interface_ligne;k++)
    {   
#        print  INTERFACE[k][0] " " INTERFACE[k][1] " " INTERFACE[k][2]
    }


   # print " "
   # print "PEER: "
   # print " "

        for(l=0;l<peer_ligne;l++)
        {
   #         print  PEER[l][0] " " PEER[l][1] " " PEER[l][2]
        }

    #print " "
    #print "CONF: "
    #print " "

        for(r=0;r<conf_index;r++)
        {
    #        print  CONF[r]
        }

    #--------------------Fin du Display des tableaux (pour debug)------------------------------------


    ConfActuelle = "";
    IPActuelle = "";
    CipherActuel = "";

    for(boucle_conf = 0; boucle_conf < conf_index; boucle_conf++)
    {
        ConfActuelle = CONF[boucle_conf];

        for(boucle_interface = 0; boucle_interface < interface_ligne ; boucle_interface++)
        {

            if(INTERFACE[boucle_interface][0] == ConfActuelle)
            {
                IPActuelle = INTERFACE[boucle_interface][1];
                CipherActuel = INTERFACE[boucle_interface][2];

                for(boucle_peer = 0 ; boucle_peer < peer_ligne ; boucle_peer ++ )
                {
                    if(PEER[boucle_peer][0] == ConfActuelle && PEER[boucle_peer][1] == CipherActuel)
                    {
                        print  IPActuelle " " PEER[boucle_peer][2]
                    }
                }

            }

        }
    }

}' $*

