#----------------------------------------------------------------------
#                         TP4
#----------------------------------------------------------------------


#----------------------------------------------------------------------
# Exercice 1 jusqu'à l32
#----------------------------------------------------------------------
#----------------------- question 2b -----------------------------------
n <- 4; p <- 0.6      # parametres
dbinom(0,n,p)         # probabilité de 4 échecs
#----------------------- question 2c i) et ii)-----------------------------------
N <- 100              # taille de l'échantillon
X <- rbinom(N,n,p)    # simulation de l'échantillon
#----------------------- question 2c  iii)-----------------------------------
table(X)              # tableau des effectifs empiriques
prop.table(table(X))  # tableau des fréquences empiriques
#----------------------- question 2c iv) -----------------------------------
barplot(table(X))     # diagramme en barres des effectifs de X OK ici car modalités regul espacées
plot(prop.table(table(X)),lwd=20)  #diagramme en barre des ferq observées

prop.table(table(X))  # frequence de 0
#----------------------- question 2d i) -----------------------------------
dbinom(2,n,p)         # probabilité de 2 échecs
#----------------------- question 2d ii) -----------------------------------
N <- 10000           # taille de l'échantillon
X <- rbinom(N,n,p)    # simulation de l'échantillon
prop.table(table(X))   # table des frequences observées
prop.table(table(X)) [[3]] #frequence observée de la troisieme modalité ici 2

prop.table(table(X)) [[3]]-dbinom(2,n,p)


#----------------------------------------------------------------------
# Exercice 2 jusqu'à l57
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
mfm <- 172; sdfm <- sqrt(196)       # parametres
#----------------------- question 2 -----------------------------------
p <- pnorm(160,mean=mfm,sd=sdfm)    # probabilite
p
#----------------------- question 3 -----------------------------------
par(mfrow=c(1,2))                   # partage la fenetre graphique en deux
curve(dnorm(x,mean=mfm,sd=sdfm),main="densité f",ylab="f(x)",from=mfm-3*sdfm, to=mfm+3*sdfm) # fonction densité
abline(v=mfm,col="red")             # valeur moyenne
abline(v=160,col="blue")            # valeur consideree
curve(pnorm(x,mean=mfm,sd=sdfm), main="FdR (Fonction de répartition) F",ylab="F(x)",from=mfm-3*sdfm, to=mfm+3*sdfm) # fonction de repartition théorique
abline(v=160,col="blue")            # valeur consideree
abline(h=p,col="blue")              # probabilite
#----------------------- question 4 -----------------------------------
1-pnorm(200,mean=mfm,sd=sdfm)       # probabilite
#----------------------- question 5-----------------------------------
pnorm(185,mean=mfm,sd=sdfm)-pnorm(165,mean=mfm,sd=sdfm)
#----------------------- question 6 -----------------------------------
qnorm(0.9,mean=mfm,sd=sdfm) # quantile d'ordre 90%


#----------------------------------------------------------------------
# Exercice 3 jusqu'à l78
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
n<-25; N<-10000 # taille echantillon et nombre d'écha simulés
mu<-0; sig<-1 #paramètres 
alpha<-0.1 #risque de l'interv de fluct (1-alpha est son niveau)
InfIF<-mu-sig/sqrt(n)*qnorm(1-alpha/2)
SupIF<-mu+sig/sqrt(n)*qnorm(1-alpha/2)
#----------------------- question 2 -----------------------------------
Gdata<-matrix(rnorm(N*n,mu,sig),ncol=n)
#----------------------- question 3 -----------------------------------
xbar<-rowMeans(Gdata)    # vecteur des N moyennes empiriques (est sans biais de mu)
#----------------------- question 4-----------------------------------
s2<-rowMeans(Gdata*Gdata)-xbar^2 # vecteur des N variancess empiriques
sp2<-n/(n-1)*s2# vecteur des N variances empiriques corrigées (estimations ss biais de sig2)
#----------------------- question  5 -----------------------------------  
sum((xbar>=InfIF)&(xbar<=SupIF)) # nombre d'estimations de mu qui tombent dans IF de niveau 1-alpha
mean((xbar>=InfIF)&(xbar<=SupIF)) # freq por laq. xbar est dans int fluct de niveau 1-alpha


#----------------------------------------------------------------------
# Exercice 4 jusqu'à l
#----------------------------------------------------------------------
n<-25; N<-10000 # taille echantillon et nombre d'écha simulés
mu<-0; sig<-1 #paramètres 
alpha<-0.1 #risque (1-alpha est le niveau)
Gdata<-matrix(rnorm(N*n,mu,sig),ncol=n)
#----------------------- question 1a-----------------------------------
xbar<-rowMeans(Gdata)    # vecteur des N moyennes empiriques (est sans biais de mu)
mean(xbar)-mu # approx (dont la qualite s'ameliore avec N croissant) du biais d'estimation de mu
N<-1000 #à partir de N=100000  biais  d'ordre 10-4 10-5
#n<-250 # biais du mêmeordre de 5 10-5 que pour n=25 car xbar est sans biais pour tout n meme petit
n<-5

#----------------------- question 1b -----------------------------------
par(mfrow=c(1,1))
hist(xbar,main="répartition observée de la moy. emp. d'un n-echantillon gaussien" ,prob=T,ylim=c(0,max(dnorm(x,0,1/sqrt(n)))))
abline(v=mu,col=2)
abline(v=mean(xbar),col="green")#elles se superposent 
curve(dnorm(x,0,1/sqrt(n)),col=2,add=T) #fit avec les vrais paramètres 0 et 1
curve(dnorm(x,mean(xbar),sd(xbar)),col="green",add=T)#fit avec les paramètres estimés elle recouvre la prec!
#----------------------- question 1c-----------------------------------
sd(xbar) #ecart type de xbar estimé. calcul de prob dit su'il vaut sig/sqrt(n)
sd(xbar)-sig/sqrt(n) #faire varier n resimuler et observer. Faire augmenter N et observer


#----------------------- question 2-----------------------------------
n<-10
N<-10000
Gdata<-matrix(rnorm(N*n,mu,sig),ncol=n)
#----------------------- question 2a-----------------------------------
xbar<-rowMeans(Gdata)
s2<-rowMeans(Gdata*Gdata)-xbar^2 # vecteur des N variancess empiriques
sp2<-n/(n-1)*s2# vecteur des N variances empiriques corrigées (estimations ss biais de sig2
hist(s2,prob=T,main= "répartition observée de la variance empirique d'un n-echantillon")
abline(v=sig^2,col=2)
abline(v=mean(s2),col="green")#il y a un biais et on sait qu'il vaut -sig2/n
(mean(s2)-sig^2)-(-sig^2/n)

#----------------------- question  2b -----------------------------------  
hist(sp2,prob=T,main= "répartition observée de la variance est sans biais d'un n-echantillon")
abline(v=sig^2,col=2)
abline(v=mean(sp2),col="green")#il n'y a plus biais 
(mean(sp2)-sig^2) #sasn biais














