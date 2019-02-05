 use strict;
 use Cwd;
 my $dir=getcwd;
 chdir $dir or die "can't change into $dir\n";
 my $output=">CpGISF.hg19.bed";
 my $input="CpGI.hg19.txt";
 open F,"$input";
 open OUT,"$output";
 while(<F>){
 chomp;
 next if /bin/;
 my (undef,$chr,$start,$end,undef,undef)=split /\t/;
 my $shelfup=$start-4000;
 my $shelfdown=$end+4000;

 my $shoreup=$start-2000;
 my $shoredown=$end+2000;

 my $id1="$chr:$shelfup-$shoreup:CpG_Shelf_N";
 my $id2="$chr:$shoreup-$start:CpG_Shore_N";
 my $id3="$chr:$end-$shoredown:CpG_Shore_S";
 my $id4="$chr:$shoredown-$shelfdown:CpG_Shelf_S";
 my $id="$chr:$start-$end:CpGI";

 print OUT "$chr\t$shelfup\t$shoreup\t$id1\n";
 print OUT "$chr\t$shoreup\t$start\t$id2\n";
 print OUT "$chr\t$start\t$end\t$id\n";
 print OUT "$chr\t$end\t$shoredown\t$id3\n";
 print OUT "$chr\t$shoredown\t$shelfdown\t$id4\n";
 }
