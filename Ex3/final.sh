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
   
    for(j=0;j<ligne;j++)
    {
        IPsrc_currenLine = TAB[j][0]
        IPdst_currenLine = TAB[j][1]

        for(k=0;k<ligne;k++)
        {
            if(IPsrc_currenLine == TAB[k][1] && IPdst_currenLine == TAB[k][0])
            {
                print IPsrc_currenLine " " IPdst_currenLine
                print IPdst_currenLine " " IPsrc_currenLine
            }
        }
    }

}
' $*
