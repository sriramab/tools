# -*- coding: utf-8 -*-
"""
Created on Sat Mar 25 18:09:45 2017

@author: Srirama
"""

import sys
filename = sys.argv[-1]

mylist = []
with open(filename) as f:
    for line in f:
        if line.strip():
           # mylist.append(line.split(None, 1)[0])
            mylist.append(line.split(None,1))
            
for l in range(1,len(mylist) ):
    if len(mylist[l])>1 :
        if mylist[l][0] in ['float', 'int', 'map', 'list', 'file', 'path', 'geometry']:        
            print(l, mylist[l][0] , mylist[l][1])
            
            
thefile = open('result.txt', 'w')

for l in range(1,len(mylist) ):
    if len(mylist[l])>1 :
        if mylist[l][0] in ['float', 'int', 'map', 'list', 'file', 'path', 'geometry']:        
           # print(l, mylist[l][0] , mylist[l][1])
            whattowrite = str(l)+ str(" ") +mylist[l][0] + str(" ")  + mylist[l][1]
            #print whattowrite
            thefile.write(whattowrite + '\n' )
            #thefile.write("%s\n" % item)

thefile.close()
  