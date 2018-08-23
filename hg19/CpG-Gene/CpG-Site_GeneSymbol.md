```
cd /gpfs/home/guosa/hpc/db/hg19/CpGs
for i in {1..22} X Y
do
echo \#PBS -N chr$i  > chr$i.job
echo cd $(pwd) >>chr$i.job
echo awk \'{print \$1\"\\t\"\$2-1\"\\t\"\$2}\' chr$i.CpG.positions.txt \> /gpfs/home/guosa/hpc/db/hg19/CpGs/bed/chr$i.CpG.positions.bed >> chr$i.job
echo bedtools closest -a ./bed/chr$i.CpG.positions.bed -b /gpfs/home/guosa/hpc/db/hg19/refGene.hg19.bed \> ./bed/chr$i.CpG.positions.refGene.hg19.bed >> chr$i.job
qsub chr$i.job
done

cd /gpfs/home/guosa/hpc/db/hg19/CpGs/bed
for i in {1..22} X Y
do
echo \#PBS -N chr$i  > chr$i.job
echo cd $(pwd) >>chr$i.job
echo awk \'{print \$1\"\\t\"\$2\"\\t\"\$3\"\\t\"\$8}\' chr$i.CpG.positions.refGene.hg19.bed \> /gpfs/home/guosa/hpc/db/hg19/CpGs/bed/chr$i.CpG.Gene.hg19.bed >> chr$i.job
echo gzip chr$i.CpG.Gene.hg19.bed  >> chr$i.job
qsub chr$i.job
done

for i in `ls *CpG.Gene.hg19.bed`
do
gzip $i
done
```
