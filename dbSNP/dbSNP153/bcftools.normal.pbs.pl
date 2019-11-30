tabix -p vcf dbSNP153.hg19.vcf.gz
cd /gpfs/home/guosa/hpc/db/dbSNP153
mkdir temp
for i in {1..22} X
do
echo \#PBS -N $i  > $i.job
echo \#PBS -l nodes=1:ppn=1 >> $i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> $i.job
echo \#PBS -m abe  >> $i.job
echo \#PBS -o $(pwd)/temp/ >>$i.job
echo \#PBS -e $(pwd)/temp/ >>$i.job
echo cd $(pwd) >> $i.job
echo bcftools norm -m-snps -r $i dbSNP153.hg19.vcf.gz -Ov -o dbSNP153.hg19.chr$i.vcf.gz >> $i.job
qsub $i.job
done
