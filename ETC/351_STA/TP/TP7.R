#----------------------------------------------------------------------
# Exercice 1
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
titanic <- read.table("titanic.csv",header=TRUE,sep=";")
P <- titanic[,"pclass"]
S <- titanic[,"survived"]
G <- titanic[,"gender"]
A <- titanic[,"age"]
#----------------------- question 2 -----------------------------------
by(A,G,summary)                             # indicateurs statistiques
#----------------------- question 3 -----------------------------------
boxplot(A~G)                                # boxplot
#----------------------- question 4 -----------------------------------
Af <- A[G=="F"]                             # ages des femmes
Am <- A[G=="M"]                             # ages des hommes
#----------------------- question 5 -----------------------------------
t.test(Af,Am,var.equal=F,paired=F)          # test bilateral de comparaison de deux grands echantillons indep
t.test(Af,Am)                               #même sortie car choix par défaut de var.equal et paired :F
# conclusion littérale : on peut conclure qu'en moyenne les ages diffèrent avec un risque de se tromper
# alpha, dès que alpha est supérieur à 4,072%
#----------------------- question 6 -----------------------------------
t.test(Af,Am,alternative="less")            # test unilatéral inferieur
#----------------------- question 7 -----------------------------------
#----------------------- question 7 a-----------------------------------
Afr<-Af[1:20]
Amr<-Am[1:15]
#----------------------- question 7 b-----------------------------------
#Modèle :
#X age femmes de loi normale (mux,sigma2x),
#Y age hommes de loi normale (muy,sigma2y), 
#X et Y indépendantes.
#sigmax=sigmay (égalité des écart-types et des variances)
#----------------------- question 7 c-----------------------------------
#T=(Xbar-Ybar)/sqrt(Sigma^2(1/nx+1/ny)) de loi de Studant nx+ny-2 sous H0
#----------------------- question 7 d-----------------------------------
nx<-length(Afr);ny<-length(Amr)
Sigma2<-((nx-1)*var(Afr)+(ny-1)*var(Amr))/(nx+ny-2)   #estimations de la variance sigma2 commune
Tcalc<-(mean(Afr)-mean(Amr))/sqrt(Sigma2*(1/nx+1/ny)) #stat de test
pt(Tcalc,nx+ny-2)*2       #car Tcalc est negatif
#----------------------- question 7 e-----------------------------------
t.test(Afr,Amr,var.equal=TRUE)   #avec egalité des variances on peut appliquer le test car nx et ny petis
t.test(Afr,Amr)  # attention : ici le test est réalisé sans hyp d'égalité et le résultat diffère. Ce test n'est 
                 #pas correct car les échantillons étant petits IL FAUT SUPPOSER EGALITE DES VAR
#----------------------- question 7 f-----------------------------------
#H0:sigmax=sigmay et H1:sigmax non= sigmay
#conditions : normalité de X et Y et indépendance entre X et Y
Tcalc=var(Afr)/var(Amr) #valeur de la stat de test
2*pf(Tcalc,nx-1,ny-1)   #calcul pval pour un tcalc<1
var.test(Afr,Amr)       #avec la fonction de R
#----------------------- question 8 -----------------------------------

by(A,S,summary)                             # indicateurs statistiques
boxplot(A~S)                                # boxplot
An <- A[S=="no"]                            # ages des non survivants
Ay <- A[S=="yes"]                           # ages des survivants
t.test(An,Ay)                               # test de comparaison de deux echantillons
t.test(An,Ay,alternative="less")            # test unilatéral
t.test(An,Ay,alternative="greater")         # test unilatéral
#----------------------- question 9 -----------------------------------
boxplot(A~P)                                # boxplot
#----------------------- question 10 -----------------------------------
A1 <- A[P==1]                               # ages des premieres classes
A2 <- A[P==2]                               # ages des deuxièmes classes
A3 <- A[P==3]                               # ages des troisièmes classes
#----------------------- question 11 -----------------------------------
t.test(A1,A2,alternative="greater")         # premiere contre deuxieme classe
t.test(A1,A3,alternative="greater")         # premiere contre troisième
t.test(A2,A3,alternative="greater")         # deuxieme contre troisième


  

