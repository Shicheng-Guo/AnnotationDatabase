#!/usr/bin/perl
use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;

my $snp="/home/local/MFLDCLIN/guosa/hpc/db/hg19/allsnp150.hg19";
my $cpg="/home/local/MFLDCLIN/guosa/hpc/db/hg19/fa/chr10.CpG.positions.txt";

open F1,"$snp";
open F2,"$cpg";

my %snp;
my %cpg;

open OUT, "> CpGSNP.txt";
while(<F1>){
    chomp;
    my(undef,$chr,$pos,undef,$rs)=split/\s+/;
    $snp{"$chr:$pos"}=$rs;	
# print "test: $chr\t$pos\t$rs\n";
}

while(<F2>){
    chomp;
    my($chr,$pos)=split/\s+/;
    $snp{"$chr:$pos"}="$chr:$pos";	
print "test: $chr\t$pos\n";
}

foreach my $pos(keys %snp){
if ($cpg{$pos}){
my($chr,$bp)=split /:/,$pos;
print OUT "$chr\t$pos\t$snp{$bp}\n";
print "$pos\t$snp{$pos}\n";
}
}
close OUT
