#!/usr/bin/perl

# transfer exm id to rs number id based on genomic coordination.

use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;

my $bim=shift @ARGV;
my $allsnp="/home/guosa/hpc/project/pmrp/phase1/plink/Illumina_CoreExome_Beadchip.hg19.exm2rs.bed";
print "input file should be bim\n";
open F1,"$allsnp" || die "cannot open $allsnp\n";
open F2,"$bim" || die "cannot open $bim\n";
open OUT,">$bim.newid";
my %bim;
my %allsnp;

while(<F1>){
        chomp;
        my($chr,undef,$pos,$exm,undef,undef,undef,undef,undef,undef,$rs,undef)=split/\s+/;
        $allsnp{"$chr:$pos"}=$rs;
}
print "SNP file reading completed.....\n";

while(<F2>){
        chomp;
        my $line=$_;
        my($chr,$exmid,undef,$end,$ref,$alt)=split/\s+/,$line;
        my $loc="chr$chr:$end";
        if ($allsnp{$loc}){
        print OUT "$chr\t$allsnp{$loc}\t0\t$end\t$ref\t$alt\n";
        print  "$chr\t$allsnp{$loc}\t0\t$end\t$ref\t$alt\n";
        }else{
        print OUT "$line\n";
        }
}
print "change the exm id to rs number completed...\n";
