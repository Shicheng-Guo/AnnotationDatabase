use strict;
use Cwd;
use POSIX;
my $dir = getcwd;
chdir $dir;

open F1,"commonSNP_hg19_v1.txt";
my %cpgsnp;
while(<F1>){
chomp;
my(undef,undef,undef,$rs,undef)=split/\s+/;
$cpgsnp{$rs}=$rs;
}

my %gwas;
my %rsNum;
open F2,"GWAS_Significant_RS.txt";
while(<F2>){
chomp;
my($rs,$trait)=split/\t/;
$rsNum{$trait}++;
if($cpgsnp{$rs}){
$gwas{$trait}++;	
}
}

foreach my $trait(keys %gwas){
	my $ratio=$gwas{$trait}/$rsNum{$trait};
	print "$trait\t$gwas{$trait}\t$rsNum{$trait}\t$ratio\n";
}



