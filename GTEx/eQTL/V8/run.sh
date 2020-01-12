mkdir temp
wget https://raw.githubusercontent.com/Shicheng-Guo/Gscutility/master/contigReplace.pl -O contigReplace.pl
for i in {1..23} X
do
echo \#PBS -N $i  > $i.job
echo \#PBS -l nodes=1:ppn=1 >> $i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> $i.job
echo \#PBS -m abe  >> $i.job
echo \#PBS -o $(pwd)/temp/ >>$i.job
echo \#PBS -e $(pwd)/temp/ >>$i.job
echo cd $(pwd) >> $i.job
echo bcftools view dbSNP153.GRCh38p12b.vcf.gz -r $i -Ov -o ./chr/dbSNP153.chr$i.hg38.vcf >>$i.job
echo tabix -p vcf chr$i.dose.contig.vcf.gz >>$i.job
qsub $i.job
done


mkdir temp
for i in `ls *.vcf`
do
echo \#PBS -N $i  > $i.job
echo \#PBS -l nodes=1:ppn=1 >> $i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> $i.job
echo \#PBS -m abe  >> $i.job
echo \#PBS -o $(pwd)/temp/ >>$i.job
echo \#PBS -e $(pwd)/temp/ >>$i.job
echo cd $(pwd) >> $i.job
echo perl vcf2Rinput.pl $i \> $i.txt >>$i.job
qsub $i.job
done

cd ~/hpc/project/m6A/GTEx_Analysis_v8_eQTL

/gpfs/home/guosa/hpc/db/dbSNP153/hg38/chr/dbSNP153.bin.chain.txt

mkdir temp
for i in `ls *.v8.signif_variant_gene_pairs.txt`
do
echo \#PBS -N $i  > $i.job
echo \#PBS -l nodes=1:ppn=12 >> $i.job
echo \#PBS -M Guo.shicheng\@marshfieldresearch.org >> $i.job
echo \#PBS -m abe  >> $i.job
echo \#PBS -o $(pwd)/temp/ >>$i.job
echo \#PBS -e $(pwd)/temp/ >>$i.job
echo cd $(pwd) >> $i.job
echo perl addrs.pl $i \> $i.rs.txt 
qsub $i.job
done

/gpfs/home/guosa/hpc/db/dbSNP153/hg38/chr

open F,shift @ARGV;
while(<F>){
next if /^#/;
my ($chr,$pos,$rs,$ref,$alt,undef)=split /\s+/;
my $key="chr".$chr."_".$pos."_".$ref."_".$alt."_b38";
print "$key\t$rs\n";
}

perl vcf2Rinput.pl dbSNP153.chr2.hg38.vcf


for i in `ls *.rsid.txt.gz`
do
echo $i
zcat $i | awk '{print $1,$2}' > $i.uni.txt
done


for i in `ls *.uni.txt`
do
echo $i
gzip $i
done

