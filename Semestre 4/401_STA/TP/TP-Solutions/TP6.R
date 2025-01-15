###################################################
#------------Exercice 1------------------------
###################################################

#--------question 1------------
(mu<-3)
(sigma<-1)
(n<-10)
(N<-1000)
rm(dataG)
dataG<-matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T)
dim(dataG)
#--------question 2------------
est1<-rowMeans(dataG) #N réalisations de xbarn
length(est1)
est2<-(apply(dataG,MARGIN=1,min)+apply(dataG,MARGIN=1,max))/2 #N réalisations de T2
length(est2)
#--------question 3------------
(moyest1<-mean(est1)) #estime espérance de T1 car N=1000 est assez grand (voir EX1 et 2 du TP5)
(etest1<-sd(est1) )#estime l'écart-type de T1 (qui vaut sigma/n)
(moyest2<-mean(est2)) #estime espérance de T2 car N=1000 est assez grand (voir EX1 et 2 du TP5)
(etest2<-sd(est2)) #estime l'écart-type de T2 
#--------question 4----------
#les deux estimateurs sont sans biais en effet si on retire de nouveau les données
#et qu'on réexecute le script des lignes 10 à 21 on observe qu'en moyenne (sur N valeurs)
#les deux estimateurs sont voisins de 3 donc E(T1) approché par moyest1 vaut bien mu=3
#T1 est sans biais. Pour T2 meme chose il est sans biais.
#Par contre si on compare leurs variabilié respectives elle d'environ 0.3 pour T1 et 0.4 pour T2
#T1 est moins variable que T2 donc alors que les deux visent bien la valeur à estimer (sans biais)
#T1 est plus précis que T2 car moins variable ===> ON RETIENT T1


#------------question 5--------------------------
par(mfrow=c(1,1))
hist(est1,prob=T,main="Répartition observée de T1 pour n=10",ylim=c(0,1.1*dnorm(mu,mu,sigma/sqrt(n))),xlim=c(0.9*min(est1),max(est1)*1.1))
abs<-seq(mu-3*sigma/sqrt(n),mu+3*sigma/sqrt(n),0.01)
points(abs,dnorm(abs,mean(est1),sd(est1)),col=2,type="l")
abline(v=mu,col=2) #paramètre théorique à estimer
abline(v=moyest1,lty="dashed",col=3) #espé. de l'estimateur T1 : excellent vert est quasi confondu avec rouge

hist(est2,prob=T,main="Répartition observée de T2 pour n=10",ylim=c(0,1.1*dnorm(mu,mu,sigma/sqrt(n))),xlim=c(0.9*min(est1),max(est1)*1.1))
abs<-seq(mu-3*sigma/sqrt(n),mu+3*sigma/sqrt(n),0.01)
points(abs,dnorm(abs,mean(est2),sd(est2)),col=2,type="l")
abline(v=mu,col=2) #paramètre théorique à estimer
abline(v=moyest2,lty="dashed",col=3) #espé. de l'estimateur T1 : excellent vert est quasi confondu avec rouge


#les deux sur la m^eme page
par(mfrow=c(2,1))
hist(est1,prob=T,main="Répartition observée de T1 pour n=",ylim=c(0,1.1*dnorm(mu,mu,sigma/sqrt(n))),xlim=c(.9*min(est1),max(est1)*1.1))
abs<-seq(mu-3*sigma/sqrt(n),mu+3*sigma/sqrt(n),0.01)
points(abs,dnorm(abs,mean(est1),sd(est1)),col=2,type="l")
abline(v=mu,col=2) #paramètre théorique à estimer
abline(v=moyest1,lty="dashed",col=3) #espé. de l'estimateur T1 : excellent vert est quasi confondu avec rouge

hist(est2,prob=T,main="Répartition observée de T2 pour n=",ylim=c(0,1.1*dnorm(mu,mu,sigma/sqrt(n))),xlim=c(.9*min(est1),max(est1)*1.1))
abs<-seq(mu-3*sigma/sqrt(n),mu+3*sigma/sqrt(n),0.01)
points(abs,dnorm(abs,mean(est2),sd(est2)),col=2,type="l")
abline(v=mu,col=2) #paramètre théorique à estimer
abline(v=moyest2,lty="dashed",col=3) #espé. de l'estimateur T1 : excellent vert est quasi confondu avec rouge

#on observe que les deux histogramme sont bien centrés sur la dte verte donc 
#les deux estimateurs sont sans biais (T2 peut-etre tres légèrement biaisé), par contre T2 est plus diffus que T1 son histogramme est
#plus plat que celui de T1 ===>   ON CONFIRME LE CHOIX DE T1

#-----------question 6------------------------
n<-50
#puis lignes 9 à 60

