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
        ASX_currenLine = TAB[j][0]
        IPX_currenLine = TAB[j][1]
        ASY_currenLine = TAB[j][2]
        IPY_currenLine = TAB[j][3]


        for(k=0;k<ligne;k++)
        {

            if(ASX_currenLine==TAB[k][2] && IPX_currenLine==TAB[k][3] && ASY_currenLine==TAB[k][0]&& IPY_currenLine==TAB[k][1])
            {
                print ASX_currenLine " " ASY_currenLine
            }
        }
    }

}
' $*
