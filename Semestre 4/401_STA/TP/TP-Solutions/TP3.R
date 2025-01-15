####################################
#-----Exercice : extraction de données
####################################

#depuis re répertoire contenant les données :

cardiaque<-read.table("cardiaque.csv", sep=",", header=T)
sys<-cardiaque$systolique # echant des pressions systoliques
summary(cardiaque$systolique)
sd(sys)

###################################################
#------------Exercice préliminaire------------------------
###################################################

#--------question 1------------
#représentation de la première densité
curve(dnorm(x,0,0.5),from=-6,to=6,n=1000,col=1,
      main="densité normale pour mu=0 ou 3 et sigma=0.5,1 ou 2")
#ajout de la seconde densité sur le graphe précédent
curve(dnorm(x,0,1),n=100,col=3,add=T)
#ajout de la troisième densité
curve(dnorm(x,0,2),n=100,col=4,add=T)
#ajout de la quatrième densité
curve(dnorm(x,3,1),n=100,col=5,add=T)
abline(h=0,v=0) #ajout des axes 
segments(-1,0,1,0,col=2,lwd=5) #marque en rouge le segments [-1,1] sur l'axe des abs
abline(v=c(-1,1),col=2,lty=2) #verticales qui passent par les abscisses -1 et 1

#--------question 2------------
mu<-0
sig<-1
curve(pnorm(x,mu,sig),ylim=c(0,1),xlim=c(-3,3),from=mu-3*sig,to=mu+3*sig,n=100)
curve(dnorm(x,mu,sig),ylim=c(0,1),from=mu-3*sig,to=mu+3*sig,n=100,col="green",add=T)
abline(v=0,h=0)
abline(h=0.75,col="red",lty=2)
points(0,0.75,col="red",pch=20)
abline(v=qnorm(0.75,mu,sig),col="red",lty=2)
points(qnorm(0.75,mu,sig),0,col="red",pch=20)

###################################################
#------------Exercice 1------------------------
###################################################

#--------question 1------------
mu<-2
sigma<-3
pnorm(4,mean=mu,sd=sigma)#proba de X<=4 (avec la FDR de X)
pnorm((4-mu)/sigma,0,1)#proba de U<=(4-mu)/sigma (avec la FDR de U)
pnorm(-2,mu,sigma)#proba de X<=-2 (avec la FDR de X)
pnorm((-2-mu)/sigma,0,1)#proba de U<=(-2-mu)/sigma (avec la FDR de U)
pnorm(4,mu,sigma)-pnorm((-2-mu)/sigma,0,1)#proba de -2<X<=4 (avec la FDR de X)
#rappel : comme X est continue  : P(-2<X<=4) =  P(-2<=X<=4)
pnorm((4-mu)/sigma,0,1)-pnorm((-2-mu)/sigma,0,1)# P((-2-mu)/sigma<U<(4-mu):sigma) (avec la FDR de U)

#--------question 2----------
mu<-c(1,1)
sigma<-c(1,2)
mu-sigma
mu+sigma
pnorm(mu+sigma,mu,sigma)-pnorm(mu-sigma,mu,sigma) #prob calc pour(mu,sigma)=(1,1)et(mu,sigma)=(1,2)

mu<-c(1,1,1)
sigma<-c(1,2,3)
#prob calc pour(mu,sigma)=(1,1); (mu,sigma)=(1,2) et (mu,sigma)=(1,3)
pnorm(mu+sigma,mu,sigma)-pnorm(mu-sigma,mu,sigma)

mu<-c(1,2,3)
sigma<-c(1,1,1)
#prob calc pour(mu,sigma)=(1,1); (mu,sigma)=(2,1) et (mu,sigma)=(3,1)
pnorm(mu+sigma,mu,sigma)-pnorm(mu-sigma,mu,sigma)

#quelle que soit sa moyenne et sa variance une variable gaussienne a 68,27% de chances
#de tomber entre sa moy _ son ecart-type et sa moy + son ecart type.

