#----------------------------------------------------------------------
#                         TP9
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Exercice 1
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
HER=read.table("her.txt", header=TRUE, sep="\t")
B<-HER$BMI
#----------------------- question 2 -----------------------------------
summary(B)                           # statistiques descriptives
n<-length(R)                         # longueur de l'échantillon
hist(B, prob=T)                      # histogramme
boxplot(B)                           # boite à moustaches
#----------------------- question 3 -----------------------------------
t.test(B,mu=25)
#----------------------- question 4 -----------------------------------
t.test(B,mu=25, alternative="greater")$p.value
#----------------------- question 5 -----------------------------------
S<-HER$sex
BH<-B[S==0]
t.test(BH, mu=23, alternative="greater")
BF<-B[S==1]
t.test(BF, mu=22, alternative="less")
Tr<-HER$treat
BT<-B[T==1]
t.test(BH, mu=25, alternative="greater")
BNT<-B[T==0]
t.test(BF, mu=26, alternative="less")



#----------------------------------------------------------------------
# Exercice 2
#----------------------------------------------------------------------
p0 <- 0.7
#----------------------- question 1 -----------------------------------
x<- 74; n<- 100; 
prop.test(x,n,p0)
prop.test(x,n,p0, correct=FALSE)
#----------------------- question 2 -----------------------------------
prop.test(x,n,p0,alternative="greater")
#----------------------- question 3 -----------------------------------
x<- 148; n<- 200; 
prop.test(x,n,p0,alternative="greater")
#----------------------- question 4 -----------------------------------
x<- 740; n<- 1000; 
prop.test(x,n,p0,alternative="greater")


#----------------------------------------------------------------------
# Exercice 3
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
data=read.table("her.txt", header=TRUE, sep="\t")
#----------------------- question 2 -----------------------------------
chol<-data$chol                          # echantillon continu
#----------------------- question 3 -----------------------------------
cholSup260<-(chol>260)                   # echantillon binarisé
#----------------------- question 4 -----------------------------------
n<-length(chol)
x <- sum(cholSup260)
p0 <- 0.55
#----------------------- question 5 -----------------------------------
prop.test(x,n, p0, correct=TRUE)        # calcul exact de la p-valeur
prop.test(x,n, p0, correct=FALSE)       # approximation gaussienne
#----------------------- question 6 -----------------------------------
prop.test(x,n, p0, alternative="less")




#----------------------------------------------------------------------
# Exercice 4
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
data=read.table("proteine.csv", header=TRUE, sep=";")
H<-data$hydro
#----------------------- question 2 -----------------------------------
summary(H)                           # statistiques descriptives
n<-length(H)                         # longueur de l'échantillon
hist(H, prob=T)                      # histogramme
boxplot(H)                           # boite à moustaches
#----------------------- question 3 -----------------------------------
t.test(H,mu=-1, alternative="less")  # test unilateral
#----------------------- question 4 -----------------------------------
HV = H[data$regne=="Viridiplantae"]  # extraction des données du groupe Viridiplantae
t.test(HV, mu=-1, alternative="less")
#----------------------- question 5 -----------------------------------
HM = H[data$regne=="Metazoa"] 
t.test(HM, mu=-1, alternative="less")



