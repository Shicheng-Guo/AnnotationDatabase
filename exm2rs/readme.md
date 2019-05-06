exm id to rs id

```
cd /home/guosa/hpc/project/pmrp/phase1/plink

bedtools intersect -wao -a FinalRelease_QC_20140311_Team1_Marshfield.bim.bed -b /home/guosa/hpc/db/hg19/allSNP151.hg19.sort.bed >  Illumina_CoreExome_Beadchip.hg19.exm2rs.bed
awk '{print $1,$3,$4,$6,$7,$11,$12,$13}' OFS="\t" Illumina_CoreExome_Beadchip.hg19.exm2rs.bed > Illumina_CoreExome_Beadchip.hg19.exm2rs.bed
grep -v 'CCC' Illumina_CoreExome_Beadchip.hg19.exm2rs.bed > Illumina_CoreExome_Beadchip.hg19.exm2rs.uni.bed
grep -v 'TTT' Illumina_CoreExome_Beadchip.hg19.exm2rs.uni.bed > Illumina_CoreExome_Beadchip.hg19.exm2rs.bed

perl exm2rs.pl 

```
