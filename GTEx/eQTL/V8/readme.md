
### script to merge eQTL-V8 to data.matrix
```
wget https://storage.googleapis.com/gtex_analysis_v8/single_tissue_qtl_data/GTEx_Analysis_v8_eQTL.tar
tar xvf GTEx_Analysis_v8_eQTL.tar
cd GTEx_Analysis_v8_eQTL
gunzip *.gz  
wget https://raw.githubusercontent.com/Shicheng-Guo/AnnotationDatabase/master/eQTL/GTEx/eqtl2matrix.pl
perl eqtl2matrix.pl > eqtl.v8.txt
```

### Creat standard chain to connect rsID (rs10454454) and GWAS key (chr1_819574_G_A_b38) 
