 my $cytoband=shift @ARGV;
 open F,$cytoband;
 while(<F>){
 if(/chr(\d+)/){
 chomp;
 my ($chr,$start,$end,$cytoband,$tp)=split/\s+/;
 print "$chr\t$start\t$end\t$1$cytoband\n";
 }
 }
 
