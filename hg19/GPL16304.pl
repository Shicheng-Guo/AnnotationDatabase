use Cwd;
use strict;
my $GPL16304=shift @ARGV;
open F, $GPL16304 || die "cannot open $GPL16304\n";
#print "CHR\tStart\tEnd\tcg\tgene\tstrand\tcpgisland\tprobetype\n";
while(<F>){
	next if /^#/;
        next if /Name/i;
	my @line=split/\t/;
	my $chr= $line[11];
	my $start=$line[12];
	my $end=$line[12]+1;
	my $cg=$line[0];
	my $strand=$line[16];
	my $gene=$line[21];
	my $cpgisland=$line[25];
	my $probetype=$line[6];
        $gene="NA" if $gene eq "";
        $cpgisland="CpG_Ocean" if $cpgisland eq "";
        ($gene,undef)=split/\;/,$gene;
        print "chr$chr\t$start\t$end\t$cg\t$gene\t$strand\t$cpgisland\t$probetype\n";
	
}

