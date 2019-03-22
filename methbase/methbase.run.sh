track type=bedGraph name=H1299_NSCLC description=Human_NSCLC_H1299 
 autoScale=off maxHeightPixels=128:64:32 visibility=full 

browser position chr19:49302001-49304701
browser pack refGene encodeRegions
track type=bedGraph name="BedGraph Format" description="BedGraph format" visibility=full color=0,100,200 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full 
chr19 49302000 49302300 -1.0
chr19 49302300 49302600 -0.75

# bw2wig
mkdir temp
for i in `ls *bw`
do
echo \#PBS -N $i  > ./temp/$i.job
echo \#PBS -l nodes=1:ppn=1 >> ./temp/$i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> ./temp/$i.job
echo \#PBS -m abe  >> ./temp/$i.job
echo \#PBS -o $(pwd)/temp/ >>./temp/$i.job
echo \#PBS -e $(pwd)/temp/ >> ./temp/$i.job
echo cd $(pwd) >> ./temp/$i.job 
echo bigWigToWig $i $i.wig >> ./temp/$i.job
qsub ./temp/$i.job
done

awk '{print FILENAME,$7,$1":"$11,$13}' OFS="\t" *multianno.txt.bed.vep.bed > cBioPortal.input.txt

ADRA1A chr8:26,723,345-26,723,990
# PBMC 
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


# Colon cancer (CRC)
wget http://smithdata.usc.edu/methbase/data/Berman-Human-2012/Human_ColonNormal/tracks_hg19/Human_ColonNormal.meth.bw -O Human_ColonNormal_Berman-Human-2012.meth.bw
wget http://smithdata.usc.edu/methbase/data/Hansen-Human-2011/Human_ColonicMucosa/tracks_hg19/Human_ColonicMucosa.meth.bw -O Human_ColonicMucosa_Hansen-Human-2011.meth.bw
wget http://smithdata.usc.edu/methbase/data/Hansen-Human-2011/Human_AdenoPolyp/tracks_hg19/Human_AdenoPolyp.meth.bw -O Human_AdenoPolyp_Hansen-Human-2011.meth.bw

wget http://smithdata.usc.edu/methbase/data/Berman-Human-2012/Human_ColonCancer/tracks_hg19/Human_ColonCancer.meth.bw -O Human_ColonCancer_CRC_Berman-Human-2012.meth.bw  
wget http://smithdata.usc.edu/methbase/data/Ziller-Human-2013/Human_Colon_Tumor_Primary/tracks_hg19/Human_Colon_Tumor_Primary.meth.bw -O Human_Colon_Tumor_Primary_CRC_Ziller-Human-2013.meth.bw
wget http://smithdata.usc.edu/methbase/data/Hansen-Human-2011/Human_ColonCancer/tracks_hg19/Human_ColonCancer.meth.bw -O Human_ColonCancer_CRC_Hansen-Human-2011.meth.bw
wget http://smithdata.usc.edu/methbase/data/Akalin-Human-2012/Human_HCT116/tracks_hg19/Human_HCT116.meth.bw -O Human_HCT116_CRC_Akalin-Human-2012.meth.bw

cat *_CRC_*.wig > Human_CCRC_Cancer.wig
grep -v '#' Human_CCRC_Cancer.wig > Human_CCRC_Cancer.wig.bed
perl wigAverage.pl Human_CCRC_Cancer.wig.bed > Human_CCRC_Cancer.wig.bed.uni
bedtools sort -i Human_CCRC_Cancer.wig.bed.uni > Human_CCRC_Cancer.wig.bed.uni.sort
echo 'track type=bedGraph name="CRC" description="CRC" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > Human_CCRC_Cancer.wig.bed.uni.sort.UCSC
cat  Human_CCRC_Cancer.wig.bed.uni.sort >> Human_CCRC_Cancer.wig.bed.uni.sort.UCSC
head Human_CCRC_Cancer.wig.bed.uni.sort.UCSC
gzip Human_CCRC_Cancer.wig.bed.uni.sort.UCSC

