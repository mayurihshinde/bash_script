#!/bin/bash

evtfile=$1
directory="/data2/czti/level2"
outputdirectory="/data2/czti/testarea/Mayuri/crabPhaseSingleEvents"

rasrc=$2
decsrc=$3 

if [ -z "$1" ]
  then
    echo "Please give input event file."

elif [ -z "$2" ]
  then
    echo "Please give RA value."

elif [ -z "$3" ]
  then
    echo "Please give Dec value."

else
	obsid=`ls $evtfile | cut -d '_' -f 3 | sed 's/cztM0//'`
	      mkffile=`ls $directory/*$obsid*/czti/*.mkf`
	      badpixfile=`ls $directory/*$obsid*/czti/modeM0/*_level2_common_badpix.fits`
	      livetimefile=`ls $directory/*$obsid*/czti/modeM0/*_level2_common_livetime.fits`
	      outfile=`echo $livetimefile|sed 's/level2_common_livetime.fits/level2_grb.evt/'`
	      outfile="$outputdirectory/$(basename $outfile)"
	      outevtfile=`echo $livetimefile|sed 's/level2_common_livetime.fits/level2_weight_grb.evt/'`
	      outevtfile="$outputdirectory/$(basename $outevtfile)"
	      
	      echo $badpixfile
	      echo $livetimefile
	      echo $outfile
	      echo $outevtfile
	      echo $evtfile
	      cztbindata inevtfile=$evtfile mkffile=$mkffile badpixfile=$badpixfile livetimefile=$livetimefile outfile=$outfile outevtfile=$outevtfile maskWeight=y rasrc=$rasrc decsrc=$decsrc         badpixThreshold=0 outputtype=spec
	
fi


