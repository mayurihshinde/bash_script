#!/bin/bash

for egrb in `cat ~/czti/trunk/users/mayuri/bash_script/existingGRBList`;
do
	if grep -q $egrb ~/czti/trunk/users/mayuri/bash_script/latestGRBList
	then
   	 echo $egrb
   	else 
   	 echo $egrb >> GRBDiff.txt
	fi
done;
for lgrb in `cat ~/czti/trunk/users/mayuri/bash_script/latestGRBList`;
do
	if grep -q $lgrb ~/czti/trunk/users/mayuri/bash_script/existingGRBList
	then
   	 echo $lgrb
   	else 
   	 echo $lgrb >> GRBDiff.txt
	fi
done;
