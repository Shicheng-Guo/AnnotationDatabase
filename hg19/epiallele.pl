use strict;
use Cwd;
use POSIX;
my $dir = getcwd;
chdir $dir;

my $chr=shift @ARGV;

my %iupac=(
'A/G' => 'R',
'C/T' => 'Y',
'A/C' => 'M',
'G/T' => 'K',
'C/G' => 'S',
'A/T' => 'W',
'A/C/T' => 'H',
'C/G/T' => 'B',
'A/C/G' => 'V',
'A/G/T' => 'D',
'A/C/G/T' => 'N',
);

sub match_all_positions {
	my @regex1= qw /YG MG SG HG BG VG NG/;
	my @regex2= qw /CR CK CS CB CV CD CN/;
    my @regex3;
	for my $i(qw /Y M S H B V N/){
		for my $j(qw /R K S B V D N/){
			push @regex3,"$i$j";
		}
	}
	my $regex1=join "|",@regex1;
	my $regex2=join "|",@regex2;
	my $regex3=join "|",@regex3;
    my ($string) = shift @_;
    my @ret;
    while ($string =~ /$regex1/g) {
        push @ret, [$-[0], $+[0],"C"];
    }
    while ($string =~ /$regex2/g) {
        push @ret, [$-[0], $+[0],"G"];
    }
    while ($string =~ /$regex3/g) {
        push @ret, [$-[0], $+[0],"C"];
    }
    return @ret
}

open F1,"$chr.fa"|| die "cannot open $chr.fa!\n";
my $genome;
while(<F1>){
    chomp;
    next if />/;
    $_=~s/N/X/g;
    $genome .=$_;
}
my @seq=split //,$genome;
close F1;

open F2,"$chr.vcf.bed" || die "cannot open $chr.vcf.bed! (commonSNP or allSNP)\n";
open OUT,">$chr.mask.fa";
my %database;
while(<F2>){
    chomp;
    my $line=$_;
    my ($chr,$start,$end,$rs,$strand,$ref,$alt)=split/\s+/,$line;
    my $position=$end-1;
	next if !$iupac{$alt};
    $seq[$position]=$iupac{$alt};
    $database{"$end"}=$line;
}
close F2;

my $line=0;
foreach my $seq(@seq){
	$line++;
	print OUT "$seq";
	print OUT "\n" if $line % 100 ==0;
}
close OUT;

my $maskgenome=join "",@seq;
open OUT2,">$chr.CpGSnp.bed" || die "cannot open $chr.CpGSnp.bed!\n";
my @pos=&match_all_positions($maskgenome);
foreach my $pos(@pos){
	my $start= $$pos[2] eq "C"? $$pos[0]:($$pos[0]+1);
	my $end =$$pos[2] eq "C"? $$pos[0]+1:($$pos[0]+2);
	my $mode=join "", @seq[($$pos[0]-1)..(($$pos[1]))];
	my $output=join "\t",split /\s+/,$database{$end};
	print OUT2 "$chr\t$start\t$end\t$output\t$mode\n";
}
close OUT2;
