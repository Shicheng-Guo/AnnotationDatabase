cd ~/hpc/db/Gnomad/exome/aloft-exome-rec
mkdir vep
panel="ExomeStop"
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
echo bcftools view -f PASS -i \'\(INFO\/vep \~ \"stop_gained\"\|\INFO\/vep \~ \"stop_lost\"\)\' gnomad.exomes.r2.1.sites.chr$i.rec.vcf.bgz -Oz -o  ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz >>$i.job
echo bcftools sort ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -T ./temp/ >> $i.job
echo bcftools norm -d all ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.rmdup.vcf.gz >> $i.job
echo bcftools view ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.rmdup.vcf.bgz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.rmdup.biallelic.vcf.gz >>$i.job
qsub $i.job
done
