#chargement, affectation et lecture des six premières lignes de fichiers txt ou csv
#################################################################################

#donneesSerie4.csv
read.table("donneesSerie4.csv",header=F,sep=" ",dec=".")->serie4
head(serie4)

#diamantsPurs.csv
read.table("diamantsPurs.csv",header=T,sep=" ",dec=".")->diamants
head(diamants)

#cardiaque.csv
read.table("cardiaque.csv",header=T,sep=",",dec=".")->card
head(card)
 #ou avec le raccourci read.csv
read.csv("cardiaque.csv")->cardiaque
head(cardiaque)

#apnee.csv
read.table("apnee.csv",header=T,sep=",",dec=".")->apnee
head(apnee)

#her.txt
read.table("her.txt",header=T,sep="\t",dec=".")->her
head(her)

#proteine.csv
read.csv("proteine.csv")->proteine
head(proteine)
