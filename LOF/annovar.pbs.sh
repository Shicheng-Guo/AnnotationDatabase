cd /gpfs/home/guosa/hpc/db/Gnomad/exome/aloft-exome-rec

mkdir annovar
mkdir temp
for i in {1..22} 
do
echo \#PBS -N $i  > chr$i.job
echo \#PBS -l nodes=1:ppn=8 >> chr$i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> chr$i.job
echo \#PBS -m abe  >> chr$i.job
echo \#PBS -o $(pwd)/temp/ >>chr$i.job
echo \#PBS -e $(pwd)/temp/ >>chr$i.job
echo cd $(pwd) >> chr$i.job
echo convert2annovar.pl -format vcf4 -allsample -withfreq gnomad.exomes.r2.1.sites.chr$i.rec.vcf.gz  \> ./annovar/gnomad.exomes.r2.1.sites.chr$i.rec.vcf.avinput >> chr$i.job
echo table_annovar.pl ./annovar/gnomad.exomes.r2.1.sites.chr$i.rec.vcf.avinput /gpfs/home/guosa/hpc/tools/annovar/humandb/ --thread 4 -buildver hg19 --csvout -out ./annovar/chr$i -remove -protocol refGene,dbnsfp33a,gwasCatalog,wgRna,targetScanS,tfbsConsSites -operation gx,f,r,r,r,r -nastring . -otherinfo -polish -xref /gpfs/home/guosa/hpc/tools/annovar/humandb/gene_fullxref.txt >> chr$i.job
qsub chr$i.job
done
