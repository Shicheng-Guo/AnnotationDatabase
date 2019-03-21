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
