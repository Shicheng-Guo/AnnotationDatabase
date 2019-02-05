use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;
my $file="snp150.txt";
open OUT,">snp150.hg19.txt";
open(IN, $file) or die "open $file: $!";
while(<IN>){
my(undef,$chr,$start,$end,$rs,undef,$strand,$ref,undef,$alt)=split/\s+/;
print OUT "$chr\t$start\t$end\t$rs\t$strand\t$ref\t$alt\n";	
}
close IN;
close OUT;
