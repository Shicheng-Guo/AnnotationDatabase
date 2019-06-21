# Stop_gain and Stop_loss (not include  inframe_insertion, inframe_deletion )
cd /gpfs/home/guosa/hpc/db/Gnomad/exome/aloft-exome-rec
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
qsub $i.job
done

#frameshift_variant (not include  inframe_insertion, inframe_deletion )
panel="ExomeFrame"
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
echo bcftools view -f PASS -i \'\(INFO\/vep \~ \"frameshift\"\)\' gnomad.exomes.r2.1.sites.chr$i.rec.vcf.bgz -Oz -o  ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz >>$i.job
echo bcftools sort ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -T ./temp/ >> $i.job
echo bcftools norm -d all ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.rmdup.vcf.gz >> $i.job
qsub $i.job
done



#splice_acceptor and splice_donor (not include   splice_region_variant)
panel="ExomeSplice"
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
echo bcftools view -f PASS -i \'\(INFO\/vep \~ \"splice_acceptor\"\|INFO\/vep \~ \" splice_donor\"\)\' gnomad.exomes.r2.1.sites.chr$i.rec.vcf.bgz -Oz -o  ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz >>$i.job
echo bcftools sort ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -T ./temp/ >> $i.job
echo bcftools norm -d all ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.rmdup.vcf.gz >> $i.job
qsub $i.job
done

#missense_variant (not include) , 
panel="missense_variant"
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
echo bcftools view -f PASS -i \'\(INFO\/vep \~ \"missense_variant\"\)\' gnomad.exomes.r2.1.sites.chr$i.rec.vcf.bgz -Ou -o  ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz >>$i.job
echo bcftools sort ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -T ./temp/ >> $i.job
echo bcftools norm -d all ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.rmdup.vcf.gz >> $i.job
qsub $i.job
done

#regulatory_region_variant  (not include) , 
panel="ExomeRegulatory"
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
echo bcftools view -f PASS -i \'\(INFO\/vep \~ \"regulatory_region_variant\"\)\' gnomad.exomes.r2.1.sites.chr$i.rec.vcf.bgz -Oz -o  ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz >>$i.job
echo bcftools sort ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -T ./temp/ >> $i.job
echo bcftools norm -d all ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.vcf.gz -Oz -o ./vep/gnomad.exomes.r2.1.sites.chr$i.rec.$panel.sort.rmdup.vcf.gz >> $i.job
qsub $i.job
done


for panel in ExomeStop ExomeFrame ExomeSplice missense_variant ExomeRegulatory
do
echo $panel
ls -l *$panel*sort.rmdup.vcf.gz | wc -l 
ls -l *$panel*sort.rmdup.vcf.gz 
done



for panel in ExomeStop ExomeFrame ExomeSplice missense_variant ExomeRegulatory
do
echo $panel
ls *$panel*sort.rmdup.biallelic.vcf.gz > concat.txt
bcftools concat -f concat.txt -Ov -o gnomad.exomes.r2.1.sites.rec.$panel.merge.vcf
grep -v "#" gnomad.exomes.r2.1.sites.rec.$panel.merge.vcf |grep rs | awk '{print "chr"$1"\t"$2"\t"$2"\t"$3"\t"$4"\t"$5}' > gnomad.exomes.r2.1.sites.rec.$panel.hg19.vcf.bed
wc -l gnomad.exomes.r2.1.sites.rec.$panel.hg19.vcf.bed
done




