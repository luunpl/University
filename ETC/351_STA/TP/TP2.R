#----------------------------------------------------------------------
#                         TP2
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Exercice 1
#----------------------------------------------------------------------
#----------------------- question 2 -----------------------------------
ages <- c(rep(21,7),rep(22,8),rep(23,9),rep(24,10),rep(25,12),
           rep(26,3),rep(27,2),rep(28,5),rep(29,4),rep(30,5),rep(31,2),
           rep(32,4),rep(33,2),35)
ages                                      # affiche ages
#----------------------- question 3 -----------------------------------
n<-length(ages)                           # effectif total n=74
#----------------------- question 4 -----------------------------------
table(ages)                               # effectifs par classe
                                          # ages est une var discrète
#----------------------- question 5 -----------------------------------
prop.table(table(ages))                   # frequences par classe -- 
                                          # 16,26% de femmes de 25 ans....
(prop.table(table(ages))->FreqAges)       #affecte les frequences calculées à FreqAges
                                          # et l'affiche (ajout des () exterieures)
#----------------------- question 6 -----------------------------------
ages<30                                   # retourne un vecteur logique avec TRUE si ages<30
table(ages<30)                            # nombre de False et de True ==> 60 moins de 30 ans
table(ages>28)                            # nb de TRUE = nb de femmes d'age >28
table(ages<30)/n                          # 81 %
table(ages>28)/n                          # 24,3%
#----------------------- question 7 -----------------------------------
quantile(ages,0.05)                       # 5% des femmes obs ont au moins 21 ans 
quantile(ages,0.95)                       # 95% .......ont au moins 32 ans 
#----------------------- question 8 -----------------------------------
mean(ages)                                # age moyen
#----------------------- question 9 -----------------------------------
var(ages)                                 # variance empirique corrigée s'2
var(ages)*(length(ages)-1)/length(ages)             # variance empirique s2
mean(ages*ages)-mean(ages)*mean(ages)     # variance empirique s2
#----------------------- question 10 -----------------------------------
sd(ages)                                  # ecart-type empirique corrigé s'
sd(ages)*sqrt((length(ages)-1)/length(ages)) # ecart-type empirique s
#----------------------- question 11 -----------------------------------
summary(ages)                             # quelques indicateurs statistiques
median(ages)                              # mediane
quantile(ages,c(0.25,0.5,0.75))           # quartiles
quantile(ages)                            # quartiles minimum (0%) et maximum (100%)
#----------------------- question 12 -----------------------------------
barplot(table(ages)/length(ages))         #presque ok dans ce cas (manque le 34)
#mais incorrect en général il vaut mieux prendre de bonnes habitudes et utiliser
plot(table(ages)/n,type="h",lwd=10, ylab="fréquences")


cumsum(FreqAges)                        # fréquences cumulées, qui correspondent aux valeurs de la fonction de distribution empirique
#----------------------- question 13 -----------------------------------
plot(ecdf(ages))                          # tracé de la fonction de distribution empirique
abline(h=0.5,col="red")                   # ligne horizontale à 0.5
abline(v=median(ages),col="red")          # ligne verticale à la médiane
abline(h=0.25,col="blue")                 # ligne horizontale à 0.25
abline(v=quantile(ages,0.25),col="blue")  # ligne verticale au premier quartile
abline(h=0.75,col="green")                # ligne horizontale à 0.75
abline(v=quantile(ages,0.75),col="green") # ligne verticale au 3eme quartile
#----------------------- question 14 -----------------------------------
boxplot(ages)                             # boite à moustaches
abline(h=mean(ages),col="red")          # ligne verticale à la moyenne
abline(h=median(ages),col="blue")          # ligne verticale à la médiane
abline(h=quantile(ages,0.25),col="green")  # ligne verticale au premier quartile
abline(h=quantile(ages,0.75),col="green") # ligne verticale au 3eme quartile
#----------------------- question 15 -----------------------------------
#sur le graphe de la FdR empirique fait question 13 la proba cherchée
#est la taille du saut entre le palier modalité 21 et celui modalité 25
#il reprsente la fréquence avec laquelle on tombe dans [22,25]=freq d'etre<=25 -freq d'etre<=21
#----------------------------------------------------------------------
# Exercice 2
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
data=read.table("proteine.csv", header=TRUE, sep = ";")
head(data)
#----------------------- question 2 -----------------------------------
dim(data)
data[1:10,]
data[c(2,4,5),]
data[,c(5,6)]
#----------------------- question 3 -----------------------------------
names(data)
#----------------------- question 4 -----------------------------------
(I<-data$isoelec)   # création de I et affichage avec ()
I<-data[,4];I       # même chose avec affichage avec I (deux commandes sont sep par;
summary(I)
#----------------------- question 5 -----------------------------------
hist(I, main="répartition observee de isoelec (en effectifs)", xlab="isoelec", ylab="effectifs") #hist en effectifs
#on obtient l'hist en fréquence avec l'option prob=T ou freq=F
hist(I, main="répartition observee de isoelec", xlab="isoelec", ylab="frequences", prob=T)
abline(v=mean(I), col="red")
abline(v=median(I), col="blue")
abline(v=quantile(I,c(0.25,0.75)), col="green")
# pour superposer une courbe de densité sur un plot on utilise points()
(abs<-seq(2,13,0.1)) # crée la collection des abscisses des points de la courbe
(ord<-dnorm(abs,mean(I),sd(I))) #calcule les ordonnées si on superpose une densité normale
points(abs,ord,type="l",col=2) #rajoute la courbe de la densité sur l'hist
curve(dnorm(x,mean(I),sd(I)),from=2, to=13, add=T, n=111, col="green")#pareil
#l'adéquation avec une densité normale ne parait pas très satisfaisante sur l'inter [7,9]
#----------------------- question 6 -----------------------------------
hist(I,nclass=40,prob=T) # en effet il faudrait plutôt une densité à 2 voire 3 bosses
curve(dnorm(x,mean(I),sd(I)),from=2, to=13, add=T, n=111, col="green")#pareil

