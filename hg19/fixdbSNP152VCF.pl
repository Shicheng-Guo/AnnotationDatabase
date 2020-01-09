use strict;
use warnings;
$ARGV[0] or die "use fixdbSNP152VCF.pl <VCF> <FIX_VCF>\n";
my $orig_vcf = shift @ARGV;
my $new_vcf = shift @ARGV;
my (%seq,$chr, $snp,$pos, $ref, $obs);
open (my $vh, "<", $orig_vcf) or die "cannot read $orig_vcf\n";
open (my $oh, ">", $new_vcf) or die "cannot write $new_vcf\n";
while (<$vh>) {
    if (/^#/) {
         print $oh $_;
    } else {
        chomp;
        my @var = split (/\t/, $_);
        $var[0]= $1 if ($var[0] =~ /0+(\d+)/);
        print $oh join "\t", @var;
        print $oh  "\n";
    }
}
close $vh;
close $oh;
