use strict;
use Cwd;
chdir getcwd;
my $file=shift @ARGV;
open F,$file;
while(<F>){
  next if /#|chrUn|random|hap/;
  next if !/mir/;
  my @line=split /\t/;
  print "$line[1]\t$line[2]\t$line[3]\t$line[4]\n";
}
close F; 


