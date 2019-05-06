exm id to rs id

1. bedtools bim to allSNP151
2. creat exm and rsid reference
3. run exm2rs.pl to get updated bim
```
cd /home/guosa/hpc/project/pmrp/phase1/plink
bedtools intersect -wao -a FinalRelease_QC_20140311_Team1_Marshfield.bim.bed -b /home/guosa/hpc/db/hg19/allSNP151.hg19.sort.bed >  Illumina_CoreExome_Beadchip.hg19.exm2rs.bed
awk '{print $1,$3,$4,$6,$7,$11,$12,$13}' OFS="\t" Illumina_CoreExome_Beadchip.hg19.exm2rs.bed > Illumina_CoreExome_Beadchip.hg19.exm2rs.bed
perl exm2rs.pl 
```
