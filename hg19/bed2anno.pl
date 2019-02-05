use strict;
use Cwd;
use POSIX;
my $dir = getcwd;
chdir $dir;

open F,"/gpfs/home/guosa/hpc/db/hg19/cpgSNP.hg19.bed";
while(<F>){
	my ($chr,$start,$end,$rs,$ref,$alt,$context)=split/\s+/;
	my @allele=split/\//,$alt;
	my (undef,$newchr)=split/chr/,$chr;
	foreach my $allele(@allele){
		next if $allele eq $ref;
		print "$newchr\t$end\t$end\t$ref\t$allele\t$rs\t$context\n"; 
	}
}
