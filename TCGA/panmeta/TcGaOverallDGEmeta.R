source("https://raw.githubusercontent.com/Shicheng-Guo/GscRbasement/master/GscTools.R")
library("meta")
library("metafor")
library("survival")
library("survminer")

db<-read.table("https://raw.githubusercontent.com/Shicheng-Guo/AnnotationDatabase/master/ENSG.ENST.ENSP.Symbol.hg19.bed",sep="\t")
Symbol2ENSG<-function(Symbol,db){
  ENSG<-as.character(db[match(Symbol,db$V4),8])
  ENSG<-na.omit(data.frame(Symbol,ENSG))
  return(ENSG)
}
ENSG2Symbol<-function(ENSG,db){
  ENSG<-unlist(lapply(strsplit(ENSG,split="[.]"),function(x) x[1]))
  Symbol<-db[match(as.character(ENSG),db$V8),4]
  return(Symbol)
}
ensg2bed<-function(ENSG,db){
  ENSG<-unlist(lapply(strsplit(ENSG,split="[.]"),function(x) x[1]))
  bed<-unique(db[db$V5 %in% as.character(ENSG),c(1,2,3,5)])
  return(bed)
}

chr2num<-function(x){
x<-output$V1
x<-gsub("chr","",x)
x[x=="X"]<-23
x[x=="Y"]<-24
return(x)
}

chr2num<-function(x){
x<-output$V1
x<-gsub("chr","",x)
x[x=="X"]<-23
x[x=="Y"]<-24
return(x)
}

load("~/hpc/methylation/Pancancer/RNA-seq/rnaseqdata.pancancer.RData")

TCGAProjects=c("BLCA","BRCA","CESC","CHOL","COAD","ESCA","GBM","HNSC","KICH","KIRC","KIRP","LIHC","LUAD","LUSC","PAAD","PCPG","PRAD","READ","SARC","STAD","THCA","THYM","UCEC")
phen1=read.table("~/hpc/methylation/TCGA-clinical-11093.tsv",header = T,sep="\t")
phen2=read.table("~/hpc/methylation/Pancancer/RNA-seq/File_metadata2.txt",header = T,sep="\t")
head(phen1)
head(phen2)
colnames(rnaseqdata)<-unlist(lapply(strsplit(colnames(rnaseqdata),"/"),function(x) x[2]))
phen<-data.frame(phen2,phen1[match(phen2$cases.0.case_id,phen1$case_id),])
phen$file_name=gsub(".gz","",phen$file_name)

# prepare phenotype information
phen<-phen[match(colnames(rnaseqdata),phen$file_name),]
phen$phen4<-id2phen4(phen$cases.0.samples.0.submitter_id)
phen$phen3<-id2phen3(phen$cases.0.samples.0.submitter_id)
phen$phen2<-id2bin(phen$cases.0.samples.0.submitter_id)
phen$pid<-phen$project_id
head(phen)

idx<-which(phen$phen2==1 | phen$phen2==11)
phen<-phen[idx,]
input<-rnaseqdata[,idx]

idx<-which(phen$pid %in% paste("TCGA-",TCGAProjects,sep=""))
phen<-phen[idx,]
input<-input[,idx]
noise<-abs(matrix(rnorm(ncol(input)*nrow(input),0,0.01),nrow=nrow(input),ncol=ncol(input)))
input<-input+noise

input<-log(input+1,2)
input<-RawNARemove(input)
input<-RawZeroRemove(input)

Seq<-paste(phen$project_id,phen$phen2,sep="-")
rlt<-c()
for(i in 1:nrow(input)){
  mean<-tapply(as.numeric(input[i,]),Seq,function(x) mean(x,na.rm=T))
  sd<-tapply(as.numeric(input[i,]),Seq,function(x) sd(x,na.rm=T))
  num<-tapply(as.numeric(input[i,]),Seq,function(x) length(x))
  m1i=mean[seq(1,length(mean),by=2)]
  m2i=mean[seq(2,length(mean),by=2)]
  sd1i=sd[seq(1,length(mean),by=2)]
  sd2i=sd[seq(2,length(mean),by=2)]
  n1i=num[seq(1,length(mean),by=2)]
  n2i=num[seq(2,length(mean),by=2)]
  Source<-unlist(lapply(strsplit(names(m1i),"-"),function(x) x[2]))
  output<-data.frame(cbind(n1i,m1i,sd1i,n2i,m2i,sd2i))
  output$source=Source
  output<-na.omit(output)
  es<-escalc(m1i=m1i, sd1i=sd1i, n1i=n1i, m2i=m2i, sd2i=sd2i, n2i=n2i,measure="MD",data=output)
  md <- rma(es,slab=source,method = "REML", measure = "SMD",data=output)
  rlt<-rbind(rlt,c(i,md$beta,md$pval,md$ci.lb,md$ci.ub,md$I2,md$tau2))
  m<-metagen(yi,seTE=vi,data = es,
             comb.fixed = TRUE,
             comb.random = TRUE,
             prediction=F,
             sm="SMD")
print(c(i, rownames(input)[i]))
# Symbol<-ENSG2Symbol(rownames(input)[i],db)
# print(c(z,i,as.character(Symbol)))
# pdf(paste(Symbol,"-",rownames(input)[i],".SMD.PANC.pdf",sep=""))
# forest(m,leftlabs = Source,
#          lab.e = "Intervention",
#         pooled.totals = FALSE,
#         smlab = "",studlab=Source,
#         text.random = "Overall effect",
#         print.tau2 = FALSE,
#         col.diamond = "blue",
#         col.diamond.lines = "black",
#         col.predict = "red",
#         print.I2.ci = TRUE,
#         digits.sd = 2,fontsize=8)
#  dev.off()
}
rownames(rlt)<-rownames(input)
colnames(rlt)<-c("idx","beta","pval","cilb","ciub","i2","tau2")
rlt2<-data.frame(rlt)
rlt2<-rlt2[order(rlt2$pval),]
rlt2$symbol<-as.character(ENSG2Symbol(as.character(rownames(rlt2))),db)
head(rlt2)
# save dge to csv
setwd("/home/guosa/hpc/meta")
write.table(rlt2,file=paste("tcga.pancancer.smd.meta.pvalue.txt",sep=""),sep="\t",quote=F,col.names = NA,row.names = T)
write.csv(rlt2,file=paste("tcga.pancancer.smd.meta.pvalue.csv",sep=""),quote=F)

dim(subset(rlt2,pval<10^-8))
up<-(subset(rlt2,beta>0 & pval<10^-8))
down<-(subset(rlt2,beta<0 & pval<10^-8))
write.csv(up,file=paste("up.tcga.pancancer.smd.meta.pvalue.csv",sep=""),quote=F)
write.csv(down,file=paste("down.tcga.pancancer.smd.meta.pvalue.csv",sep=""),quote=F)