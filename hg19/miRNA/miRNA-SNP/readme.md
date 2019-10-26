# Common miRNA-SNPs in East Asian Population

* Download Gnomad genome-wide SNP dataset
* Download miRNA seed region bed: [miRNA.mature.hg19.bed]()
* Identified all the miRNA-SNPs and MAF>0.01 in East Asian Population
* Finally [95 SNPs](miRNAcommonSNP.txt) were identified. 

```
cd /gpfs/home/guosa/hpc/db/Gnomad/genome
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
echo bcftools view -m2 -M2 -v snps -f PASS -i \'AF_eas\>0.01\' -R miRNA.mature.hg19.bed gnomad.genomes.r2.1.sites.chr$i.rec.vcf.bgz -Oz -o ./miRNA/miRNA.mature.seed.chr$i.vcf.gz >> $i.job
echo tabix -p vcf ./miRNA/miRNA.mature.seed.chr$i.vcf.gz >> $i.job
qsub $i.job
done
cd ./miRNA
ls miRNA.mature.seed*vcf.gz > file.txt 
bcftools merge -l file.txt -Oz -o miRNA.CHB.SNP.vcf.gz
zcat miRNA.CHB.SNP.vcf.gz | grep -v '#' | awk '{print $1,$2,$3,$4,$5}' >miRNAcommonSNP.txt
zcat miRNA.CHB.SNP.vcf.gz | grep -v '#' | awk '{print "dbsnp",$3}' > miRNAcommonSNP.nexus.txt
```
