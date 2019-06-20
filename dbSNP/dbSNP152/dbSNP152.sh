# Step 1: Download
wget https://ftp.ncbi.nih.gov/snp/redesign/latest_release/VCF/GCF_000001405.25.bgz -O ~/hpc/db/hg19/dbSNP152.hg19.vcf.bgz
tabix -p vcf dbSNP152.hg19.vcf.bgz
zcat dbSNP152.hg19.vcf.bgz > dbSNP152.hg19.vcf

wget https://ftp.ncbi.nih.gov/snp/redesign/latest_release/VCF/GCF_000001405.38.bgz -O ~/hpc/db/hg38/dbSNP152.hg38.vcf.bgz
tabix -p vcf dbSNP152.hg38.vcf.bgz
zcat dbSNP152.hg19.vcf.bgz > dbSNP152.hg38.vcf.bgz


# Step 2: Replace  to chr1,chr2,chr3



# Step 3: Split BigVCF to SmallVCF by Chrosome

mkdir chr
mkdir temp
for i in {1..22} X Y
do
echo \#PBS -N $i  > $i.job
echo \#PBS -l nodes=1:ppn=1 >> $i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> $i.job
echo \#PBS -m abe  >> $i.job
echo \#PBS -o $(pwd)/temp/ >>$i.job
echo \#PBS -e $(pwd)/temp/ >>$i.job
echo cd $(pwd) >> $i.job
echo vcftools --vcf dbSNP152.hg19.fix.vcf --chr $i --recode --out ./dbSNP152/dbSNP152.hg19.chr$i.vcf >>$i.job
qsub $i.job
done

