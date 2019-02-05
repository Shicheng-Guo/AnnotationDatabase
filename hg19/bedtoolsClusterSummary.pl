


use strict;
use Cwd;
use POSIX;
my $dir = getcwd;
chdir $dir;

my $file="commonSNP_hg19_v1_sort_cluster.bed";
open OUT,">commonSNP_hg19_v1_sort_cluster.bed.summary";
my %database;
my $cluster;
open(IN, $file) or die "open $file: $!";
my $i;
my %start;
my %end;
my %chr;
while(<IN>){
chomp;
my @line=split/\s+/;
push @{$chr{$line[$#line]}},$line[0];
push @{$start{$line[$#line]}},$line[1];
push @{$end{$line[$#line]}},$line[2];
$cluster=$line[$#line];
}
close IN;

foreach my $i(1..$cluster){
	my $chr=@{$chr{$i}}[0];
	my $start=@{$start{$i}}[0];
	my $end=@{$end{$i}}[$#{$end{$i}}];
	my $len=$end-$start;
        my $num=$#{$end{$i}}+1;
	my $avDist=ceil($len/$num);
        print OUT "$chr\t$start\t$end\t$len\t$num\t$avDist\n";
}
close OUT;
