use strict;
use Cwd;
chdir getcwd;
my $file="NCBIRefGene_GRCH37";
open F,$file;
while(<F>){
  next if /#|chrUn|random|hap/;
  my @line=split /\t/;
  print "$line[2]\t$line[4]\t$line[5]\t$line[1]\t$line[-4]\n";
}
close F; 


