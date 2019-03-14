 Retrieval and integration of the molecular and pharmacological data sets for the NCI-60 cell lines. The NCI-60, a panel of 60 diverse human cancer cell lines used by the Developmental Therapeutics Program of the U.S. National Cancer Institute to screen over 100,000 chemical compounds and natural products (since 1990).
 
 * [NCI-60](https://discover.nci.nih.gov/cellminer/loadDownload.do)

```
cd \\mcrfnas2\bigdata\Genetic\Projects\shg047\methylation\NCI60\output
cd /home/guosa/hpc/methylation/NCI60/output
grep -P '^cg|Probe\sid\s\(' DNA__Illumina_450K_methylation_Beta_values.txt.txt > DNA__Illumina_450K_methylation_Beta_values.txt
data<-read.table("DNA__Illumina_450K_methylation_Beta_values.txt",sep="\t",head=T,row.names=1)
newdata<-data[,13:(ncol(data)-1)]
write.table(colnames(newdata),file="NCI60-meth450k.cells.txt",sep="\t",quote=F)
output=unique(newdata)
RowName<-unlist(lapply(rownames(output),function(x) unlist(strsplit(x,"~"))[1]))
rownames(output)=RowName
nci60methdata=output
save(nci60methdata,file="NCI60-meth450k.beta.RData")
write.table(output,file="NCI60-meth450k.beta.txt",sep="\t",quote=F,col.names = NA,row.names = T)

cellLines<-names(table(unlist(lapply(colnames(nci60methdata),function(x) unlist(strsplit(x,"[.]"))[1]))))
for(i in cellLines){
  beta<-nci60methdata[,grep(i,colnames(nci60methdata))]
  save(beta,file=paste(i,"beta.RData",sep="."))
  print(i)
}
```
