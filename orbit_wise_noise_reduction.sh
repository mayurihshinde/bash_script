password="C@dm1um"
for i in `seq 938 2 938`
do 
	for j in `ls /data2/czti/level2/*9000000${i}*/czti/orbit | grep -v '_'`
	do
		fileM0evt=`ls /data2/czti/level2/*9000000${i}*/czti/orbit/${j}/modeM0/*cztM0_level2.evt`; 
		fileM0bunch=`ls /data2/czti/level2/*9000000${i}*/czti/orbit/${j}/modeM0/*cztM0_level2_bunch.fits`; 
		filemkf=`ls /data2/czti/level2/*9000000${i}*/czti/orbit/${j}/*czt_level2.mkf`; 
		echo $password
		if [[ -z $fileM0evt || -z $fileM0bunch || -z $filemkf ]]
		then
			echo For OBSID: 0000$i "********************* FILES NOT FOUND **************************"
		else
			echo "cztnoiseclean for" $fileM0evt;
		 	scp $filemkf cztipoc@192.168.11.168:/home/cztipoc/Mayuri/cztipoc/noise_reduction/data_for_testing/
			# $fileM0evt $fileM0bunch
		fi
	done
done
