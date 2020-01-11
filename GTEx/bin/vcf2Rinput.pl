open F,shift @ARGV;
while(<F>){
next if /^#/;
my ($chr,$pos,$rs,$ref,$alt,undef)=split /\s+/;
my $key="chr".$chr."_".$pos."_".$ref."_".$alt."_b38";
print "$key\t$rs\n";
}
