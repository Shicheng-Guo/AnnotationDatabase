use strict;
use Cwd;
my $dir = getcwd;
chdir $dir;
open OUT,">commonAT-SNP_hg19_v1.txt";
foreach my $mychr(1..22,"X","Y"){
open F1,"/home/local/MFLDCLIN/guosa/hpc/db/hg19/fa/chr$mychr.fa" || die "cannot open chr6.fa";
my $genome;
while(<F1>){
    chomp;
    next if />/;
    $genome .=$_;
}
print "Now chr$mychr is starting\n";
close F1;
my $totalnum;
my $cpgallele;
open F2,"/home/local/MFLDCLIN/guosa/hpc/db/hg19/hg19_commonsnp150_trim.txt" || die "cannot open test.txt";
while(<F2>){
    chomp;
    next if /#chrom/;
    next if /random/;
    my $line=$_;
    my ($chr,$start,$end,$rs,$strand,$ref,$rlt)=split/\s+/,$line;
    my $r1=substr $genome,$start-1,1;
    my $r2=substr $genome,$start,1;
    my $r3=substr $genome,$start+1,1;
    next if $chr ne "chr$mychr";
    next if length($rlt)>3;
    next if length($ref)>2;
    $totalnum++;
    if($line =~/A/ && $r3 eq "T"){
    print OUT "$chr\t$start\t$end\t$rs\t$strand\t$ref\t$rlt\tC\t$r1$r2$r3\n";
    $cpgallele++;
    }elsif($line =~/T/ && $r1 eq "A"){
    print OUT "$chr\t$start\t$end\t$rs\t$strand\t$ref\t$rlt\tG\t$r1$r2$r3\n";
    $cpgallele++;
    }
}
close F2;
print "chr$mychr\t$cpgallele\/$totalnum\n";
}
close OUT;
