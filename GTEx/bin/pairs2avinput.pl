# /home/guosa/hpc/project/m6A/GTEx_Analysis_v8_eQTL

use strict;
use Cwd;

open F1,"";
while(<F1>){

}



my $file=shift @ARGV;
open F,$file;
while(<F>){
my @line=split /\s+/;
my(undef,$chr,$pos,$ref,$alt,$hg)=split /chr|_/,$line[0];
print "$chr\t$pos\n";
}