#-----------question 7------------------------
alpha<-0.05 # risque de l'intervalle = 1 - niveau de confiance
Binf<-est1-sigma*qnorm(1-alpha/2)/sqrt(n) #les N bornes inf
Bsup<-est1+sigma*qnorm(1-alpha/2)/sqrt(n) #les N bornes sup
mean((Binf<=mu)&(mu<=Bsup)) #fréquence avec laquelle mu est dans l'intervalle calculé
#c'est le niveau de confiance estimé de l'intervalle soit env 95%

#-----------question 8------------------------
par(mfrow=c(1,1))
plot(Binf,main="1000 interv de conf pour E(X) au niveau 95% calculés avec échantillons de taille n=50",
     pch=20,col="red",cex=.6,ylim=c(.8*min(Binf),1.10*max(Bsup)),ylab="intervalle de conf à 95%")
points(Bsup, pch=20,col="blue",cex=.6)
segments(1:N,Binf,1:N,Bsup)
abline(h=mu,col="green")

###################################################
#------------Exercice 2------------------------
###################################################

mu<-3)
(sigma<-1)
(n<-10)
(N<-1000)
rm(dataG)
dataG<-matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T)
dim(dataG)
#--------question 2------------
est2<-apply(dataG,MARGIN=1,var) #N réalisations de T2=S'^2
length(est2)
est1<-est2*(n-1)/n #N réalisations de T1=S^2
length(est2)

(moyest1<-mean(est1)) #estime espérance de T1 
moyest1-sigma*sigma#estime le biais d'estimation de sigma^2 avec l'estimateur S^2 qui vaut -sigma^2/n
-sigma^2/n
(moyest2<-mean(est2)) #estime espérance de T2
moyest2-sigma*sigma#estime le biais d'estimation de sigma^2 avec l'estimateur S'^2 qui vaut 0
#--------question 3------------
par(mfrow=c(2,1))
dchisq(which(dchisq(1:(2*n),n-1)==max(dchisq(1:(2*n),n-1))),n-1)->max
hist(est1,prob=T,main="Répartition observée de S^2",ylim=c(0,1.1*max*n/sigma^2),xlim=c(0,3*sigma^2))
(abs<-seq(0,3*sigma^2,0.05))
points(abs,n*dchisq(abs*n/sigma^2,n-1)/sigma^2,type="l",col="red")
abline(v=sigma^2,col="red")
abline(v=sigma^2*(n-1)/n,col="green")
abline(v=mean(est1),lty="dashed",col="green")

dchisq(which(dchisq(1:(2*n),n-1)==max(dchisq(1:(2*n),n-1))),n-1)->max
hist(est2,prob=T,main="Répartition observée de S'^2",ylim=c(0,1.1*max*n/sigma^2),xlim=c(0,3*sigma^2))
(abs<-seq(0,3*sigma^2,0.05))
points(abs,(n-1)*dchisq(abs*(n-1)/sigma^2,n-1)/sigma^2,type="l",col="red")
abline(v=sigma^2,col="red")
abline(v=sigma^2*(n-1)/n,col="green")
abline(v=mean(est2),lty="dashed",col="green")

#on observe bien que S^2 est biaisé puisque le trait pointillé vert se confond avec le trait plein
#vert qui est sigma^2*(n-1)/n : cela signifie qu'en moyenne S^2 sous-estime sigma2
#En revanche S'^2 lui est sans biais (il a été construit pour cela) puisque vert pintillé
#est cette fois ur la cible a estimer sigma2

#-----------question 4-----------------------
par(mfcol=c(2,3))
#colonne 1
n<-10
rm(est1)
rm(est2)
est1<-apply(matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T),MARGIN=1,var)*(n-1)/n#l'empirique
est2<-apply(matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T),MARGIN=1,var)#l'empirique corrigé esb de sigma2
dchisq(which(dchisq(1:(2*n),n-1)==max(dchisq(1:(2*n),n-1))),n-1)->max
hist(est1,prob=T,main="Répartition observée de S^2 pour n=10",ylim=c(0,1.1*max*n/sigma^2),xlim=c(0,3*sigma^2))
(abs<-seq(0,3*sigma^2,0.05))
points(abs,n*dchisq(abs*n/sigma^2,n-1)/sigma^2,type="l",col="red")
abline(v=sigma^2,col="red")
abline(v=sigma^2*(n-1)/n,col="green")
abline(v=mean(est1),lty="dashed",col="green")
hist(est2,prob=T,main="Répartition observée de S'^2 pour n=10",ylim=c(0,1.1*max*n/sigma^2),xlim=c(0,3*sigma^2))
(abs<-seq(0,3*sigma^2,0.05))
points(abs,(n-1)*dchisq(abs*(n-1)/sigma^2,n-1)/sigma^2,type="l",col="red")
abline(v=sigma^2,col="red")
abline(v=sigma^2*(n-1)/n,col="green")
abline(v=mean(est2),lty="dashed",col="green")

