read.table("DonneesEvalTP17.csv",sep=",",header=T,dec=",")->donnees #lecture des données
head(donnees);names(donnees) #premieres lignes et noms de colonnes
#transformation des facteurs en var quantitative, nom et affichage
as.numeric(as.character(donnees$M))->M;M
as.numeric(as.character(donnees$FE))->FE;FE
as.numeric(as.character(donnees$FO))->FO;FO
as.numeric(as.character(donnees$A))->A;A
as.numeric(as.character(donnees$C))->C;C
as.numeric(as.character(donnees$HHTP))->HHTP;HHTP
donnees$HBin->HBin
donnees$CBin->CBin
#resumés numériques
summary(A);sd(A)
summary(M);sd(M)
summary(FE);sd(FE)
summary(FO);sd(FO)
summary(C);sd(C)
summary(HHTP);sd(HHTP)
summary(CBin);sd(CBin)
summary(HBin);sd(HBin)
prop.table(table(HBin,CBin))
#Extraire selon un facteur
as.numeric(as.character(donnees[donnees$Gpe=="CHBI","A"]))->ACHBI
as.numeric(as.character(donnees[donnees$Gpe=="CHBI","HBin"]))->HBCHBI

#Sujet 1
######################################
as.numeric(as.character(donnees[donnees$Gpe=="CHBI","M"]))->MCHBI#ech de X1
as.numeric(as.character(donnees[donnees$Gpe!="CHBI","M"]))->MINFM#ech de X2
#question 1
#ech de X1
t.test(MCHBI,conf.level=0.9)
var(MCHBI) 
length(MCHBI)
#ech de X2
t.test(MINFM,conf.level=0.9)
var(MINFM) 
length(MINFM)
#question 2
t.test(MCHBI,MINFM,var.equal=T) #bilateral
#question 3
t.test(MCHBI,MINFM,var.equal=T,alternative="less") #unilateral gauche
#question 4
HBin #echantillon de HBin pour tous
CBin #echantillon de CBin pour tous
table(HBin,CBin)#table de contingence
chisq.test(table(HBin,CBin))
#Sujet 2
######################################
M #ech de X
FE #ech de Y
#question 1
#ech de X1
t.test(M,conf.level=0.9)
var(M) 
length(M)
#ech de X2
t.test(FE,conf.level=0.9)
var(FE) 
length(FE)
#question 2
t.test(M,FE,paired=T) #bilateral pour appariés
#question 3
t.test(M,FE,paired=T,alternative="greater") #unilateral droit
#question 4
HBin[donnees$Gpe=="CHBI"]->HBCHBI #echantillon de HBin pour les CHBI
CBin[donnees$Gpe=="CHBI"]->CBCHBI #echantillon de CBin pour les CHBI

table(HBCHBI,CBCHBI)#table de contingence
chisq.test(table(HBCHBI,CBCHBI))
12*11/38

#Sujet 3
######################################
as.numeric(as.character(donnees[donnees$UE=="STA","HBin"]))->HBSTA#ech de HBin chez STA
as.numeric(as.character(donnees[donnees$UE=="MAT","HBin"]))->HBMAT#ech de HBin chez MAT 
#question 1
#pour p1
prop.test(sum(HBSTA),length(HBSTA),conf.level=0.9)
length(HBSTA)
#pour p2
prop.test(sum(HBMAT),length(HBMAT),conf.level=0.9)
length(HBMAT)



#question 2
prop.test(sum(HBSTA),length(HBSTA),conf.level=0.9)

#question 3
prop.test(sum(HBSTA),length(HBSTA),conf.level=0.9,alternative="less")

#question 4
HBin #ech de Hbin
CBin #ech de CBin
table(CBin,HBin)#table de contingence
prop.table(table(CBin,HBin),1)
chisq.test(table(HBin,CBin))

#Sujet 4
######################################
as.numeric(as.character(donnees[donnees$UE=="STA","HBin"]))->HBSTA#ech de HBin chez STA
as.numeric(as.character(donnees[donnees$UE=="MAT","HBin"]))->HBMAT#ech de HBin chez MAT 
#question 1
#pour p1
prop.test(sum(HBSTA),length(HBSTA),conf.level=0.9)
length(HBSTA)
#pour p2
prop.test(sum(HBMAT),length(HBMAT),conf.level=0.9)
length(HBMAT)



#question 2
prop.test(sum(HBMAT),length(HBMAT),conf.level=0.9)

#question 3
prop.test(sum(HBMAT),length(HBMAT),conf.level=0.9,alternative="greater")

#question 4
HBin #ech de Hbin
CBin #ech de CBin
table(CBin,HBin)#table de contingence
prop.table(table(CBin,HBin),1)
chisq.test(table(HBin,CBin))