#----------------------------------------------------------------------
# Exercice 2
#----------------------------------------------------------------------

#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
HER=read.table("her.txt", header=TRUE, sep="\t")
head(HER)
B<-HER$BMI
S<-HER$sex
BH<-B[S==0]
BF<-B[S==1]
#----------------------- question 2 -----------------------------------
summary(BF)
summary(BH)
boxplot(BF, BH, main="BMI selon le sexe", names=c("Femme", "Homme"))
#----------------------- question 3 -----------------------------------
t.test(BF, BH, var.equal=FALSE)   # test d'egalité de deux moyennes, variances différentes
t.test(BF, BH, var.equal=TRUE)    # test d'egalité de deux moyennes, variances egales
#Remarque : ici la statistique de test a la même valeur avec ou sans egalité des variances
#car les deux échantillons sont de meme taille. Attention ce n'est pas le cas
#autrement. Pour récupérer la valeur de la stat de test :
names(t.test(BF, BH, var.equal=FALSE) ) #indique le nom des quantités calculées
t.test(BF, BH, var.equal=FALSE)$statistic #retourne la stat de test, variances différentes
t.test(BF, BH, var.equal=TRUE)$statistic #retourne la stat de test, variances égales
#Attention les p-val sont légèrement différentes puisque avec var égale
#on utilise Student et avec var diff loi normale
t.test(BF, BH, var.equal=FALSE)$p.value
t.test(BF, BH, var.equal=TRUE)$p.value
#----------------------- question 4 -----------------------------------
sys<-HER$sys
Tr<-HER$treat
sysT<-sys[Tr==1]              # données des patients traités
sysNT<-sys[Tr==0]             # données des patients non traités
t.test(sysT,sysNT,var.equal=TRUE)
t.test(sysT,sysNT,var.equal=F) #légere différence mais pas sign
#----------------------- question 5 -----------------------------------
#ici on fait un test de comparaison de moyenne pour des échantillons APPARIES
#modéle : X: pression syst; Y: pression dias.; D=X-Y de loi normale (muD,sigma2D)
#test : H0: muD=0; H1: muD non = 0
dia<-HER$dia
d<-sys-dia                         #echantillon des différences
Tcalc<-mean(d)*sqrt(length(d))/sd(d)
2*(1-pt(Tcalc,length(d)-1))        #calcul de la p-val avec Tcalc>0
t.test(d)                          #test sur un seul echantillon, celui des différences
t.test(sys,dia,paired=T)           #pareil mais avec l'utilisation des  2 echantillons appariés
t.test(sys,dia,paired=T)$p.value   #pour afficher la valeur précise

#----------------------- question 6 -----------------------------------
t.test(sys,dia,paired=T,alternative="greater")     #puisque tcalc>0   
t.test(sys,dia,paired=T,alternative="greater")$p.value
#---------------------------------------------------------------------
# Exercice 3
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
data=read.table("cardiaque.csv", header=TRUE, sep=";")
head(data)
names(data)
S<-data$systolique
Act<-data$activiteBinaire
SA<-S[Act==1]
SHA<-S[Act==0]
#----------------------- question 2 -----------------------------------
summary(S)
summary(SA)
summary(SHA)
#----------------------- question 3 -----------------------------------
t.test(SHA, SA, alternative="greater")
#----------------------- question 4 -----------------------------------
C<-data$cardiaque
ST<-S[C==1]
SNT<-S[C==0]
t.test(ST, SNT, alternative="greater")
#En moyenne la pression systolique est plus élévée chez les patients traités que chez les noms traités
#conclusion donnée avec un  risque d'erreur supérieur à 7.10^-5