#---------question 3---------------
#par analogie au calcul précedent si la proba demandée ne dépend ni de mi ni de sigma
#autant faire le calcul avec mu=0 et sigma=1 soit
pnorm(2)-pnorm(-2) #la proba de tomber entre moy-2e.t. et moy+2e.t. vaut 95,45%
pnorm(3)-pnorm(-3) #la proba de tomber entre moy-3e.t. et moy+3e.t. vaut 99,73% 
#(soit moins de 2,5% de proba de tomber à l'extérieur)

#---------question 4---------------
n<-9
(ordre<-seq(1:n)/(n+1))
qnorm(ordre)#les 10 quantiles recherchés (rem: par défaut R choisi mu=0 et sigma=1)

#----------question 5--------------
abs<-seq(-3,3,0.1)#grille des abscisses des points du tracé
ord<-pnorm(abs)#valeurs de la FDR de U en les points d'abscisses abs
plot(abs,ord,type="l",main="FdR de la normale centrée reduite")#tracé de la fdr
points(qnorm(ordre),rep(-0.035,10),col="red",pch=20)#ajout des quantiles sur l'axe des x
points(rep(-3.25,10),ordre,col="red",pch=20)#ajout des ordres sur l'axe des y
segments(qnorm(ordre),rep(-0.035,10),qnorm(ordre),pnorm(qnorm(ordre)),lty="dashed")
segments(qnorm(ordre),pnorm(qnorm(ordre)),rep(-3.25,10),ordre,lty="dashed")

#-----------question 6--------------
mu<--1
sigma<-5
(qnorm(ordre,mu,sigma)->ord)#quantiles de la loi de X
(qnorm(ordre)->abs)#quantiles de la loi normale centrée réduite U
plot(abs,ord)

#------------question 7--------------
abline(mu,sigma,col="red") # les points sont parfaitement alignés
#quantile d'ordre alpha de X= sigma*quantile d'ordre alpha de U + mu
#si X suit une loi normale N(mu,sigma^2)

###################################################
#------------Exercice 2------------------------
###################################################
mu<-2
sigma<-3
#------------question 1--------------
(pnorm(5,mu,sigma)-pnorm(1,mu,sigma)->pA)#P(A)
(pnorm(2,mu,sigma)-pnorm(0,mu,sigma)->pB)#P(B)
(1-pnorm(2,mu,sigma)->pC)#P(C)
(pnorm(0,mu,sigma)->pD)#P(D)

#####################################
#un graphique pour visulaliser P(A) #
#####################################

curve(dnorm(x,mu,sigma),from=mu-3*sigma,to=mu+3*sigma,main="densité de la N(2,9)",xlab="x",ylab="f(x)")
segments(1,0,5,0,col="red")
segments(c(1,5),c(0,0),c(1,5),c(dnorm(1,mu,sigma),dnorm(5,mu,sigma)),col="red")
curve(dnorm(x,mu,sigma),add=T,col=2,from=1,to=5)

legend("bottomright", inset = 0.35,  legend = " P(A)",
       bg = "white",bty="n")

#P(A) est la surface intérieure délimitée par le trait rouge

#-----------question 2--------------------
#Rappel : P(A|B)=P(A inter B)/P(B)
#A inter B : X in [1,2] 
((pnorm(2,mu,sigma)-pnorm(1,mu,sigma))/pB->pAsB) #P(A|B)
((pnorm(5,mu,sigma)-pnorm(2,mu,sigma))/pC->pAsC) #P(A|C)
(0/pD->pAsD) #P(A|D)

#-----------question 3-----------------
#formule des proba totale : P(A)=P(A|B)P(B)+P(A|C)P(C)+P(A|D)P(D)

pAsB*pB+pAsC*pC+pAsD*pD #P(A|B)P(B)+P(A|C)P(C)+P(A|D)P(D)
pA

###################################################
#------------Exercice 3------------------------
###################################################

n<-10
p<-0.3
#---------question 1--------------------------
pAb<-pbinom(5,n,p)-dbinom(0,n,p)
pBb<-pbinom(1,n,p)
pCb<-1-pbinom(1,n,p)


