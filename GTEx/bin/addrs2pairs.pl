# add rsid to GTEx v8.signif_variant_gene_pairs.txt files to match with m6A-Var
# don't forget to add ENSG in the output files since one SNP will have multiple records with different genes
# Shicheng Guo, 2020/01/11, Shihcheng.Guo@Gmail.com

use strict;
use Cwd;
open F1,"/home/guosa/hpc/db/dbSNP153/hg38/chr/dbSNP153.bin.chain.txt";
my %db;
while(<F1>){
chomp;
my($key,$rs)=split/\s+/;
$db{$key}=$rs;
}

chdir "/home/guosa/hpc/project/m6A/GTEx_Analysis_v8_eQTL";
my @file=glob("*v8.signif_variant_gene_pairs.txt");
foreach my $file(@file){
open F,$file;
open OUT,">$file.rsid.txt";
while(<F>){
my @line=split /\s+/;
$line[12]=$db{$line[0]};
next if ! defined $db{$line[0]};
my $output=join("\t",@line[12,6,7,8,1]);
print OUT "$output\n";
}
close OUT;
}
