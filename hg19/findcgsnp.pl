#!/usr/bin/perl
use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;

my $snp="/home/local/MFLDCLIN/guosa/hpc/db/hg19/allsnp150.hg19";
my $cpg="/home/local/MFLDCLIN/guosa/hpc/db/hg19/fa/chr6.CpG.positions.txt";

open F1,"$snp";
open F2,"$cpg";

my %snp;
my %cpg;

open OUT, "> CpGSNP.txt";
while(<F1>){
	chomp;
	my($chr,$pos,undef,$rs,undef)=split/\s+/;
    $snp{"$chr:$pos"}=$rs;	
}

while(<F2>){
	chomp;
	my($chr,$pos)=split/\s+/;
    $cpg{"$chr:$pos"}="$chr:$pos";	
}

foreach my $pos(keys %snp){
if ($cpg{$pos}){
my($chr,$bp)=split /:/,$pos;
print OUT "$chr\t$pos\t$snp{$bp}\n";
print "$pos\t$snp{$pos}\n";
}
}
close OUT
