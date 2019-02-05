
use strict;
use Cwd;
use POSIX;
my $dir = getcwd;
chdir $dir;

open F,"/gpfs/home/guosa/hpc/db/hg19/allSNP150.hg19.bed";
while(<F>){
        my ($chr,$start,$end,$rs,$chain,$ref,$alt)=split/\s+/;
        open OUT,">>/gpfs/home/guosa/hpc/db/hg19/snp150annovar/cpgSNP.hg19.$chr.bed.avinput";
        my @allele=split/\//,$alt;
        my (undef,$newchr)=split/chr/,$chr;
        foreach my $allele(@allele){
                next if $allele eq $ref;
                print OUT "$newchr\t$end\t$end\t$ref\t$allele\t$rs\n";
        }
}
close OUT;
