## https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL21145
map<-read.csv("~/hpc/db/hg19/GPL21145_MethylationEPIC_15073387_v-1-0.csv",skip=7,head=T)
newmap<-map[,c(12,13,1,7,15,18,19)]
newmap$CHR=paste("chr",newmap$CHR,sep="")
newmap$START=newmap$MAPINFO-1
newmap$END=newmap$MAPINFO
bed<-newmap[,c(1,8,9,3)]
write.table(bed,file="MethylationEPIC.hg19.bed",sep="\t",quote=F,col.names = F,row.names = F)

awk '{print $1,$2,$3,$4}' OFS="\t" MethylationEPIC.hg19.bed | grep -v 'NA' | bedtools sort -i > MethylationEPIC.hg19.sort.bed

