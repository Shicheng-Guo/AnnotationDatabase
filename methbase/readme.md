#### Comprehensive human cell-type methylation atlas reveals origins of circulating cell-free DNA in health and disease

* [102 WGBS bigwig files](https://www.encodeproject.org/search/?type=Experiment&assay_title=WGBS&status=released&assembly=GRCh38&files.file_type=bigWig)



Human_B_Lymphocyte
```
wget http://smithdata.usc.edu/methbase/data/Ball-Human-2009/Human_BLymphocyte/tracks_hg19/Human_BLymphocyte.meth.bw -O  Human_BALL_Ball_Human-2009.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lee-Human-2015/Human_BALLhyperdiploid/tracks_hg19/Human_BALLhyperdiploid.meth.bw -O Human_BALL_hyperdiploid_Lee-Human-2015.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lee-Human-2015/Human_BALLETV6RUNX1/tracks_hg19/Human_BALLETV6RUNX1.meth.bw -O Human_BALL_ETV6RUNX1-Human-2015.meth.bw
cat  Human_BALL_*.wig > HUman_BALL_WGBS.wig
grep -v '#' HUman_BALL_WGBS.wig > HUman_BALL_WGBS.wig.bed
perl wigAverage.pl HUman_BALL_WGBS.wig.bed > HUman_BALL_WGBS.wig.bed.uni
bedtools sort -i HUman_BALL_WGBS.wig.bed.uni > HUman_BALL_WGBS.wig.bed.uni.sort
echo 'track type=bedGraph name="AML" description="AML" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > HUman_BALL_WGBS.wig.bed.uni.sort.UCSC
cat  HUman_BALL_WGBS.wig.bed.uni.sort >> HUman_BALL_WGBS.wig.bed.uni.sort.UCSC
head HUman_BALL_WGBS.wig.bed.uni.sort.UCSC
gzip HUman_BALL_WGBS.wig.bed.uni.sort.UCSC
```

AML 
```
wget http://smithdata.usc.edu/methbase/data/Akalin-Human-2012/Human_AML/tracks_hg19/Human_AML.meth.bw -O Human_AML_Akalin-Human-2012.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lund-Human-2014/Human_AML3-Control/tracks_hg19/Human_AML3-Control.meth.bw -O Human_AML3_Lund-Human-2014.meth.bw
cat  Human_AML*.wig > HUman_AML_WGBS.wig
grep -v '#' HUman_AML_WGBS.wig > HUman_AML_WGBS.wig.bed
perl wigAverage.pl HUman_AML_WGBS.wig.bed > HUman_AML_WGBS.wig.bed.uni
bedtools sort -i HUman_AML_WGBS.wig.bed.uni > HUman_AML_WGBS.wig.bed.uni.sort
echo 'track type=bedGraph name="AML" description="AML" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > HUman_AML_WGBS.wig.bed.uni.sort.UCSC
cat  HUman_AML_WGBS.wig.bed.uni.sort >> HUman_AML_WGBS.wig.bed.uni.sort.UCSC
head HUman_AML_WGBS.wig.bed.uni.sort.UCSC
gzip HUman_AML_WGBS.wig.bed.uni.sort.UCSC
```

Normal pancrease and pancreatic cancer
```
for i in {1..12}
do
wget http://smithdata.usc.edu/methbase/data/Thompson-Human-2015/Human_PancreaticCancer$i/tracks_hg19/Human_PancreaticCancer$i.meth.bw &
done
wget http://smithdata.usc.edu/methbase/data/Thompson-Human-2015/Human_NormalPancreas1/tracks_hg19/Human_NormalPancreas1.meth.bw
wget http://smithdata.usc.edu/methbase/data/Thompson-Human-2015/Human_NormalPancreas2/tracks_hg19/Human_NormalPancreas2.meth.bw

cat *_PancreaticCancer*.wig > PANcreaticCancer.wig
grep -v '#' PANcreaticCancer.wig > PANcreaticCancer.wig.bed
perl wigAverage.pl PANcreaticCancer.wig.bed > PANcreaticCancer.wig.bed.uni
bedtools sort -i PANcreaticCancer.wig.bed.uni > PANcreaticCancer.wig.bed.uni.sort
echo 'track type=bedGraph name="PancreaticCancer" description="_PancreaticCancer" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > PANcreaticCancer.wig.bed.uni.sort.UCSC
cat  PANcreaticCancer.wig.bed.uni.sort >> PANcreaticCancer.wig.bed.uni.sort.UCSC
head PANcreaticCancer.wig.bed.uni.sort.UCSC
gzip PANcreaticCancer.wig.bed.uni.sort.UCSC

cat *_NormalPancreas*.wig > NormalPancreas.wig
grep -v '#' NormalPancreas.wig > NormalPancreas.wig.bed
perl wigAverage.pl NormalPancreas.wig.bed > NormalPancreas.wig.bed.uni
bedtools sort -i NormalPancreas.wig.bed.uni > NormalPancreas.wig.bed.uni.sort
echo 'track type=bedGraph name="PancreaticCancer" description="_PancreaticCancer" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > PANcreaticCancer.wig.bed.uni.sort.UCSC
cat  PANcreaticCancer.wig.bed.uni.sort >> PANcreaticCancer.wig.bed.uni.sort.UCSC
head PANcreaticCancer.wig.bed.uni.sort.UCSC
gzip PANcreaticCancer.wig.bed.uni.sort.UCSC
```
PBMC
```
wget http://smithdata.usc.edu/methbase/data/Li-PBMC-2010/Human_PBMC/tracks_hg19/Human_PBMC.meth.bw -O Human_PBMC_Li2010.bw &
wget http://smithdata.usc.edu/methbase/data/Heyn-Human-NewbornCentenarian-2012/Human_PBMC/tracks_hg19/Human_PBMC.meth.bw -O Human_PBMC_Heyn2012.meth.bw &
wget http://smithdata.usc.edu/methbase/data/Heyn-Human-NewbornCentenarian-2012/Human_CD4T-100yr/tracks_hg19/Human_CD4T-100yr.meth.bw -O Human_CD4T-100yr.meth.bw
wget http://smithdata.usc.edu/methbase/data/Heyn-Human-NewbornCentenarian-2012/Human_CD4T-Newborn/tracks_hg19/Human_CD4T-Newborn.meth.bw -O 
wget http://smithdata.usc.edu/methbase/data/Pacis-Human-2015/Human_DendriticCell/tracks_hg19/Human_DendriticCell.meth.bw -O Human_DendriticCell_hg19.meth.bw

cat Human_PBMC_*wig > HUman_PBMC_hg19.wig
grep -v '#' HUman_PBMC_hg19.wig > HUman_PBMC_hg19.wig.bed
perl wigAverage.pl HUman_PBMC_hg19.wig.bed > HUman_PBMC_hg19.wig.bed.uni
bedtools sort -i HUman_PBMC_hg19.wig.bed.uni > HUman_PBMC_hg19.wig.bed.uni.sort
echo 'track type=bedGraph name="PBMC" description="PBMC" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > HUman_PBMC_hg19.wig.bed.uni.sort.UCSC
cat  HUman_PBMC_hg19.wig.bed.uni.sort >> HUman_PBMC_hg19.wig.bed.uni.sort.UCSC
head HUman_PBMC_hg19.wig.bed.uni.sort.UCSC
gzip HUman_PBMC_hg19.wig.bed.uni.sort.UCSC

cat Human_CD4T*wig > HUman_CD4T_hg19.wig
grep -v '#' HUman_CD4T_hg19.wig > HUman_CD4T_hg19.wig.bed
perl wigAverage.pl HUman_CD4T_hg19.wig.bed > HUman_CD4T_hg19.wig.bed.uni
bedtools sort -i HUman_CD4T_hg19.wig.bed.uni > HUman_CD4T_hg19.wig.bed.uni.sort
echo 'track type=bedGraph name="CD4+" description="CD4+" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > HUman_CD4T_hg19.wig.bed.uni.sort.UCSC
cat  HUman_CD4T_hg19.wig.bed.uni.sort >> HUman_CD4T_hg19.wig.bed.uni.sort.UCSC
head HUman_CD4T_hg19.wig.bed.uni.sort.UCSC
gzip -f HUman_CD4T_hg19.wig.bed.uni.sort.UCSC

SID="HUman_B_Cell_hg19"
cat Human_BCell*wig > $SID.wig
grep -v '#' $SID.wig > $SID.wig.bed
perl wigAverage.pl $SID.wig.bed > $SID.wig.bed.uni
bedtools sort -i $SID.wig.bed.uni > $SID.wig.bed.uni.sort
echo 'track type=bedGraph name="Human_B_Cell" description="Human_B_Cell" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > $SID.wig.bed.uni.sort.UCSC
cat  $SID.wig.bed.uni.sort >> $SID.wig.bed.uni.sort.UCSC
head $SID.wig.bed.uni.sort.UCSC
gzip -f $SID.wig.bed.uni.sort.UCSC

SID="Human_Neutrophil_hg19"
cat Human_Neut*bw.wig > $SID.wig
grep -v '#' $SID.wig > $SID.wig.bed
perl wigAverage.pl $SID.wig.bed > $SID.wig.bed.uni
bedtools sort -i $SID.wig.bed.uni > $SID.wig.bed.uni.sort
echo 'track type=bedGraph name="Human_Neutrophil" description="Human_Neutrophil" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > $SID.wig.bed.uni.sort.UCSC
cat  $SID.wig.bed.uni.sort >> $SID.wig.bed.uni.sort.UCSC
head $SID.wig.bed.uni.sort.UCSC
gzip -f $SID.wig.bed.uni.sort.UCSC
```
