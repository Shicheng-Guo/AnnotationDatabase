miRNA.mature.hg19.bed
```
mkdir temp
for i in {1..22} X Y MT
do
echo \#PBS -N $i  > $i.job
echo \#PBS -l nodes=1:ppn=1 >> $i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> $i.job
echo \#PBS -m abe  >> $i.job
echo \#PBS -o $(pwd)/temp/ >>$i.job
echo \#PBS -e $(pwd)/temp/ >>$i.job
echo cd $(pwd) >> $i.job
echo bcftools view -c -f PASS -R miRNA.mature.hg19.bed gnomad.genomes.r2.1.sites.chr$i.rec.vcf.bgz -Oz -o ./miRNA/miRNA.mature.seed.chr$i.vcf.gz >> $i.job
qsub $i.job
done
```
