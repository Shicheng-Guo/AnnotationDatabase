use strict;
use Cwd;

my @file=glob("*.egenes.txt");
my %eqtl;
my %tissue;
foreach my $file(@file){
my ($tissuetype)=split /\./,$file;
$tissue{$tissuetype}=$tissuetype;
open F,$file;
while(<F>){
my @line=split/\s+/;
if($line[28]>0.05){
$eqtl{$line[18]}{$tissuetype}=0;
}else{
$eqtl{$line[18]}{$tissuetype}=$line[24];
}
}
}

my $header=join("\t",sort keys %tissue);
print "\t$header\n";

foreach my $rs(sort keys %eqtl){
        next if $rs eq ".";
        print "$rs";
        foreach my $tissue(sort keys %tissue){
        if(defined $eqtl{$rs}{$tissue}){
        print "\t$eqtl{$rs}{$tissue}";
        }else{
        print "\t0";
        }
        }
        print "\n"
}
