use strict;
use Cwd;
use POSIX;
my $dir = getcwd;
chdir $dir;

open F,"/gpfs/home/guosa/hpc/db/hg19/cpgSNP.hg19.bed.avinput";
while(<F>){
	my ($chr,$start,$end,$ref,$alt,$rs,$context)=split/\s+/;
	my @seq=split //,uc $context;
	my $status;
	if($seq[3] eq "C" && $ref eq "G"){
	$status="Loss";
	}elsif($seq[3] ne "C" && $ref eq "C"){
	$status="Loss";	
	}else{
	$status="Gain";	
	}
	print "$chr\t$end\t$end\t$ref\t$alt\t$status\t$rs\t$context\n"; 
}