#---------question 2--------------------------
#A inter B est réduit à la valeur 1
pAiB=dbinom(1,n,p)
pAcB=pAiB/pBb # P(A¦B)
#A inter C est l'ens des entiers appartenant à [2,5]
pAiC=dbinom(2,n,p)+dbinom(3,n,p)+dbinom(4,n,p)+dbinom(5,n,p)
pAcC=pAiC/pCb # P(A¦C)
#---------question 3--------------------------
pAcB*pBb+pAcC*pCb #calcul de P(A) avec les proba cond P(A¦B) et P(A|C)
pAb
#---------question 4--------------------------
pbinom(-1,n,p) #la FdR est constante jusqu'à 0 exclu et vaut 0
pbinom(n,n,p) #la FdR est constante à partir de n et vaut 1
#entre 0 et n c'est une fonction constante par morceaux continue à droite
(abs<-c(-1,0:n,n+1))
(ord<-pbinom(abs,n,p))
plot(abs,ord,type="s",main="FdR d'une Binomiale (n,p) avec n=10 et p=0.3",xlab="nbre succès", ylab="P(X<= x)=F(x)")

#----------question 5-------------------------
points(seq(-1,11,0.1),pnorm(seq(-1,11,0.1),n*p,sqrt(n*p*(1-p))),col="green",type="l")
legend("bottomright",legend="FdR de N(np,np(1-p))",col="green",lty=1)

#----------question 6---------------
par(mfrow=c(2,2))
n<-10
(abs<-c(-1,0:n,n+1))
(ord<-pbinom(abs,n,p))
plot(abs,ord,type="s",main="FdR d'une Binomiale (n,p) avec n=10 et p=0.3",xlab="nbre succès", ylab="P(X<= x)=F(x)")
points(seq(-1,n+1,0.1),pnorm(seq(-1,n+1,0.1),n*p,sqrt(n*p*(1-p))),col="green",type="l")
legend(2*n/5,0.4,legend="FdR de N(np,np(1-p))",col="green",lty=1,cex=0.8,bty="n") #en haut à gauche pour n=10
n<-50
(abs<-c(-1,0:n,n+1))
(ord<-pbinom(abs,n,p))
plot(abs,ord,type="s",main="FdR d'une Binomiale (n,p) avec n=50 et p=0.3",xlab="nbre succès", ylab="P(X<= x)=F(x)")
points(seq(-1,n+1,0.1),pnorm(seq(-1,n+1,0.1),n*p,sqrt(n*p*(1-p))),col="green",type="l")
legend(2*n/5,0.4,legend="FdR de N(np,np(1-p))",col="green",lty=1,cex=0.8,bty="n")

n<-100
(abs<-c(-1,0:n,n+1))
(ord<-pbinom(abs,n,p))
plot(abs,ord,type="s",main="FdR d'une Binomiale (n,p) avec n=100 et p=0.3",xlab="nbre succès", ylab="P(X<= x)=F(x)")
points(seq(-1,n+1,0.1),pnorm(seq(-1,n+1,0.1),n*p,sqrt(n*p*(1-p))),col="green",type="l")
legend(2*n/5,0.4,legend="FdR de N(np,np(1-p))",col="green",lty=1,cex=0.8,bty="n")

n<-1000
(abs<-c(-1,0:n,n+1))
(ord<-pbinom(abs,n,p))
plot(abs,ord,type="s",main="FdR d'une Binomiale (n,p) avec n=1000 et p=0.3",xlab="nbre succès", ylab="P(X<= x)=F(x)")
points(seq(-1,n+1,0.1),pnorm(seq(-1,n+1,0.1),n*p,sqrt(n*p*(1-p))),col="green",type="l")
legend(2*n/5,0.4,legend="FdR de N(np,np(1-p))",col="green",lty=1,cex=0.8,bty="n")


#lorsque n tend vers l'infini la FdR de la B(n,p) converge simplement (et uniformément)
#vers celle de la N(np,np(1-p)). En fait ce la illustre l'approximation d'une binomiale
#par une loi normale qui est une conséquence du théorème central limite.



