#!/bin/bash
upload_queue_file=$CZTIMONITOR/queues/l2archive_upload.queue
touch $upload_queue_file || exit
upload_script=$CZTIMONITOR/scripts/upload/upload.sh
level2dir=/data2/czti/level2
l2package_upload_sh_log=$CZTIMONITOR_PLOG/l2package_upload_sh.log
delay=5
dest="/issdc/ext/public/as1/poc_access/iucaa/in/payload_data/level2/czt"
user=root
password=C@dm1um
database=UPLOADDB

last_row=$(mysql $database -u $user -p$password<<<"SELECT Row_Num FROM upload_status ORDER BY Row_Num DESC LIMIT 1")
echo $last_row
last_row=$(echo $last_row | cut -d' ' -f2-)
echo $last_row

while true;
do
	file=$(head  -n 1 $upload_queue_file)
	if [ ! -z $file ]; then

		$upload_script $file $dest
		ufile=$(basename $file)
		if echo "$ufile" | grep -q "xml"; then
			obsid="${LIST%%_dqr*}";
			obsid="${obsid##*CZT}";
		else
			obsid="${LIST%%.tar*}";
			obsid="${obsid##*CZT}";
		fi

		`sed -i  "/${ufile}/d" $upload_queue_file `
		echo "l2package_upload.sh $USER $(date "+%Y-%m-%d %H:%M:%S"):: $file has been uploaded sucessfully...">>$l2package_upload_sh_log
		echo "l2package_upload.sh $USER $(date "+%Y-%m-%d %H:%M:%S"):: $file has been uploaded sucessfully..."
		size=`du -sh $file | cut -f -1`
		echo $size	
		mysql $database -u $user -p$password<< EOF
		INSERT INTO upload_status (Row_Num,OBS_ID,TAR_OR_XML,UPLOADED_DATE_TIME,SIZE) VALUES ($last_row+1,$obsid,$ufile,$(date "+%Y-%m-%d %H:%M:%S"),$file);
EOF
	fi
	sleep $delay
 	
done;


