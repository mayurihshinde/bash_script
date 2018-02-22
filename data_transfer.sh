#Script for Transferring the data from local storage(data2) to ddn & vice a versa for processing
#wtitten by: Aditi Kotibhaskar
#Modified by: Mayuri Shinde
#Date:11/10/2017	

#Take Source and Destination from command line
#Command line Arguments:   1.	SOURCE DIRECTORY : from where the data has to be copied. It should contain the ObsID with path.	
# 			   2.	DESTINATION DIRECTORY : to where the data will be copied.

#Get command line inputs for source & destination directories
SRC=$1	# Directory path with ObsID
DEST=$2	# Only directory path

#Get the ObsID name
obsid=$(basename $SRC)
if echo "$obsid" | grep -q "900000"; then
	echo ""
else
	echo "Invalid ObsID : ' $obsid '"
	echo "Please check the ObsID name"
	exit
fi
#Source directory path without ObsID
SRC=${SRC%/$obsid*}

#Check whether /data2 is source or destination for linking or unlinking
if echo "$SRC" | grep -q "data2"; then
	link=1	#Make a soft link at /data2 after moving data to the destination
else
	if echo "$DEST" | grep -q "data2"; then
		link=0 #Remove a soft link at /data2 after moving data from the Source
		unlink $DEST/$obsid
	else
		echo "This script can be used to transfer the data to & from /data2 only."
		echo "Kindly enter the valid paths for Source & Destination directories."
	fi
fi

#Copy the directory from source to destination if present
if [ -d "$SRC/$obsid" ]; then
	#Display the inputs from user
	echo "*********************** Data Transfer Script ************************"
	echo "Data transfer from      :" $SRC/$obsid
	echo "                to      :" $DEST/$obsid
	echo "*********************************************************************"

	#Save the path of Current Working directory
	cur_dir=`pwd`
	#Remove data if already present
	if [ -d "$DEST/$obsid" ]; then
		echo "Removing Destination directory as present already. :" $DEST/$obsid	#Removing Destination directory if present already.
		/bin/rm -rf $DEST/$obsid		#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& Change this to /bin/rm for Rohini
	fi
	#Copy the directory
	cp -r $SRC/$obsid $DEST/
	#Check whether the data is copied well or not
	
	SRC_count=`ls $SRC/$obsid/* | wc -l`	#Calculate count of files in source directory
	DEST_count=`ls $DEST/$obsid/* | wc -l`	#Calculate count of files in destination directory
	echo SRC_count=$SRC_count
	echo DEST_count=$DEST_count
	if [ $SRC_count -eq $DEST_count ]; then		#No. of files copied are matching
		#Check md5sum for each file
		echo "Checking md5sum for each file.."
		cd $SRC/$obsid
		find ./ -type f -exec md5sum {} \;|sort > "$cur_dir/dir1.txt"	#List checksums of all files in Source Directory
		cd $DEST/$obsid
		find ./ -type f -exec md5sum {} \;|sort > "$cur_dir/dir2.txt"	#List checksums of all files in Source Directory
		cd $cur_dir
		diff dir1.txt dir2.txt > diff.txt		# Find difference in checksums of two directories
		/bin/rm dir1.txt dir2.txt
		if [ -s diff.txt ]; then	#Print the differences in checksums if any
			echo "Differences in checksums are:"
			cat diff.txt
			/bin/rm diff.txt
			echo "??????????? Differences found in checksums ???????????"
			exit
		else				#Data is copied successfully.
			echo Data is Copied well
			echo "Removing Source directory :" $SRC/$obsid		#Removing Source directory as data is copied successfully
			/bin/rm -rf $SRC/$obsid			#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& Change this to /bin/rm for Rohini
			if [ $link -eq 1 ]; then
				ln -s $DEST/$obsid $SRC		#Create soft link of destination at source dir
				echo "Created a soft link of" $DEST/$obsid "at" $SRC/$obsid
			fi
		fi
		/bin/rm diff.txt
	else
		#Checking for the files that are not copied
		echo "Some files are missing.. Checking for the files that are not copied.."
		cd $SRC/$obsid
		find ./ -type f -exec cat {} \;|sort > "$cur_dir/dir1.txt"	#List all files in Source Directory
		cd $DEST/$obsid
		find ./ -type f -exec cat {} \;|sort > "$cur_dir/dir2.txt"	#List all files in Destination Directory
		cd $cur_dir
		echo "Differences are:"
		diff dir1.txt dir2.txt		#Display the differnces in files of source and destination directory
		/bin/rm dir1.txt dir2.txt
		echo "??????????? Differences found in number of files in the directories ???????????"
		exit
	fi
else
	echo "??????????? Directory" $SRC/$obsid "is not available for copying ???????????"
	exit
fi
