#!/bin/bash
filename=$1

IFS='/' read -ra orb <<< $filename
orbit_num=${orb[7]}
echo $orbit_num
while read first second third forth
do
    echo $third $forth
    data_loss=$(bc <<< "scale=5; ($forth*100)/$third")
    
done < $filename

echo $orbit_num $data_loss  >> data_loss_tele_error.txt



