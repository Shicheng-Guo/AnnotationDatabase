
## Annotation Database


USAGE: Build Annotation For human Genome or Epigenome

Timeline: 
* only SNPs, P-value were kept in 49 eQTL `v8.signif_variant_gene_pairs.txt` so that files `<25M`
* majority of the time is used to read dbSNP153.bin.chain.txt into memmory and loop eqtl is very fast
* dbSNP153.bin.chain.txt is `21G` and will be `105G` in the CHG1 memory and takes `25` minutes with [add rsid perl script](https://github.com/Shicheng-Guo/AnnotationDatabase/blob/master/GTEx/bin/addrs2pairs.pl)
* 2020/01/01: add rsid to GTEx v8.signif_variant_gene_pairs.txt files to match with m6A-Var, [script](https://github.com/Shicheng-Guo/AnnotationDatabase/blob/master/GTEx/bin/addrs2pairs.pl) and [result](./GTEx/)
* 2020/01/01: [GWAS-Catalog](https://github.com/Shicheng-Guo/gwascatlog) Updated to hg38 from hg19. 


Basic information should be included:

1, genomic assemble version: hg19, hg38, mm9, mm10

2, bedGraph format would be perfect for usage

3, PBMC or GEO ID should be recorded.

4, Basic annotation information and method

5, Basic study design and sample size and populations (China, European or US)
