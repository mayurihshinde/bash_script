#!/bin/bash
orbit_num=$1

mkffile=$(find $orbit_num/ -name "*level2.mkf")

bcevt=$(find $orbit_num/ -name "*bc.evt")
if [ -z $mkffile ];
then
	echo "Mkf file is not available"
	exit
fi
if [ -z $bcevt ];
then
	echo "Bunch clean file is not available"
	exit
fi
#gti generation
gtifile=`echo $mkffile|sed 's/level2.mkf/level2.gti/'`
gtifile=$(basename $gtifile)
echo $gtifile
gti_generation_with_saa $mkffile $gtifile

common_bc_ds_evt=`echo $bcevt|sed 's/bc.evt/common_bc_ds.evt/'`
common_bc_ds_evt=$(basename $common_bc_ds_evt)

cztdatasel infile=$bcevt gtifile=$gtifile gtitype="COMMON" outfile=$common_bc_ds_evt clobber="y" history="y"

bunch_clean_livetime=$(find $orbit_num/ -name "*bc_livetime.fits")
echo $bunch_clean_livetime

common_pc_evt=`echo $common_bc_ds_evt|sed 's/common_bc_ds.evt/common_bc_ds_pc.evt/'`
common_pc_evt=$(basename $common_pc_evt)
echo $common_pc_evt

common_livetime=`echo $common_bc_ds_evt|sed 's/common_bc_ds.evt/common_livetime.fits/'`
common_livetime=$(basename $common_livetime)
echo $common_livetime

common_badpix=`echo $common_bc_ds_evt|sed 's/common_bc_ds.evt/common_badpix.fits/'`
common_badpix=$(basename $common_badpix)
echo $common_badpix

cztpixclean par_infile=$common_bc_ds_evt par_inlivetimefile=$bunch_clean_livetime par_outfile1=$common_pc_evt  par_outlivetimefile=$common_livetime  par_badpixfile=$common_badpix par_nsigma=5 par_det_tbinsize=1 par_pix_tbinsize=1 par_det_count_thresh=80 par_pix_count_thresh=5 


common_clean_evt=`echo $common_bc_ds_evt|sed 's/common_bc_ds.evt/common_clean.evt/'`
common_clean_evt=$(basename $common_clean_evt)
cztevtclean infile=$common_pc_evt outfile=$common_clean_evt alphaval="0" vetorange="0" clobber="y" isdoubleEvent="n" history="y"


rm $common_pc_evt $common_livetime $common_badpix $common_bc_ds_evt 
