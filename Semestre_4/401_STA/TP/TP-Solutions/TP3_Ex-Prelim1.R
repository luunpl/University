####################################
#-----Exercice : extraction de données
####################################

#depuis le répertoire contenant les données :
#setwd("~/Documents/cours/L2MIN/STAT/TP/donnees")
read.table("cardiaque.csv",header = T,sep=",")->card
head(card)
names(card)
card$systolique->sys
summary(sys)
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


#-----------question 3-----------------
#formule des proba totale : P(A)=P(A|B)P(B)+P(A|C)P(C)+P(A|D)P(D)



###################################################
#------------Exercice 3------------------------
###################################################

n<-10
p<-0.3
#---------question 1--------------------------



#---------question 2--------------------------

#---------question 3--------------------------

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



