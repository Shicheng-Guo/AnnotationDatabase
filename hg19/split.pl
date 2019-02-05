use strict;
use Cwd;
use POSIX;
my $dir = getcwd;
chdir $dir;

open F,"/gpfs/home/guosa/hpc/db/hg19/CpG-SNP_eQTL_Functional_analysis.txt";
my @tissue;
while(<F>){
    if(/Chr/){
    @tissue=split/\s+/;
    next;
    }
    my @line=split/\t/;
    foreach my $i(5..52){
    next if $line[$i] eq '.';
    next if $line[$i]>0 && $line[53] eq "Gain";
    next if $line[$i]<0 && $line[53] eq "Loss";
    print "$line[0]\t$line[1]\t$line[2]\t$line[3]\t$line[4]\t$line[$i]\t$tissue[$i]\t$line[53]\t$line[54]\n";	
    }
}




