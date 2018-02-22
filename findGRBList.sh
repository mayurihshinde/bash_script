#!/bin/bash
#curl http://astrosat.iucaa.in/czti/?q=grb -o "arrival.txt"
filename=./arrival1.txt
filename1=./arrival2.txt
#src=/data2/czti/special/
#download=~/Desktop/priya/GRBdownload1

string=`cat arrival.txt | grep "CZTI_lightcurves" | sed -r 's/.*(GRB[0-9]+[A-Z]).*/\1/g'`



echo "next O/P"
   echo $string >>$filename


'''
  for f in $string
  do
       bcevt=$(find $src/ -name "$f")
       echo $bcevt >>$filename1
       #cp -r $bcevt $download
       
 #ls $bcevt |cut -d' ' -f2
#for f in $bcevt
#        do 
#echo -e "\nsample.sh: $USER $(date "+%Y-%m-%d %H:%M:%S"):: adding $f to $download"  
# echo $f>>$download
#done

       done
#tr [:blank:] '\n' < arrival1.txt


 
 #sed -r 's/.*(GRB[0-9]+[A-Z]).*/\1/g' arrival1.txt
#ls $filename| find -name "GRB"
 #echo $s1
 #echo $string
#fi
'''
