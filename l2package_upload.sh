#!/bin/bash
user=root
password=C@dm1um
database=UPLOADDB

myvar=$(mysql $database -u $user -p$password<<<"SELECT Row_Num FROM upload_status ORDER BY Row_Num DESC LIMIT 1")
echo $myvar
myvar=$(echo $myvar | cut -d' ' -f2-)
echo $myvar
size=`du -sh /data2/czti/upload/LEVEL2AS1CZT20171124A04_037T03_9000001722.tar_V1.2 | cut -f -1`
echo $size
mysql $database -u $user -p$password<< EOF
INSERT INTO upload_status (Row_Num,OBS_ID,TAR_OR_XML,UPLOADED_DATE_TIME,SIZE) VALUES ($myvar+1,"20171031A04_137T01_9000001654" ,"LEVL1AS1CZT20171031G08_028T01_9000001656_dqr_V1.2.xml_dhdfxc_ewywy","2017-11-02 05:47:59","$size");

EOF
echo $(date "+%Y-%m-%d %H:%M:%S")
LIST=LEVL1AS1CZT20171031G08_028T01_9000001656_dqr_V1.2.xml
#LIST=LEVEL2AS1CZT20151110P01_127T01_9000000090.tar_V1.2
if echo "$LIST" | grep -q "xml"; then
  	obsid="${LIST%%_dqr*}";
	obsid="${obsid##*CZT}";
else
  	obsid="${LIST%%.tar*}";
	obsid="${obsid##*CZT}";
fi
echo $obsid
