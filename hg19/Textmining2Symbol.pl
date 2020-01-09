use strict;
use Cwd;
use Getopt::long;

my $input   = shift @ARGV;
my $referGeneFile="/gpfs/home/guosa/hpc/db/hg19/GeneSymbol2AllAliasName.txt";

GetOptions ("input=i" => \$input,
            "referGeneFile=g"  => \$referGeneFile) 
              or die("Error in command line arguments\n");
              
my $dir=getcwd;
die "print provide input abstract!" if ! defined $input;

open F,"$referGeneFile";
my %dbgene;
while(<F>){
	chomp;
	my @tmp=split /\s+/;
	my $symbol=$tmp[0];
	foreach my $tmp(@tmp){
		push(@{$dbgene{$symbol}},$tmp);
	}
}
close F;

open F,$input;
while(<F>){
	chomp;
	foreach my $symbol(sort keys %dbgene){
		foreach my $alias(%dbgene{$symbol}){
			if($_=/(\b$alias\b)/i){
			print "$alias\n";
			}	
		}
	}
}

