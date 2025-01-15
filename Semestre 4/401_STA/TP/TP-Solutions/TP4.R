
####################################
#-----Exercice : extraction de données
####################################

#depuis re répertoire contenant les données :
cardiaque<-read.table("cardiaque.csv", sep=",", header=T)
head(cardiaque)

# echant des pressions systoliques chez les cardiaques :
sysC<-cardiaque[cardiaque$cardiaque==1,"systolique"]
 
summary(sysC)
sd(sysC)  # s' de l'échantillon


###################################################
#------------Exercice 1------------------------
###################################################
mu<-2
sigma<-2
#----------question 1---------------------
n<-50
(rnorm(n,mu,sigma)->x)

#----------question 2---------------------
(quantile(x,probs=seq(0.1,0.9,0.1),type=1)->demp) #deciles empiriques (selon le mode de calcul du qqplot)
#par défaut R chosit type=7

#----------question 3--------------------
(qnorm(seq(0.1,0.9,0.1),mu,sigma)->dtheo) #deciles théoriques

#----------question 4--------------------
plot(dtheo,demp,main="les déciles",xlab="deciles théoriques", ylab="déciles empiriques")
abline(0,1,col="red")#le décile empirique approche le décile théorique

#----------question 5--------------------
hist(x,prob=T,main="répartition observée de X")
points(seq(-5,10,0.1),dnorm(seq(-5,10,0.1),mu,sigma),col="red",type="l")
#l'histogramme est assez proche de la densité qui est la répartition théorique de X

#----------question 6--------------------
quantile(x,probs=seq(1:n)/(n+1),type=1)->qemp
sort(x)#echantillon ordonné en croissant
quantile(x,probs=seq(1:n)/(n+1),type=1)-sort(x)
#les quantiles empiriques d'ordres 1/(n+1),...,n/(n+1) coincident avec l'échantillonn ordonné

#----------question 7-------------------
qnorm(seq(1:n)/(n+1),mu,sigma)->qtheo
plot(qtheo,qemp,xlab="quantiles théoriques ",ylab="quantiles empiriques",main="les quantiles d'ordre 1/(n+1),...,n/(n+1)")
abline(0,1,col="red")
legend("bottomright",legend="y=x",bty="n")

#----------question 8------------------
qnorm(seq(1:n)/(n+1))->qtheoc#quantiles théoriques pour la centrée réduite
plot(qtheoc,qemp,xlab="quantiles théoriques de la N(0,1)",ylab="quantiles empiriques",main="les quantiles d'ordre 1/(n+1),...,n/(n+1)")
abline(mu,sigma,col="red")

legend("bottomright",legend="y=2x+2",bty="n",col=2)
abline(v=1,col=2)
abline(h=5,col=2)
#----------question 9-----------------
par(mfrow=c(1,1))
qqnorm(x)
abline(mu,sigma,col="red")
abline(v=1,col=2)
abline(h=5,col=2)
qqline(x,col="green")#pas tout à fait la dtre d'équation y=sigmax+mu qui à
#priori n'est pas connue par contre la droite produite par qqline
#passe en fait par les points d'abscisses premier et troisième quartile et
#ordonnées premier et troisème quartile estimés sur les n tirages. 
#On peut rajouter les duex points en question en vert pour bien se convaincre
#que qqline passe par ces deux points et n'est pas exactement la dte d'equation
#y=sigma x + mu dite dte de Henry (la rouge)
#on obtient le même graphe que dans la question précédente 


###################################################
#------------Exercice 2------------------------
###################################################

#------------question 1----------------------
n<-120

#------------question 2----------------------
(x<-runif(n,-1,1)) #echantillon tiré-Esp=0 et Var=1/3
var(x)
qqnorm(x) 
qqline(x,col="red")
#une forme de S avec les points inférieurs au dessus de la droite et les poins sups au dessus
#signe de queues de distribution plus légères que celles de la normale

#------------question 3-------------------------
(x<-rt(n,3))
var(x)
qqnorm(x) 
qqline(x,col="red")
#le S est dans l'autre sens car la student a des queues de distribution plus lourde que la N(0,1)
#ainsi qu'on peut le voir avec
abs<-seq(-3,3,0.1)
plot(abs,dt(abs,3),type="l",ylim=c(0,0.4), main="Student à 3 d.l. en noir")
points(abs,dnorm(abs),col="red",type="l")
mtext(side=1, "loi normale N(0,1)",col="red")


#----------question 4--------------------------
(x<-rchisq(n,2))
var(x)
qqnorm(x) 
qqline(x,col="red")
#des queues de distribution moins lourde d'un coté (vers 0) et plus lourde de l'autre vers +infini
#et surtout une disymmétrie indiquée par pas de symétrie centrale entre les points
abs<-seq(-3,10,0.1)
plot(abs,dchisq(abs,2),type="l",ylim=c(0,0.6), main="Chi-deux à 3 d.l. en noir")
points(abs,dnorm(abs),col="red",type="l")
mtext(side=1, "loi normale N(0,1)",col="red")


