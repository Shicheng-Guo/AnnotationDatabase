data1<-read.table("https://raw.githubusercontent.com/Shicheng-Guo/HowtoBook/master/TCGA/lung/TissueLowExpHyperGene.txt",head=T)
rlt<-data.frame(MethQ0=tapply(data1$Q0,data1$GENESYMBOL,mean),MethQ25=tapply(data1$Q25,data1$GENESYMBOL,mean),TPMBlood=tapply(data1$Blood,data1$GENESYMBOL,mean),Blood2TissueRatio=tapply(data1$B2TRatio,data1$GENESYMBOL,mean))
write.table(rlt,file="../../TissueLowExpHyperGene.txt",sep="\t",quote=F,row.names = T,col.names = NA)

data1<-read.table("https://raw.githubusercontent.com/Shicheng-Guo/HowtoBook/master/TCGA/Pancancer_FPKM_UQ/TCGA-Pancancer-RNAseq-FPKM-UQ.Meta.diff.Symbol.txt",head=T,sep="\t")
newdata<-data1[order(data1$pval),]
head(newdata$hgnc_symbol,30)

TSG1<-read.table("https://raw.githubusercontent.com/Shicheng-Guo/AnnotationDatabase/master/COSMIC.TSG.hg19.bed",sep="\t")
head(TSG1)
TSG2<-read.table("https://raw.githubusercontent.com/Shicheng-Guo/AnnotationDatabase/master/TSGene2.0.txt",sep="\t")
head(TSG2)
rlt1<-data1[data1$hgnc_symbol %in% TSG1$V4,]
rlt2<-data1[data1$hgnc_symbol %in% TSG2$V2,]
head(rlt1)
head(rlt2)


pdf("../../Volcano.TSG.Pancancer.RNAseq.pdf")
par(mfrow=c(2,2))

with(rlt1, plot(beta, -log10(pval), pch=20, main="Volcano plot", xlim=c(-5,5)))
# Add colored points: red if padj<0.05, orange of log2FC>1, green if both)
with(subset(rlt1, pval<.0000005 ), points(beta, -log10(pval), pch=20, col="red"))
with(subset(rlt1, abs(beta)>1), points(beta, -log10(pval), pch=20, col="orange"))
with(subset(rlt1, pval<.0000005 & abs(beta)>1), points(beta, -log10(pval), pch=20, col="green"))
library(calibrate)
with(subset(rlt1, pval<.00005 & abs(beta)>1), textxy(beta, -log10(pval), labs=hgnc_symbol, cex=.5))

with(rlt2, plot(beta, -log10(pval), pch=20, main="Volcano plot", xlim=c(-5,5)))
# Add colored points: red if padj<0.05, orange of log2FC>1, green if both)
with(subset(rlt2, pval<.00000005 ), points(beta, -log10(pval), pch=20, col="red"))
with(subset(rlt2, abs(beta)>2), points(beta, -log10(pval), pch=20, col="orange"))
with(subset(rlt2, pval<.00000005 & abs(beta)>2), points(beta, -log10(pval), pch=20, col="green"))
library(calibrate)
with(subset(rlt2, pval<.00000005 & abs(beta)>2), textxy(beta, -log10(pval), labs=hgnc_symbol, cex=.5))
dev.off()
