# system("wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/simpleRepeat.txt.gz");
# system("gunzip simpleRepeat.txt.gz");
open F,"/home/guosa/hpc/db/hg19/repeat.hg19.txt";
open OUT,">repeat.hg19.bed";
while(<F>){
	my @line=split /\t/;
	my $chr=$line[5];
	my $start=$line[6];
	my $end=$line[7];
	my $strand=$line[9];
	my $repName=$line[10];
	my $repClass=$line[11];
	my $repFamily=$line[12];
	print OUT "$chr\t$start\t$end\t$strand\t$repName\t$repClass\t$repFamily\n"; 
}
close OUT;
