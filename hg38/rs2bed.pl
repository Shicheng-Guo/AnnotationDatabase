use strict;
use Cwd;
use List::Util qw( min max );
chdir getcwd;

my $input=shift @ARGV;
open F,$input || die "cannot open rs number file: $input\n";
my %snp;
while(<F>){
next if /Start/i;
chomp;
my($rs)=split/\s+/;
$snp{$rs}=$rs;
}
close F;

my $snpdb1="/home/guosa/hpc/db/hg19/allSNP150.hg19.bed";
my %db1;
open F,$snpdb1 || die "cannot open $snpdb1\n";
while(<F>){
my($chr,$start,$end,$rs)=split/\s+/;
my $cord="$chr:$start-$end";
$db1{$rs}=$cord;
}
close F;

my $snpdb2="/home/guosa/hpc/db/hg38/allSNP150.hg38.bed";
my %db2;
open F,$snpdb2 || die "cannot open $snpdb2\n";
while(<F>){
my($chr,$start,$end,$rs)=split/\s+/;
my $cord="$chr:$start-$end";
$db2{$rs}=$cord;
}
close F;

open OUT1,">$input.hg19.bed";
open OUT2,">$input.hg38.bed";
foreach my $snp(sort keys %snp){
my ($chr1,$start1,$end1)=split/[:-]/,$db1{$snp};
my ($chr2,$start2,$end2)=split/[:-]/,$db2{$snp};
print OUT1 	"$chr1\t$start1\t$end1\t$snp\n";
print OUT2 	"$chr2\t$start2\t$end2\t$snp\n";
}
close OUT1;
close OUT2;