cat *_CRC_*.wig > Human_CCRC_Cancer.wig
grep -v '#' Human_CCRC_Cancer.wig > Human_CCRC_Cancer.wig.bed
perl wigAverage.pl Human_CCRC_Cancer.wig.bed > Human_CCRC_Cancer.wig.bed.uni
bedtools sort -i Human_CCRC_Cancer.wig.bed.uni > Human_CCRC_Cancer.wig.bed.uni.sort
echo 'track type=bedGraph name="CRC" description="CRC" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > Human_CCRC_Cancer.wig.bed.uni.sort.UCSC
cat  Human_CCRC_Cancer.wig.bed.uni.sort >> Human_CCRC_Cancer.wig.bed.uni.sort.UCSC
head Human_CCRC_Cancer.wig.bed.uni.sort.UCSC
gzip Human_CCRC_Cancer.wig.bed.uni.sort.UCSC

# Lung and Lung cancer
wget http://smithdata.usc.edu/methbase/data/Roadmap-Human-2015/Human_Lung/tracks_hg19/Human_Lung.meth.bw -O Human_Lung_Roadmap_hg19.meth.bw
bigWigToWig Human_Lung_Roadmap_hg19.meth.bw Human_Lung_Roadmap_hg19.meth.bw.wig
SID="Human_Lung_Roadmap_hg19"
cat Human_Lung_Roadmap*bw.wig > $SID.wig
grep -v '#' $SID.wig > $SID.wig.bed
perl wigAverage.pl $SID.wig.bed > $SID.wig.bed.uni
bedtools sort -i $SID.wig.bed.uni > $SID.wig.bed.uni.sort
echo 'track type=bedGraph name="Human_Neutrophil" description="Human_Neutrophil" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > $SID.wig.bed.uni.sort.UCSC
cat  $SID.wig.bed.uni.sort >> $SID.wig.bed.uni.sort.UCSC
head $SID.wig.bed.uni.sort.UCSC
gzip -f $SID.wig.bed.uni.sort.UCSC


# Breast and breast cancer (BRCA)
wget http://smithdata.usc.edu/methbase/data/Lin-Human-2015/Human_HealthyBreast/tracks_hg19/Human_HealthyBreast.meth.bw -O Human_HealthyBreast_Lin-Human-2015.meth.bw

wget http://smithdata.usc.edu/methbase/data/Grimmer-Human-2014/Human_MCF7/tracks_hg19/Human_MCF7.meth.bw -O Human_MCF7_BRCA_Grimmer-Human-2014.meth.bw
wget http://smithdata.usc.edu/methbase/data/Hon-Human-2012/Human_HCC1954/tracks_hg19/Human_HCC1954.meth.bw -O Human_HCC1954_BRCA_Hon-Human-2012.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lin-Human-2015/Human_BreastTumor089/tracks_hg19/Human_BreastTumor089.meth.bw -O Human_BreastTumor089_BRCA_Lin-Human-2015.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lin-Human-2015/Human_BreastTumor126/tracks_hg19/Human_BreastTumor126.meth.bw -O  Human_BreastTumor126_BRCA_Lin-Human-2015.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lin-Human-2015/Human_BreastTumor198/tracks_hg19/Human_BreastTumor198.meth.bw -O Human_BreastTumor198_BRCA_Lin-Human-2015.meth.bw
wget http://smithdata.usc.edu/methbase/data/Menafra-Human-2014/Human_MCF7/tracks_hg19/Human_MCF7.meth.bw -O Human_MCF7_BRCA_Menafra-Human-2014.meth.bw

cat *_MCF7_*.wig > Human_BRCA.wig
grep -v '#' Human_BRCA.wig > Human_BRCA.meth.hg19
bedtools sort -i Human_BRCA.meth.hg19 > Human_BRCA.meth.hg19.wig
echo 'track type=bedGraph name="BRCA" description="BRCA" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > Human_BRCA.meth.hg19.wig.UCSC
cat  BRCA.bedgraph.uni.meth.sort >> Human_BRCA.meth.hg19.wig.UCSC
head Human_BRCA.meth.hg19.wig.UCSC
gzip Human_BRCA.meth.hg19.wig.UCSC

# pancrease cancer
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

