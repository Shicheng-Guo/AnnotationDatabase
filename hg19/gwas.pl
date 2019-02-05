use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;

open F1, "/home/local/MFLDCLIN/guosa/hpc/db/hg19/gwas_catalog_v1.0-associations_e92_r2018-06-25.tsv";

my @cpgsnp;
open F2,"/home/local/MFLDCLIN/guosa/hpc/db/hg19/plan2/AllCpGSNP150.hg19.RS_SNP.uni.txt";
chomp(@cpgsnp=<F2>);
close F2;

open OUT,">GWAS-SNP-List_hg19.bed";
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
	my $start=$pos-1;
	$rs=~s/\s+//g;
    next if $rs=~/chr|UMOD/;
    next if $rs=~/-/;
    next if $rs=~/\*|\:/;
	if($rs=~/^rs/){
    my @line=split/;|x/,$rs;
	foreach my $rs(@line){
	if($rs~~@cpgsnp){
	print  "$chr\t$start\t$pos\t$rs\t$gene\t$pubid\t$journal\t$band\t$trait\n";
	print OUT "$chr\t$start\t$pos\t$rs\t$gene\t$pubid\t$journal\t$band\t$trait\n";
	}
	}
}
}
close OUT;