#----------------------- question 7 -----------------------------------
boxplot(I)
IV<-data[data$regne=="Viridiplantae",4]
IM<-data[data$regne=="Metazoa",4]
boxplot(IV, IM, names=c("Viridiplantae", "Metazoa"), ylab="isoelec")
#----------------------- question 8 -----------------------------------
plot(ecdf(I)) 
#-----------------------------------------------------------
#   Exercice 3
#-------------------------------------------------------

#----------------------- question 1 -----------------------------------
mu<-2                   # crée mu et lui affecte la valeur 2
sig<-0.5                # crée sig et lui affecte la valeur 0.5
#----------------------- question 2 -----------------------------------
curve(dnorm(x,mu,sig),from=mu-3*sig ,to=mu+3*sig, ylim=c(0,1),xlim=c(-0.1,3.5)) #  tracé de la densité sur [mu-3sig,mu+"sig)] 
curve(pnorm(x,mu,sig),from=mu-3*sig ,to=mu+3*sig, add=T,col=3) #ajout de la Fdr
abline(v=0,h=0)         #tracé des axes
#----------------------- question 3 -----------------------------------
points(0,0.6,pch=20,col=3)   #l'ordre 0.6 se lit en ordonnée
abline(h=0.6,lty=2,col=3)    #aide à la lecture de l'antécédant de 0.6
abline(v=qnorm(0.6,mu,sig),lty=2,col=3) #idem
points(qnorm(0.6,mu,sig),0,col=2,pch=20) #le quantile en abscisse : antécédant de 0.6 par la FdR
qnorm(0.6,mu,sig) #valeur du quantile cherché

#----------------------------------------------------------------------
# Exercice 4
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
x <- c(0,1,1)                                 # vecteur x
#----------------------- question 2 -----------------------------------
sample(x)                                   #  permutation aléatoire de x: 3 tirages dans x sans remise
#executer 20 fois la commande précédente et compter à la main
#----------------------- question 3 -----------------------------------
n <- 100
sample(x,n,replace=TRUE)                    # n tirages aléatoires dans x et avec remise
E <- sample(x,n,replace=TRUE)               # n-échantillon aléatoire de valeurs tirées dans x
#----------------------- question 4 -----------------------------------
table(E)
prop.table(table(E)) # proportions
barplot(prop.table(table(E)))  #diagramme en barres avec l'outil de repres d'une qualitative
plot(prop.table(table(E)),type="h",lwd=15)               # diagramme en barres avec plot
#----------------------- question 5 -----------------------------------
mean(E)
mean(E)-2/3 #aller remplacer n en ligne 139 par 10000 er réexecuter les lignes 140 à 149

#----------------------- question 6 -----------------------------------

E <- sample(c(0,1),n,replace=TRUE, prob=c(1/3,2/3)) # tirage aléatoire
mean(E)-2/3
plot(prop.table(table(E)),type="h",lwd=15) #oui car une distribution tres semblable à celle de Q4



 


 