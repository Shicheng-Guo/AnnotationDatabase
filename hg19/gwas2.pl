use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;

open F1, "/home/local/MFLDCLIN/guosa/hpc/db/hg19/gwas_catalog_v1.0-associations_e92_r2018-06-25.tsv";

my %cpgsnp;
open F2,"/home/local/MFLDCLIN/guosa/hpc/db/hg19/plan2/AllCpGSNP150.hg19.RS_SNP.uni.txt";
while(<F2>){
chomp;
my($snp)=split/\s+/;
$cpgsnp{$snp}=$snp;
}
close F2;

open OUT,">GWAS-SNP-List_hg19_full.txt";
while(<F1>){
	chomp;
	my @line=split/\t/;
	my $rs=$line[21];
	my $trait=$line[7];
	my $pubid=$line[3];
	my $journal=$line[4];
	my $band=$line[10];
	my $gene=$line[13];
	my $chr="chr$line[11]";
	my $pos=$line[12];
        my $pvalue=$line[27];
        my $risk=$line[20];
        my $context=$line[24];
	my $start=$pos-1;
	$rs=~s/\s+//g;
    next if $rs=~/chr|UMOD/;
    next if $rs=~/-/;
    next if $rs=~/\*|\:/;
	if($rs=~/^rs/){
    my @line=split/;|x/,$rs;
	foreach my $rs(@line){
	if($cpgsnp{$rs}){
	print  "$chr\t$start\t$pos\t$rs\t$pvalue\t$risk\t$gene\t$context\t$pubid\t$journal\t$band\t$trait\n";
	print OUT  "$chr\t$start\t$pos\t$rs\t$pvalue\t$risk\t$gene\t$context\t$pubid\t$journal\t$band\t$trait\n";
	}
	}
}
}
close F1;
close OUT;

