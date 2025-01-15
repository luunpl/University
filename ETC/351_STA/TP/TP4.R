#----------------------------------------------------------------------
#                         TP4
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Exercice 1
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
mu<-1; sig<-1; n<-50                # parametres
X<-rnorm(n,mu,sig)                  # echantillon simule
xbar<-mean(X)                       # moyenne empirique
#----------------------- question 2 -----------------------------------
alpha<-0.05       
#----------------------- question 3 -----------------------------------
u<-qnorm(1-alpha/2)                 # quantile d'ordre 1-alpha/1 de la loi normale
t<-qt(1-alpha/2,n-1)                # quantile d'ordre 1-alpha/1 de la loi de Student à n-1 dl
borneInf<-xbar-u*sig/sqrt(n)        # borne inferieure de l'IC si sig connu
borneInfsigI<-xbar-t*sd(X)/sqrt(n)        # borne inferieure de l'IC si sig est inconnu
borneSup<-xbar+u*sig/sqrt(n)        # borne superieure de l'IC si sig connu  
borneSupsigI<-xbar+t*sd(X)/sqrt(n)        # borne inferieure de l'IC si sig est inconnu
c(borneInf, borneSup); borneSup-borneInf              #IC si sigma connu et amplitude
c(borneInfsigI, borneSupsigI);  borneSupsigI-borneInfsigI      #IC si sigma inconnu et amplitude
#----------------------- question 4 -----------------------------------
alpha<-0.10
u<-qnorm(1-alpha/2)
borneInf<-xbar-u*sig/sqrt(n)
borneSup<-xbar+u*sig/sqrt(n)
c(borneInf, borneSup); borneSup-borneInf  
alpha<-0.01
u<-qnorm(1-alpha/2)
borneInf<-xbar-u*sig/sqrt(n)
borneSup<-xbar+u*sig/sqrt(n)
c(borneInf, borneSup); borneSup-borneInf  
#----------------------- question 5a -----------------------------------
N<-100
X100<-matrix(rnorm(N*n,mu,sig), N,n)   # N echantillons de taille n
#----------------------- question 5b -----------------------------------
x100bar<-rowMeans(X100)
#----------------------- question 5c -----------------------------------
alpha<-0.05       
u<-qnorm(1-alpha/2)                    # quantile d'ordre 1-alpha/1
borneInf<-x100bar-u*sig/sqrt(n)        # borne inferieure de l'IC
borneSup<-x100bar+u*sig/sqrt(n)        # borne superieure de l'IC
#----------------------- question 5d -----------------------------------
CI100<-rbind(borneInf, borneSup)       # 100  intervalles de confiance
matplot(CI100, rbind(1:100, 1:100), type='l', lty=1, ylab="") #graphique des IC
abline(v=mu)                           # vraie valeur
#----------------------- question 5e -----------------------------------
which(mu>borneSup)                     # indices pour lesquels mu depasse borneSup
length(which(mu>borneSup))             # nombre de ces indices
#----------------------- question 5f -----------------------------------
length(which(mu<borneInf))
#----------------------- question 5g -----------------------------------
sum((borneInf<mu)&(mu<borneSup)) #nbre de fois ou mu est ds l'IC calculé
mean((borneInf<mu)&(mu<borneSup)) #freq avec lq  mu est ds l'IC calculé

#----------------------- question 6a -----------------------------------
mu<-0
x<-rnorm(1000,mu,1)
#----------------------- question 6b -----------------------------------
n<-100
x100<-x[1:n]                           # extraction des 100 premieres valeurs
xbar<-mean(x100)                       # moyenne empirique
alpha<-0.05       
u<-qnorm(1-alpha/2)                    # quantile d'ordre 1-alpha/1
borneInf<-xbar-u*sig/sqrt(n)           # borne inferieure de l'IC
borneSup<-xbar+u*sig/sqrt(n)           # borne superieure de l'IC
(ci100<-c(borneInf, borneSup))
#----------------------- question 6c -----------------------------------
n<-500
x500<-x[1:n]                           # extraction des 500 premieres valeurs
xbar<-mean(x500)                       # moyenne empirique
alpha<-0.05       
u<-qnorm(1-alpha/2)                    # quantile d'ordre 1-alpha/1
borneInf<-xbar-u*sig/sqrt(n)           # borne inferieure de l'IC
borneSup<-xbar+u*sig/sqrt(n)           # borne superieure de l'IC
(ci500<-c(borneInf, borneSup))
#----------------------- question 6d -----------------------------------
n<-1000
x1000<-x[1:n]                          # extraction des 1000 premieres valeurs
xbar<-mean(x1000)                      # moyenne empirique
alpha<-0.05       
u<-qnorm(1-alpha/2)                    # quantile d'ordre 1-alpha/1
borneInf<-xbar-u*sig/sqrt(n)           # borne inferieure de l'IC
borneSup<-xbar+u*sig/sqrt(n)           # borne superieure de l'IC
(ci1000<-c(borneInf, borneSup))
#----------------------- question 6e -----------------------------------
plot(c(0,1100), c(0,0), type="l", ylim=c(-0.3, +0.3), xlab="", ylab="")
lines(c(100,100), ci100)
lines(c(500,500), ci500)
lines(c(1000,1000), ci1000)

#ou en imitant le graphique de la question 5d)