#colonne 2
n<-20
rm(est1)
rm(est2)
est1<-apply(matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T),MARGIN=1,var)*(n-1)/n#l'empirique
est2<-apply(matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T),MARGIN=1,var)#l'empirique corrigé esb de sigma2
dchisq(which(dchisq(1:(2*n),n-1)==max(dchisq(1:(2*n),n-1))),n-1)->max
hist(est1,prob=T,main="Répartition observée de S^2 pour n=20",ylim=c(0,1.1*max*n/sigma^2),xlim=c(0,3*sigma^2))
(abs<-seq(0,3*sigma^2,0.05))
points(abs,n*dchisq(abs*n/sigma^2,n-1)/sigma^2,type="l",col="red")
abline(v=sigma^2,col="red")
abline(v=sigma^2*(n-1)/n,col="green")
abline(v=mean(est1),lty="dashed",col="green")
hist(est2,prob=T,main="Répartition observée de S'^2 pour n=20",ylim=c(0,1.1*max*n/sigma^2),xlim=c(0,3*sigma^2))
(abs<-seq(0,3*sigma^2,0.05))
points(abs,(n-1)*dchisq(abs*(n-1)/sigma^2,n-1)/sigma^2,type="l",col="red")
abline(v=sigma^2,col="red")
abline(v=sigma^2*(n-1)/n,col="green")
abline(v=mean(est2),lty="dashed",col="green")
#colonne 3
n<-100
rm(est1)
rm(est2)
est1<-apply(matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T),MARGIN=1,var)*(n-1)/n#l'empirique
est2<-apply(matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T),MARGIN=1,var)#l'empirique corrigé esb de sigma2
dchisq(which(dchisq(1:(2*n),n-1)==max(dchisq(1:(2*n),n-1))),n-1)->max
hist(est1,prob=T,main="Répartition observée de S^2 pour n=100",ylim=c(0,1.1*max*n/sigma^2),xlim=c(0,3*sigma^2))
(abs<-seq(0,3*sigma^2,0.01))
points(abs,n*dchisq(abs*n/sigma^2,n-1)/sigma^2,type="l",col="red")
abline(v=sigma^2,col="red")
abline(v=sigma^2*(n-1)/n,col="green")
abline(v=mean(est1),lty="dashed",col="green")
hist(est2,prob=T,main="Répartition observée de S'^2 pour n=100",ylim=c(0,1.1*max*n/sigma^2),xlim=c(0,3*sigma^2))
(abs<-seq(0,3*sigma^2,0.01))
points(abs,(n-1)*dchisq(abs*(n-1)/sigma^2,n-1)/sigma^2,type="l",col="red")
abline(v=sigma^2,col="red")
abline(v=sigma^2*(n-1)/n,col="green")
abline(v=mean(est2),lty="dashed",col="green")

# Si n est petit : la loi de l'estimateur S'2 n'est pas symétrique donc pas normale
# mais S'2 est sans biais qu meme tandis que S2 est biaisé.
# Si n est grand le biais de S2 disparait (on dit que S2 est asymptotiquement sans biais)
# et S2 et S'2 ont une loi qui ressemble beaucoup à une loi normale.

###################################################
#------------Exercice 3------------------------
###################################################

#---------question 1--------------------------
p<-0.5
N<-1000
n<-5
rm(dataB)
dataB<-matrix(rbinom(n*N,1,p),ncol=n,byrow=T)
dim(dataB)
#---------question 2--------------------------
rm(est)
rowMeans(dataB)->est
mean(est)
#---------question 3--------------------------
par(mfrow=c(1,1))
hist(est,prob=T,xlim=c(p-3*sqrt(p*(1-p)/n),p+3*sqrt(p*(1-p)/n)),ylim=c(0,2*dnorm(p,p,sqrt(p*(1-p)/n))),main="Répartition observée de l'estimateur F_n")
abline(v=p,col=2)
abline(v=mean(est),col="green",lty="dashed")
rm(abs)
abs<-seq(p-3*sqrt(p*(1-p)/n),p+3*sqrt(p*(1-p)/n), 0.001)
points(abs,dnorm(abs,p,sqrt(p*(1-p)/n)),col=2,type="l")
#---------question 4--------------------------
n<-10
#ligne 204 à 218 c'est mieux ! la distribution charge [0;1] ! 
n<-50
#ligne 204 à 218 c'est beaucoup mieux ! la distribution charge [0.3;0.7]
n<-100
#ligne 204 à 218 c'est beaucoup mieux ! la distribution charge [0.35;0.65]
n<-1000
#ligne 204 à 218 c'est encore  beaucoup mieux ! la distribution charge [0.45;0.55] 