cat *_NormalPancreas*.wig > NOrmalPancreas.wig
grep -v '#' NOrmalPancreas.wig > NOrmalPancreas.wig.bed
perl wigAverage.pl NOrmalPancreas.wig.bed > NOrmalPancreas.wig.bed.uni
bedtools sort -i NOrmalPancreas.wig.bed.uni > NOrmalPancreas.wig.bed.uni.sort
echo 'track type=bedGraph name="Normal_Pancreas" description="Normal_Pancreas" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > NOrmalPancreas.wig.bed.uni.sort.UCSC
cat  NOrmalPancreas.wig.bed.uni.sort >> NOrmalPancreas.wig.bed.uni.sort.UCSC
head NOrmalPancreas.wig.bed.uni.sort.UCSC
gzip -f NOrmalPancreas.wig.bed.uni.sort.UCSC

# AML 
wget http://smithdata.usc.edu/methbase/data/Akalin-Human-2012/Human_AML/tracks_hg19/Human_AML.meth.bw -O Human_AML_Akalin-Human-2012.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lund-Human-2014/Human_AML3-Control/tracks_hg19/Human_AML3-Control.meth.bw -O Human_AML3_Lund-Human-2014.meth.bw
cat  Human_AML*.wig > HUman_AML_WGBS.wig
grep -v '#' HUman_AML_WGBS.wig > HUman_AML_WGBS.wig.bed
perl wigAverage.pl HUman_AML_WGBS.wig.bed > HUman_AML_WGBS.wig.bed.uni
bedtools sort -i HUman_AML_WGBS.wig.bed.uni > HUman_AML_WGBS.wig.bed.uni.sort
echo 'track type=bedGraph name="AML" description="AML" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > HUman_AML_WGBS.wig.bed.uni.sort.UCSC
cat  HUman_AML_WGBS.wig.bed.uni.sort >> HUman_AML_WGBS.wig.bed.uni.sort.UCSC
head HUman_AML_WGBS.wig.bed.uni.sort.UCSC
gzip -f HUman_AML_WGBS.wig.bed.uni.sort.UCSC

# Human_B_Lymphocyte
wget http://smithdata.usc.edu/methbase/data/Ball-Human-2009/Human_BLymphocyte/tracks_hg19/Human_BLymphocyte.meth.bw -O  Human_BALL_Ball_Human-2009.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lee-Human-2015/Human_BALLhyperdiploid/tracks_hg19/Human_BALLhyperdiploid.meth.bw -O Human_BALL_hyperdiploid_Lee-Human-2015.meth.bw
wget http://smithdata.usc.edu/methbase/data/Lee-Human-2015/Human_BALLETV6RUNX1/tracks_hg19/Human_BALLETV6RUNX1.meth.bw -O Human_BALL_ETV6RUNX1-Human-2015.meth.bw
cat  Human_BALL_*.wig > HUman_BALL_WGBS.wig
grep -v '#' HUman_BALL_WGBS.wig > HUman_BALL_WGBS.wig.bed
perl wigAverage.pl HUman_BALL_WGBS.wig.bed > HUman_BALL_WGBS.wig.bed.uni
bedtools sort -i HUman_BALL_WGBS.wig.bed.uni > HUman_BALL_WGBS.wig.bed.uni.sort
echo 'track type=bedGraph name="B-ALL" description="B-ALL" visibility=full color=227,207,87 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > HUman_BALL_WGBS.wig.bed.uni.sort.UCSC
cat  HUman_BALL_WGBS.wig.bed.uni.sort >> HUman_BALL_WGBS.wig.bed.uni.sort.UCSC
head HUman_BALL_WGBS.wig.bed.uni.sort.UCSC
gzip HUman_BALL_WGBS.wig.bed.uni.sort.UCSC

# Non-small cell lung cancer cells, IMR-90 (normal lung cell line fibroblast), A549
wget http://smithdata.usc.edu/methbase/data/Brocks-Human-2017/Human_DMSO/tracks_hg19/Human_DMSO.meth.bw -O Human_H1299_Brocks-Human-2017.meth.bw
bigWigToWig Human_H1299_Brocks-Human-2017.meth.bw Human_H1299_Brocks-Human-2017.meth.bw.wig
grep -v '#' Human_H1299_Brocks-Human-2017.meth.bw.wig > Human_H1299_Brocks-Human-2017.meth.wig &
echo 'track type=bedGraph name="H1299" description="H1299" visibility=full color=0,100,200 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > Human_H1299_Brocks-Human-2017.meth.wig.UCSC
cat  Human_H1299_Brocks-Human-2017.meth.wig >> Human_H1299_Brocks-Human-2017.meth.wig.UCSC
head Human_H1299_Brocks-Human-2017.meth.wig.UCSC
gzip Human_H1299_Brocks-Human-2017.meth.wig.UCSC

