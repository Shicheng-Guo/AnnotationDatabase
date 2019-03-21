#### Comprehensive human cell-type methylation atlas reveals origins of circulating cell-free DNA in health and disease

* [102 WGBS bigwig files](https://www.encodeproject.org/search/?type=Experiment&assay_title=WGBS&status=released&assembly=GRCh38&files.file_type=bigWig)



# Human_BLymphocyte
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
