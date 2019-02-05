use strict;
use Cwd;
chdir getcwd;
my $file=shift @ARGV;
my %snp;
open F,$file || die "cannot open $file\n";
while(<F>){
my($chr,$start,$end,$rs)=split/\s/;	
my $cord="$chr:$start-$end";	
$snp{$rs}=$cord;
}
close F;

open F,shift @ARGV;
while(<F>){
	chomp;
	my($snp)=split/\s/;
	my($chr,$start,$end)=split/[:-]/,$snp{$snp};
	print "$chr\t$start\t$end\t$snp\n";	
} 
