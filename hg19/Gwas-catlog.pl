use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;

open F, "/home/local/MFLDCLIN/guosa/hpc/db/hg19/gwas_catalog_v1.0-associations_e92_r2018-06-25.tsv";
while(<F>){
	chomp;
	my @line=split/\t/;
	my $rs=$line[21];
	my $trait=$line[7];
	$rs=~s/\s+//g;
    next if $rs=~/chr|UMOD/;
    next if $rs=~/-/;
    next if $rs=~/\*|\:/;
	if($rs=~/^rs/){
    my @line=split/;|x/,$rs;
	foreach my $rs(@line){
	print "$rs\t$trait\n";
	}
}
}

