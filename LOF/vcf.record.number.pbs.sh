cd /gpfs/home/guosa/hpc/db/Gnomad/exome/aloft-exome
mkdir recordNumber
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
echo mkdir aloft/chr$i >>$i.job
# echo bcftools view gnomad.exomes.r2.1.sites.chr$i.vcf.bgz -Oz -o gnomad.exomes.r2.1.sites.chr$i.vcf.gz >>$i.job
# echo tabix -p vcf gnomad.exomes.r2.1.sites.chr$i.vcf.gz >>$i.job
# echo bcftools view -G gnomad.exomes.r2.1.sites.chr$i.rec.vcf.gz -Oz -o gnomad.exomes.r2.1.sites.chr$i.dq.rec.vcf.gz >> $i.job
echo zcat gnomad.exomes.r2.1.sites.chr$i.vcf.gz \| grep -v \'\#\' \| wc -l \> gnomad.exomes.r2.1.sites.chr$i.vcf.gz.number.txt >>$i.job
qsub $i.job
done
