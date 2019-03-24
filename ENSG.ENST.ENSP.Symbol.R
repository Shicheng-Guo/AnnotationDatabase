Symbol1<-read.table("/home/guosa/hpc/temp/Homo_sapiens.GRCh38.95.entrez.tsv",head=T,sep="\t")
Symbol2<-read.table("~/hpc/db/hg19/ENST2Symbol.hg19.txt",head=F,sep="\t")
Symbol2$ENST1<-unlist(lapply(strsplit(as.character(Symbol2$V2),split="[.]"),function(x) x[1]))
Symbol2$ENST2<-unlist(lapply(strsplit(as.character(Symbol2$V2),split="[_]"),function(x) x[1]))
Symbol2<-Symbol2[,c(2:6,13,17:18)]
head(Symbol1)
head(Symbol2)
Symbol<-merge(Symbol1,Symbol2,by.x="transcript_stable_id",by.y="ENST1")
Symbol<-Symbol[,c(11:15,1:3,10,16)]
head(Symbol)
write.table(Symbol,file="ENSG.ENST.ENSP.Symbol.hg19.bed",sep="\t",col.names = F,row.names = F,quote=F)

