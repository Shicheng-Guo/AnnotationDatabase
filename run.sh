#!/bin/bash
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz 
awk '{print $3,$5,$6,$4,$2,$13}' OFS="\t" refGene.txt | bedtools sort  > refGene.hg19.bed
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/refGene.txt.gz 
awk '{print $3,$5,$6,$4,$2,$13}' OFS="\t" refGene.txt | bedtools sort  > refGene.hg38.bed