awk '{print $1,$2,$3,$5/1000}' GSM1204464_BiSeq_cpgMethylation_BioSam_1502_IMR_90_304071.BiSeq.bed > GSM1204464_BiSeq_cpgMethylation_BioSam_1502_IMR_90_304071.BiSeq.wig
head GSM1204464_BiSeq_cpgMethylation_BioSam_1502_IMR_90_304071.BiSeq.wig
echo 'track type=bedGraph name="HepG2" description="HepG2" visibility=full color=0,100,200 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > GSM1204464_BiSeq_cpgMethylation_BioSam_1502_IMR_90_304071.BiSeq.UCSC.wig
cat  GSM1204464_BiSeq_cpgMethylation_BioSam_1502_IMR_90_304071.BiSeq.wig >> GSM1204464_BiSeq_cpgMethylation_BioSam_1502_IMR_90_304071.BiSeq.UCSC.wig
head GSM1204464_BiSeq_cpgMethylation_BioSam_1502_IMR_90_304071.BiSeq.UCSC.wig
gzip GSM1204464_BiSeq_cpgMethylation_BioSam_1502_IMR_90_304071.BiSeq.UCSC.wig


# prostate cancer
wget http://smithdata.usc.edu/methbase/data/Pidsley-Human-2016/Human_LNCaP/tracks_hg19/Human_LNCaP.meth.bw -O Human_LNCaP_ProstateCancer_Pidsley-Human-2016.meth.bw
grep -v '#' Human_LNCaP_ProstateCancer_Pidsley-Human-2016.meth.bw.wig > Human_LNCaP_ProstateCancer_Pidsley-Human-2016.meth.wig &
echo 'track type=bedGraph name="LNCaP_ProstateCancer" description="LNCaP_ProstateCancer" visibility=full color=0,100,200 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full' > Human_LNCaP_ProstateCancer_Pidsley-Human-2016.meth.wig.UCSC
cat  Human_LNCaP_ProstateCancer_Pidsley-Human-2016.meth.wig >> Human_LNCaP_ProstateCancer_Pidsley-Human-2016.meth.wig.UCSC
head Human_LNCaP_ProstateCancer_Pidsley-Human-2016.meth.wig.UCSC
gzip Human_LNCaP_ProstateCancer_Pidsley-Human-2016.meth.wig.UCSC

# liver cancer, 
wget -r https://genome.ucsc.edu/gbdb/methylome/public/Ziller-Human-2013/Human_HepG2/tracks_hg19/
track type=bedGraph name="HepG2" description="HepG2" visibility=full color=0,100,200 altColor=200,100,0 priority=20 maxHeightPixels=128:64:32 visibility=full
awk '{print $1,$2,$3,$5/1000}' GSM1204463_BiSeq_cpgMethylation_BioSam_1500_HepG2_304072.BiSeq.bed > GSM1204463_BiSeq_cpgMethylation_BioSam_1500_HepG2_304072.BiSeq.wig
gzip GSM1204463_BiSeq_cpgMethylation_BioSam_1500_HepG2_304072.BiSeq.wig


# K562

# cancer associated fibroblasts and non-malignant prostate fibroblasts (NPFs): GSE85609

# WGBS of esophagus squamous epithelium/esophagus muscularis mucosa


# Lung and lung cancer (450K)
GSE39279: 444 lung cancer 450K array
GSE92843: 3 lung cancer cell lines (A549, A427 and H322), normal bronchial ephitelial cells (NHBEC)
GSE63704: 17 LC, 37 idiopathic lung fibrosis,32 patients suffering from chronic obstructive pulmonary disease and 43 DNA samples derived from healthy-lungs 
GSE63940: 36 lung adenocarcinoma cell lines was bisulfite treated and analyzed on the Illumina Infinium HumanMethylation27K 
GSE85566: isolated airway epithelial cells of asthmatics and non-asthmatics
# lung cancer (27K)
GSE62950: 28 pair LC-Normal(27K and mRNA)
GSE32867: 59 pair LC-Normal(27K and mRNA)
# lung cancer (27K)


wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE39nnn/GSE39279/suppl/GSE39279_RAW.tar
mkdir GSE39279
mv GSE39279_RAW.tar GSE39279
