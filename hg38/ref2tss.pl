#!/usr/bin/perl -w
use strict;
use warnings;
use IO::Handle;
use File::Basename;
use Getopt::Long;
$|++;
# Separate Enhancer, Promoter, TSS, 5UTR, Exon, Intron, 3UTR from refGene files.
# Contact: Shicheng Guo
# Version 1.3
# Update: 2017-04-019
# promoter: [Tss-2K,Tss+2K]
# Enhancer: [Tss+2k,Tss+5K]
# TSS:      [Tss-500,Tss+2K]
# mm9.chrom.sizes, download from http://hgdownload.cse.ucsc.edu/goldenPath/mm9/bigZips/mm9.chrom.sizes
# hg19.chrom.sizes, download from http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes
my $haptools="v0.16.3_dev";
my $refGene= shift @ARGV;
my $chromsize= shift @ARGV;
my $output= shift @ARGV;
open F,$chromsize || die "cannot find or open $chromsize!";
my %chromesize;
while(<F>){
chomp;
my ($chr,$size)=split /\s+/;
$chromesize{$chr}=$size;
}
my($filename, $dirs, $suffix) = fileparse($refGene,qr/\./);
open TSS,">$filename.tss.bed";
open GENE,">$filename.bed";

open IN, $refGene or die "Can't open $refGene\n";
my %refGene;
while(<IN>){
    my ($bin,$NM,$chr,$strand,$txStart, $txEnd, $cdsStart, $cdsEnd, $exonCount, $exonStarts, $exonEnds,undef,$genesymbol,undef) = split /\t/;
    my @exonStarts = split(",", $exonStarts);
    my @exonEnds = split(",", $exonEnds);
    if($strand eq "+"){
    my @enhancer=($txStart-4000,$txStart-2001);
    my @promter=($txStart-2000,$txStart+2000);
	my @TSS=($txStart-500,$txStart+2000);
	my @UTR5=($txStart,$cdsStart);
	my @UTR3=($cdsEnd,$txEnd);
	next if $enhancer[0] <=0;
    next if $UTR3[1] >= $chromesize{$chr};
    print GENE "$chr\t$enhancer[0]\t$enhancer[1]\t$strand\t$NM\t$genesymbol\tEnhancer\tEnhancer\n";
    print GENE "$chr\t$promter[0]\t$promter[1]\t$strand\t$NM\t$genesymbol\tPromoter\tPromoter\n";
    print TSS "$chr\t$TSS[0]\t$TSS[1]\t$strand\t$NM\t$genesymbol\tTSS\tTSS\n";
    print GENE "$chr\t$UTR5[0]\t$UTR5[1]\t$strand\t$NM\t$genesymbol\tUTR5\tUTR5\n";
    my $exonrank;
    foreach my $i(0..($#exonStarts-1)){
    $exonrank++;
    print GENE "$chr\t$exonStarts[$i]\t$exonEnds[$i]\t$strand\t$NM\t$genesymbol\tExon\tExon$exonrank\n";
    print GENE "$chr\t$exonEnds[$i]\t$exonStarts[$i+1]\t$strand\t$NM\t$genesymbol\tIntron\tIntron$exonrank\n";
    }
    $exonrank++;
    print GENE "$chr\t$exonStarts[$#exonStarts]\t$exonEnds[$#exonStarts]\t+\t$NM\t$genesymbol\tExon\tExon$exonrank\n";
    print GENE "$chr\t$UTR3[0]\t$UTR3[1]\t$strand\t$NM\t$genesymbol\tUTR3\tUTR3\n";
    }elsif($strand eq '-'){
    my @enhancer=($txEnd+2001,$txEnd+4000);
    my @promter=($txEnd-2000,$txEnd+2000);
    my @TSS=($txEnd-500,$txEnd+2000);
	my @UTR5=($cdsEnd,$txEnd);
	my @UTR3=($txStart,$cdsStart);
    next if $enhancer[1] >= $chromesize{$chr};
    next if $UTR3[0]<=0;
    print GENE "$chr\t$enhancer[0]\t$enhancer[1]\t$strand\t$NM\t$genesymbol\tEnhancer\tEnhancer\n";
    print GENE "$chr\t$promter[0]\t$promter[1]\t$strand\t$NM\t$genesymbol\tPromoter\tPromoter\n";
    print TSS "$chr\t$TSS[0]\t$TSS[1]\t$strand\t$NM\t$genesymbol\tTSS\tTSS\n";
    print GENE "$chr\t$UTR5[0]\t$UTR5[1]\t$strand\t$NM\t$genesymbol\tUTR5\tUTR5\n";
    my $exonrank;
    foreach my $i(reverse((1..$#exonStarts))){
    $exonrank++;
    print GENE "$chr\t$exonStarts[$i]\t$exonEnds[$i]\t$strand\t$NM\t$genesymbol\tExon\tExon$exonrank\n";
    print GENE "$chr\t$exonEnds[$i-1]\t$exonStarts[$i]\t$strand\t$NM\t$genesymbol\tIntron\tIntron$exonrank\n";
    }
    $exonrank++;
    print GENE "$chr\t$exonStarts[0]\t$exonEnds[0]\t$strand\t$NM\t$genesymbol\tExon\tExon$exonrank\n";
    print GENE "$chr\t$UTR3[0]\t$UTR3[1]\t$strand\t$NM\t$genesymbol\tUTR3\tUTR3\n";
    }else{
    die "Please check the input file reference.txt, the thrid column should be strand: + or -\n";
    }        
}
	close TSS;
	print "\nFinished! Files were created as $filename.tss.bed and $filename.bed\n\n";
