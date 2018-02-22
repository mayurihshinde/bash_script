level2dir=/data2/czti/level2
path=$level2dir/*$1*/czti/
cur_dir=`pwd`
echo $path
new_version=1.2
cd $path
echo "****************Observation ID is $1*************************"
total=`find ./ -name *M0_level2_bc.evt -o -name *M0_level2_quad_clean_weight.evt -o -name *M0_level2.aspect_Q2 -o -name *M0_level2_quad_clean_Q2.pha -o -name *M0_level2_quad_clean_Q1.lc -o -name *M0_level2.hdr -o -name *M0_level2_quad_clean_Q3.pha -o -name *M0_level2.aspect_Q1 -o -name *M0_level2.aspect_Q0 -o -name *M0_level2_quad_clean.img_Q1 -o -name *M0_level2_quad_clean_Q1.pha -o -name *M0_level2_quad_clean.img_Q2 -o -name *M0_level2_quad_clean.img_Q0 -o -name *M0_level2_quad_clean_Q2.lc -o -name *M0_level2_quad_clean.dpi -o -name *M0_level2_quad_clean.img_Q3 -o -name *M0_level2.gti -o -name *M0_level2_quad_badpix.fits -o -name *M0_level2_quad_clean.evt -o -name *M0_level2_quad_clean_Q0.pha -o -name *M0_level2_quad_clean_Q3.lc  -o -name *M0_level2_quad_clean_Q0.lc -o -name *M0_level2.aspect_Q3 -o -name *level1_mcap.xml -o -name *level2.mkf -o -name *.lbt -o -name *.att -o -name *.orb -o -name *.tct -o -name *SS_level2.fits -o -name *level2_quad_clean_Q0.rsp -o -name *level2_quad_clean_Q1.rsp -o -name *level2_quad_clean_Q2.rsp -o -name *level2_quad_clean_Q3.rsp -o -name *dqr_$new_version.xml -o -name *M0_level2_bc_livetime.fits -o -name *M0_level2_quad_livetime.fits | grep -v orbit|grep -v _V |wc -l`
echo "Total count = $total"

cztiCount=`find ./ -name *level1_mcap.xml -o -name *level2.mkf -o -name *dqr_$new_version.xml| grep -v orbit|grep -v _V |wc -l`
echo "czti count = $cztiCount"


cd modeM0
modeM0Count=`find ./ -name *M0_level2_bc.evt -o -name *M0_level2_quad_clean_weight.evt -o -name *M0_level2.aspect_Q2 -o -name *M0_level2_quad_clean_Q2.pha -o -name *M0_level2_quad_clean_Q1.lc -o -name *M0_level2.hdr -o -name *M0_level2_quad_clean_Q3.pha -o -name *M0_level2.aspect_Q1 -o -name *M0_level2.aspect_Q0 -o -name *M0_level2_quad_clean.img_Q1 -o -name *M0_level2_quad_clean_Q1.pha -o -name *M0_level2_quad_clean.img_Q2 -o -name *M0_level2_quad_clean.img_Q0 -o -name *M0_level2_quad_clean_Q2.lc -o -name *M0_level2_quad_clean.dpi -o -name *M0_level2_quad_clean.img_Q3 -o -name *M0_level2.gti -o -name *M0_level2_quad_badpix.fits -o -name *M0_level2_quad_clean.evt -o -name *M0_level2_quad_clean_Q0.pha -o -name *M0_level2_quad_clean_Q3.lc  -o -name *M0_level2_quad_clean_Q0.lc -o -name *M0_level2.aspect_Q3 -name *M0_level2_bc_livetime.fits -o -name *M0_level2_quad_livetime.fits | grep -v orbit|grep -v _V |wc -l`
echo "Mode M0 count = $modeM0Count"


cd ../modeSS/
modeSSCount=`find ./ -name *SS_level2.fits | grep -v orbit|grep -v _V |wc -l`
echo "Mode SS count = $modeSSCount"

cd ../aux/
auxCount=`find ./ -name *.lbt -o -name *.att -o -name *.orb -o -name *.tct | grep -v orbit|grep -v _V |wc -l`
echo "Aux count = $auxCount"
cd $cur_dir
echo "*************************END*************************"
