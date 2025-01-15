# Etude des proprietes d'estimateurs par simulation -- modele uniforme#
#######################################################################

n<-20      # taille ech
N<-1000    # nombre de n-echantillons tirés

#Modele Uniforme sur [0,a] : X unif dist sur [0,a] et E(X)=a/2#
###############################################################
a<-2
x<-runif(n,0,a) #un tirage de n-ech
summary(x) #moyenne et medianes sont proches de a/2 et le max est proche de a

# estimations possibles : mean(x)*2, quantile(x,0.5)*2 ou max(x)......
# laquelle est la meilleure ? ==> appliquer N fois le processus d'estimation 
# et décrire pour chaque estimateur : la série des N estimations obtenues 
#############################################################################


#simulation de N, n-echantillons : rangés en ligne dans une matrice Nxn
###########################################################################
matrix(runif(n*N,0,a),ncol=n)->data_unif  

#Les N estimations obtenues pour chacun des 3 estimateurs proposés
####################################################################
rowMeans(data_unif)*2->est1
apply(data_unif,MARGIN=1,median)*2->est2
apply(data_unif,MARGIN=1,max)->est3

#Resumés numériques des 3 N-échantillons d'estimations
######################################################
#pour 2*Xbar
summary(est1)
sd(est1)
#pour 2*qhat_0.5=2*median
###########################
summary(est2)
sd(est1)
#pour max(X_i)
##########################
summary(est3)
sd(est3)   #est3 vise mal (tombe en dessous de a) mais plus préisement que 
           #est1 et est2 qui visent mieux
#répartitions observées
hist(est1,prob=T,main="répartition de 2 fois la moyenne empirique",xlim=c(1.2,2.8)) #ça ressemble à une belle gaussienne !
abline(v=a,col=2) #valeur du paramètre choisi qui doit etre retrouvée au mieux par les estimateurs
abline(v=mean(est1),col=3)#estimation assez bonne

hist(est2,prob=T,main="répartition de 2 fois la médiane",xlim=c(1.2,2.8)) #ça ressemble à une belle gaussienne !
abline(v=a,col=2) #valeur du paramètre choisi qui doit etre retrouvée au mieux par les estimateurs
abline(v=mean(est2),col=3)#estimation assez bonne aussi

hist(est3,prob=T,main="répartition de max(Xi) ",xlim=c(1.6,2.1)) #ça ressemble à une belle gaussienne !
abline(v=a,col=2) # valeur du paramètre choisi qui doit etre retrouvée au mieux par les estimateurs
abline(v=mean(est3),col=3)# estimation loin de a mais répartition moins variable

#corrigeons est3 pour reduire l'écart entre estimation et paramètre
###################################################################
est4<-(n+1)/n*est3
hist(est4,prob=T,main="répartition de (n+1)/n*max(Xi)",xlim=c(1.6,2.1)) #ça ressemble à une belle gaussienne !
abline(v=a,col=2) #valeur du paramètre choisi qui doit etre retrouvée au mieux par les estimateurs
abline(v=mean(est4),col=3) #estimation assez bonne aussi : 
#bien meilleur pour le ciblage et reste moins variable que les deux autres par contre la loi de l'estimateur
#n'est pas gaussienne !


#Resumons avec un graphique affichent les 3 histogrammes
par(mfcol=c(2,2))
a<-2
n<-20
N<-1000
matrix(runif(n*N,0,a),ncol=n)->data_unif  

#Les N estimations obtenues pour chacun des 3 estimateurs proposés
####################################################################
rowMeans(data_unif)*2->est1
apply(data_unif,MARGIN=1,median)*2->est2
apply(data_unif,MARGIN=1,max)->est3

hist(est1,prob=T,main="répartition de 2 fois la moyenne empirique",xlim=c(a-3*sd(est1),3+sd(est1))) #ça ressemble à une belle gaussienne !
abline(v=a,col=2) #valeur du paramètre choisi qui doit etre retrouvée au mieux par les estimateurs
abline(v=mean(est1),col=3)#estimation assez bonne

hist(est2,prob=T,main="répartition de 2 fois la médiane ",xlim=
       c(a-3*sd(est1),3+sd(est1)))    #ça ressemble à une belle gaussienne !
abline(v=a,col=2) #valeur du paramètre choisi qui doit etre retrouvée au mieux par les estimateurs
abline(v=mean(est2),col=3)#estimation assez bonne aussi

hist(est3,prob=T,main="répartition de max(Xi) ",xlim=c(a-3*sd(est1),3+sd(est1))) #ça ressemble à une belle gaussienne !
abline(v=a,col=2) # valeur du paramètre choisi qui doit etre retrouvée au mieux par les estimateurs
abline(v=mean(est3),col=3)# estimation loin de a mais répartition moins variable


est4<-(n+1)/n*est3
hist(est4,prob=T,main="répartition de (n+1)/n*max(Xi)",xlim=c(a-3*sd(est1),3+sd(est1))) #ça ressecmble à une belle gaussienne !
abline(v=a,col=2) #valeur du paramètre choisi qui doit etre retrouvée au mieux par les estimateurs
abline(v=mean(est4),col=3) #estimation assez bonne aussi : 


##################################################################
# intervalles de fluctuation et intervalles de confiance
##################################################################
#Modele : gaussien de moyenne mu et variance sigma2 connue
#####################################################
sigma<-1
mu<-2
#simulation de N tirages d'un n-échantillon d'une normale
n<-10
N<-100
Nech<-matrix(rnorm(n*N,mu,sigma),nrow=N);dim(Nech)
#calcul des xbar
Nxbar<-rowMeans(Nech);length(Nxbar)
#mean(apply(Nech,MARGIN=1,sd))
hist(Nxbar,prob=T)
#intervalle de fluctuation de Xbar de niveau 1-alpha
#####################################################
alpha<-0.1
BinfIF<-mu-sigma*qnorm(1-alpha/2)/sqrt(n);BinfIF
BsupIF<-mu+sigma*qnorm(1-alpha/2)/sqrt(n);BsupIF
par(mfrow=c(1,1))
plot(Nxbar,pch=20)
abline(h=BinfIF,col=2)
abline(h=BsupIF,col=2)
(sum(Nxbar<BinfIF)+sum(Nxbar>BsupIF))/N #frequence avec laquelle l'ech est non-conforme

#intervalles de confianec pour mu de niveau 1-alpha
##################################################
BinfIC<-Nxbar-sigma*qnorm(1-alpha/2)/sqrt(n)
BsupIC<-Nxbar+sigma*qnorm(1-alpha/2)/sqrt(n)
plot(BinfIC,pch=10,ylim=c(0,4))
points(BsupIC,pch=15)
abline(h=mu,col=2)
segments(1:N,BinfIC,1:N,BsupIC)
(sum(mu<BinfIC)+sum(mu>BsupIC))/N # frequence avec laquelle l'intervalle capte le paramètre mu