#à partir de $n=50$ on atteint l'approximation par la normale est correcte et pour
#n de plus en plus grand la dispersion de l'histogramme diminue. F_n fournit pour n=1000
#une estimation beaucoup plus précise que n=100.


###################################################
#------------Exercice 4------------------------
###################################################

#---------question 1--------------------------
a<-2
n<-10
N<-1000
rm(dataU) #efface l'objet précedemment créé Mdata
dataU<-matrix(runif(n*N,0,a),ncol=n,byrow=T)# N échantillons de taille n disposés en lignes
dim(dataU) #dimension de la matrice N lignes et n colonnes

#---------question 2---------------------------
est1<-apply(dataU,MARGIN=1,mean)*2 #estimateur T1= Xbar
est2<-apply(dataU,MARGIN=1,max) #estimateur T2=max (Xi)
mean(est1) #sans biais
sd(est1)
mean(est2) #T2 est biaisé
sd(est2) #par contre T2 est moins dispersé (son écart-type est divisé par 2 ) que T1
#comparons les distributions pour n=10 et n=100
par(mfcol=c(2,2))
hist(est1,xlim=c(0,2*a),main="répartition de l'estimateur des moments dans le modèle 
     uniforme sur [0,2] avec n=10", ylab="2 fois la moyenne empirique")
abline(v=a,col=2)
abline(v=mean(est1),col="3",lty="dashed")
hist(est2,xlim=c(0,2*a),main="répartition de l'estimateur du max de vraiss.
     le modèle uniforme sur [0,2] avec n=10", ylab="max des observations")
abline(v=a,col=2)
abline(v=mean(est2),col="3",lty="dashed")
n<-50
rm(dataU) #efface l'objet précedemment créé Mdata
dataU<-matrix(runif(n*N,0,a),ncol=n,byrow=T)# N échantillons de taille n disposés en lignes
dim(dataU)
est1<-apply(dataU,MARGIN=1,mean)*2 #estimateur T1= Xbar
est2<-apply(dataU,MARGIN=1,max) #estimateur T2=max (Xi)
hist(est1,xlim=c(0,2*a),main="répartition de l'estimateur des moments dans le modèle 
     uniforme sur [0,2] avec n=50", ylab="2 fois la moyenne empirique")
abline(v=a,col=2)
abline(v=mean(est1),col="3",lty="dashed")
hist(est2,xlim=c(0,2*a),main="répartition de l'estimateur du max de vraiss. 
     le modèle uniforme sur [0,2] avec n=50", ylab="max des observations")
abline(v=a,col=2)
abline(v=mean(est2),col="3",lty="dashed")

#Le second estimateur est bien plus précis mais il est biaisé et sa distribution n'est
#pas gauss mais elle peut se calculer explicitement (voir le calcul de la loi de max(Xi) en TD)
 
#-----------question 4--------------
mean(est2)*(n+1)/n
est3<-est2*(n+1)/n#estimateur sans biais de a
mean(est3)
sd(est3)
mean(est1)
sd(est1) #la dispersion de T3 est bien plus faible que celle de T1

###################################################
#------------Exercice 5------------------------
###################################################

#----------question 1---------------
lambda1<-0.1
lambda2<-0.5
lambda3<-1
lambda4<-2
lambda5<-10
rm(abs)
par(mfrow=c(1,1))
(abs<-seq(0,20,0.01))
plot(abs,dexp(abs,rate=lambda1),type="l",col="1",ylim=c(0,0.5))
points(abs,dexp(abs,rate=lambda2),type="l",col="2")
points(abs,dexp(abs,rate=lambda3),type="l",col="3")
points(abs,dexp(abs,rate=lambda4),type="l",col="4")
points(abs,dexp(abs,rate=lambda5),type="l",col="5")
#lambda conditionne la vitesse de décroissance de la courbe et plus il est grand
#plus la densité décroit  vite au voisinnage de zéro d'où son nom "rate"
#--------------question 2---------------
lambda<-2
N<-1000
n<-15
rm(dataE)
dataE<-matrix(rexp(n*N,lambda),ncol=n)
dim(dataE)
#--------------question 3---------------
est<-1/rowMeans(dataE)#estimateur T=1/Xbar qui s'obtient par le max de vraiss et par les moments
#--------------question 4---------------
mean(est)#il semble biaisé supérieur c'est à dire qu'il surestime lambda
sd(est)
hist(est,main="répartition observée de l'EMV pour un modèle exp(2)",prob=T)
abline(v=lambda,col=2) #le paramètre à estimer
abline(v=mean(est),col=3,lty="dashed") #approx espérance de l'estimateur
#il n'a pas l'air sans biais, son écart-type est relativement important env 0.5 pour un paramètre
#valant 2 et sa loi n'a pas l'air gaussienne en tout cas pour n petit
#pour observer un biais petit et une allure gaussienne il faut beaucoup augmenter n
#par ex 
n<-500