CI100<-cbind(ci100,ci500,ci1000)        # 3 intervalles de confiance
matplot(CI100, rbind(1:3, 1:3), type='l', lty=1, ylab="") #graphique des IC
abline(v=mu)   
#----------------------------------------------------------------------
# Exercice 2
#---------------------------------------------------------------------- 
#----------------------- question 1 -----------------------------------
FE <- read.table(file="ferretti.csv",header=TRUE,sep=";")
H <- FE[,1]                                  
#----------------------- question 2 -----------------------------------
t.test(H)$conf.int                      # intervalle de confiance de la moyenne
t.test(H,conf.level=0.9)$conf.int       # niveau de confiance de 0.90%
t.test(H,conf.level=0.99)$conf.int      # niveau de confiance de 0.99%
#----------------------- question 3 -----------------------------------
alpha<-0.05
n<- length(H)
t<-qt(1-alpha/2,n-1)                # quantile d'ordre 1-alpha/1
mh<-mean(H)
sh<-sd(H)
borneInf<-mh-t*sh/sqrt(n)           # borne inferieure de l'IC
borneSup<-mh+t*sh/sqrt(n)           # borne superieure de l'IC
c(borneInf, borneSup)
#------------------- question 4----------------
names(FE) #diameter est la colonne 2 du dataframe
D <- FE[,2]
summary(D); sd(D)
#----------------------- question 5 -----------------------------------
t.test(D)$conf.int                      # intervalle de confiance de la moyenne au niveau 95%
t.test(D,conf.level=0.9)$conf.int       # niveau de confiance de 0.90%
t.test(D,conf.level=0.99)$conf.int      # niveau de confiance de 0.99%
#----------------question 6-------------
head(FE) #affiche les premieres lignes du dataframe; invasive a les modalite yes ou no
FE[FE$invasive=="yes",2]->D_inv #extrait l'échantillon des diametres pour les tumeurs invasives
FE[FE$invasive=="no",2]->D_noninv #extrait l'échantillon des diametres pour les tumeurs non invasives
t.test(D_inv)$conf.int # intervalle de confiance de la moyenne au niveau 95% chez les invasives
t.test(D_noninv)$conf.int # intervalle de confiance de la moyenne au niveau 95% chez les non invasives
#ils ont une intersection tres petite il y a nettement un effet du type de tumeur sur son diametre  moy
#----------------------------------------------------------------------
# Exercice 3
#----------------------------------------------------------------------

#------------------------question 1------------------------------------
x <- 4998; n <- 5636                      # donnees x : nbre d'oeufs fertiles parmi n
# dans le groupe avec males exposés
#------------------------question 2------------------------------------
# x est la réalisation d'une variable X binômiale (n,p) avec pexpo inconnu
# donnees x : nbre d'oeufs fertiles parmi n
#----------------------- question 3 -----------------------------------

Fexpo <- x/n                              # fréquence observée d'oeufs fertiles dans l'ech
# des males exposés = estimation de pexp 
sig <- sqrt(Fexpo*(1-Fexpo))              # ecart-type estimé 
Fexpo + qnorm(c(0.025,0.975))*sig/sqrt(n1)  # IC de niveau approximatif 95% chez les expo
#----------------------- question 4 -----------------------------------
prop.test(x=x,n=n)$conf.int               # IC exact (qui utilise directement la binômiale)
#----------------------- question 5 -----------------------------------
x1 <- 5834; n1 <- 6221                      # donnees dans le groupe contrôle soit non expos
Fnexpo <- x1/n1                             # fréquence observée d'oeufs fertiles dans le 
# groupe non exposé = estimation de pnexpo
sig <- sqrt(Fnexpo*(1-Fnexpo))              # proportions
Fnexpo + qnorm(c(0.025,0.975))*sig/sqrt(n1) # IC de niveau approximatif 95% 
prop.test(x=x1,n=n1)$conf.int               # IC de niveau exact 95%

#--------------------- question 6 -----------------------------------------------
# Les intervalles obtenus ne s'intersectent pas (qu'ils soient approchés ou exacts)
# Donc on conclut que l'exposition des mâles à la radiation a un effet très significatif
# sur la fertilité de ses oeufs


#----------------------------------------------------------------------
# Exercice 4
#----------------------------------------------------------------------

#------------------------question 1------------------------------------
xbar <- 4.38; n <- 90                     # moy emp et taille de l'ech
sig<-0.08                                 # ecart-type connu
alpha<-0.01
binf<-xbar-sig/sqrt(n)*qnorm(1-alpha/2)
bsup<-xbar+sig/sqrt(n)*qnorm(1-alpha/2)
c(binf,bsup)                              #ic de niveau 1-alpha avec sigma connu

#------------------------question 2------------------------------------
alpha<-0.05
# pour n tel que sig/sqrt(n)*qnorm(1-alpha/2) = 0.01
n_min<-(sig*qnorm(1-alpha/2)*10^2)^2;n_min #il faudrait au moins n=425 pour garantir la précis demandée

#----------------------- question 3 -----------------------------------
# on cherche alpha pour lequel sig/sqrt(n)*qnorm(1-alpha/2)=0.01
(1-pnorm(0.01/sig*sqrt(n)))*2->alpha
1-alpha #niveau de confiance de l'intervalle precis à + ou -0.01 
