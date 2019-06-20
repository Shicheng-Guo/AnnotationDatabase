cd /gpfs/home/guosa/hpc/db/Gnomad/exome/aloft-exome-rec
mkdir aloft
mkdir temp
for i in {1..22} X Y
do
echo \#PBS -N $i  > $i.job
echo \#PBS -l nodes=1:ppn=16 >> $i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> $i.job
echo \#PBS -m abe  >> $i.job
echo \#PBS -o $(pwd)/temp/ >>$i.job
echo \#PBS -e $(pwd)/temp/ >>$i.job
echo cd $(pwd) >> $i.job
echo mkdir aloft/chr$i >>$i.job
# echo bcftools view gnomad.exomes.r2.1.sites.chr$i.vcf.bgz -Oz -o gnomad.exomes.r2.1.sites.chr$i.vcf.gz >>$i.job
# echo tabix -p vcf gnomad.exomes.r2.1.sites.chr$i.vcf.gz >>$i.job
# echo bcftools view -G gnomad.exomes.r2.1.sites.chr$i.rec.vcf.gz -Oz -o gnomad.exomes.r2.1.sites.chr$i.dq.rec.vcf.gz >> $i.job
echo ~/hpc/tools/aloft/aloft-annotate/aloft --vcf gnomad.exomes.r2.1.sites.chr$i.dq.rec.vcf.gz --output aloft/chr$i --data /gpfs/home/guosa/hpc/tools/aloft/aloft-annotate/data/data_aloft_annotate/ >>$i.job
qsub $i.job
done

#### Summary the Reslt

cd ~/hpc/db/Gnomad/exome/aloft-exome-rec/aloft

for i in `ls *.lof`
do
awk '{print $1,$2,$3,$4,$5}' $i  |sort -u | wc -l
done

for i in `ls *.splice`
do
awk '{print $1,$2,$3,$4,$5}' $i  |sort -u | wc -l
done

##### Gnomad Result

	LOF	SPLICE
gnomad.exomes.r2.1.sites.chr10.dq.rec.vcf.gz.vat.aloft.lof	17960	4118
gnomad.exomes.r2.1.sites.chr11.dq.rec.vcf.gz.vat.aloft.lof	30685	5993
gnomad.exomes.r2.1.sites.chr12.dq.rec.vcf.gz.vat.aloft.lof	24888	5887
gnomad.exomes.r2.1.sites.chr13.dq.rec.vcf.gz.vat.aloft.lof	8010	1754
gnomad.exomes.r2.1.sites.chr14.dq.rec.vcf.gz.vat.aloft.lof	15019	2980
gnomad.exomes.r2.1.sites.chr15.dq.rec.vcf.gz.vat.aloft.lof	17133	3834
gnomad.exomes.r2.1.sites.chr16.dq.rec.vcf.gz.vat.aloft.lof	21989	5056
gnomad.exomes.r2.1.sites.chr17.dq.rec.vcf.gz.vat.aloft.lof	28625	6212
gnomad.exomes.r2.1.sites.chr18.dq.rec.vcf.gz.vat.aloft.lof	6958	1548
gnomad.exomes.r2.1.sites.chr19.dq.rec.vcf.gz.vat.aloft.lof	39582	6419
gnomad.exomes.r2.1.sites.chr20.dq.rec.vcf.gz.vat.aloft.lof	11101	2483
gnomad.exomes.r2.1.sites.chr21.dq.rec.vcf.gz.vat.aloft.lof	5328	1087
gnomad.exomes.r2.1.sites.chr22.dq.rec.vcf.gz.vat.aloft.lof	10298	2359
gnomad.exomes.r2.1.sites.chr2.dq.rec.vcf.gz.vat.aloft.lof	32791	7885
gnomad.exomes.r2.1.sites.chr3.dq.rec.vcf.gz.vat.aloft.lof	28133	6281
gnomad.exomes.r2.1.sites.chr4.dq.rec.vcf.gz.vat.aloft.lof	19306	4304
gnomad.exomes.r2.1.sites.chr5.dq.rec.vcf.gz.vat.aloft.lof	21271	4208
gnomad.exomes.r2.1.sites.chr6.dq.rec.vcf.gz.vat.aloft.lof	24908	5171
gnomad.exomes.r2.1.sites.chr7.dq.rec.vcf.gz.vat.aloft.lof	22953	4882
gnomad.exomes.r2.1.sites.chr8.dq.rec.vcf.gz.vat.aloft.lof	16116	3677
gnomad.exomes.r2.1.sites.chr9.dq.rec.vcf.gz.vat.aloft.lof	19129	4031
gnomad.exomes.r2.1.sites.chrX.dq.rec.vcf.gz.vat.aloft.lof	7329	1491
gnomad.exomes.r2.1.sites.chrY.dq.rec.vcf.gz.vat.aloft.lof	150	39
	                                                        429662	91699


      

