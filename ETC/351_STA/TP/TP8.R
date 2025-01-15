#----------------------------------------------------------------------
#                         TP8
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Exercice 1
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
ME <- 23                                    # malades exposes
SE <- 56                                    # sains exposes
MNE <- 67                                   # malades non exposes
SNE <- 136                                  # sains non exposes
ta <- rbind(c(ME,SE),c(MNE,SNE))            # table de contingence
rownames(ta) <- c("expose","non expose")
colnames(ta) <- c("malades","sains")
ta
#----------------------- question 1 -----------------------------------
prop.table(ta,1)    #fréquences conditionnelles à l'exposition
prop.table(ta,2)    #fréquences conditionnelles à l'etat du patient
barplot(prop.table(ta,1),beside=TRUE) #gris diff pour chaque rep condit à l'exp
#les deux conditi sont tres semblables on serait donc tenter de dire 
#indépendance entre exposition et etat du patient
#----------------------- question 3 -----------------------------------
chisq.test(ta)
#ce qui confirme la conclusion précédente et la valide : rien ne permet en effet ici
#de declarer qu'exposition et etat sont lies (à moins de le conclure avec un risque d'erreur
#superieur à 63%!)



#----------------------------------------------------------------------
# Exercice 2
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
titanic <- read.table("titanic.csv",header=TRUE,sep=";")
P <- titanic$pclass
S <- titanic$survived
G <- titanic$gender
A <- titanic$age
#----------------------- question 2 -----------------------------------
ta <- table(S,G); ta
prop.table(ta,2)                            # proportions conditionnelles
#----------------------- question 3 -----------------------------------
chisq.test(ta)
# p-value =  2.567603e-67: les distributions sont significativement differentes
#----------------------- question 4 -----------------------------------
A10<- A<10
ta <- table(S,A10); ta
prop.table(ta,2)                            # proportions conditionnelles
chisq.test(ta)
# p-value =  0.0001763: les distributions sont significativement differentes
#----------------------- question 5 -----------------------------------
A21<- A<21
ta <- table(S,A21); ta
chisq.test(ta)
# p-value =  0.07999: les distributions ne sont pas significativement differentes

#----------------------------------------------------------------------
# Exercice 3
#----------------------------------------------------------------------
effobs<-c(1790,547,548,213)
probth<-c(9/16,3/16,3/16,1/16)
chisq.test(effobs,p=probth)

#----------------------------------------------------------------------
# Exercice 4
#----------------------------------------------------------------------
head(mtcars)
help(mtcars)
mtcars$qsec->qsec
hist(qsec,breaks=c(14,16,17,18,19,23))$counts->effobs
sum(effobs)
m=mean(qsec)
s=sd(qsec)
pnorm(16,m,s)-pnorm(14,m,s)->p1
pnorm(17,m,s)-pnorm(16,m,s)->p2
pnorm(18,m,s)-pnorm(17,m,s)->p3
pnorm(19,m,s)-pnorm(18,m,s)->p4
pnorm(23,m,s)-pnorm(19,m,s)->p5

chisq.test(effobs,p=c(p1,p2,p3,p4,p5)) #la somme des p_k diffère de 1
#pour y remédier on remplace p1 par p1c et p6 par p6c
pnorm(16,m,s)->p1c
1-pnorm(19,m,s)->p5c
chisq.test(effobs,p=c(p1c,p2,p3,p4,p5c))
chisq.test(effobs,p=c(p1c,p2,p3,p4,p5c))$expected
#il faudrait réunir les deux premières classes
1-pchisq(chisq.test(effobs,p=c(p1c,p2,p3,p4,p5c))$statistic,2)

shapiro.test(qsec)
