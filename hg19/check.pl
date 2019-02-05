use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;
open F,"/home/local/MFLDCLIN/guosa/hpc/db/hg19/allsnp150.hg19";
while(<F>){
	my (undef,undef,undef,$rs,undef,undef,$rlt)=split/\s+/;
	my @line=split "\/",$rlt;
	print "$rs\t$rlt\n" if $#line>2;
}
