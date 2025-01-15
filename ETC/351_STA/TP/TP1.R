#----------------------------------------------------------------------
#                         TP1
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Exercice 2
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
c(1,2,3,4,5)
#----------------------- question 2 -----------------------------------
x<-c(1,2,3,4,5)
x
#----------------------- question 3 -----------------------------------
y<-c(2,4,6,8,10)
#----------------------- question 4 -----------------------------------
length(x)
length(y)
#----------------------- question 5 -----------------------------------
plot(x,y)
#----------------------- question 6 -----------------------------------
#enrichi avec un titre un choix de symbole, une couleur, une légende sur chaque axe,
#un type (par ex "p", l","b","s", "h"...)...un label sur l'axe des x...
par(mfrow=c(1,1))#permet de définir la fenetre graphique (qui sera complétée en lignes)
#ici une ligne et une colonne
plot(x,y, main="y given x", xlab = "x", ylab = "y") # add a title, labels on both axis
plot(x,y, type = "p", pch = 3) # change the symbol
plot(x,y, type = "b") # add a line
plot(x,y, col = "red") # change the color
help(plot)
#puis aller plus loin dans l'aide en selectionnant graphical parameters

 
#----------------------------------------------------------------------
# Exercice 3
#----------------------------------------------------------------------
#Manipulations élémentaires sur un vecteur :
#----------------------- question 1 -----------------------------------
x/5 #  divise un vecteur par un scalaire
x*5 # multiplie  un vecteur par un scalaire
x+5 # ajoute un scalaire à un vecteur
sum(x) # calcule la somme de tous les éléments de x
cumsum(x) # somme cumulée de x
sqrt(x) # racine carrée de x 
x^3 # x à la puissance 3
#----------------------- question 2 -----------------------------------
c(x,6)
c(x,1,1,1,1,1)
c(x,rep(1,5)) # rep() répete la meme valeur  
c(x,seq(from=1, to=10, by=2)) # seq() crée une sequence
c(x,6:15)
c(seq(from=1,to=61,by=3), rep(2,20), 1:20)
#----------------------- question 3 -----------------------------------
(y>4)
y>4
(y!=4) 
(y==4) 
(y>4)&(y<=6)
#----------------------- question 4 -----------------------------------
y[c(2,4)]
y[1:4]
y[(y>4)] 
y[(y>2)&(y<=8)]
z[(z!=1)] 
x[(x==4)] 
#----------------------- question 5 -----------------------------------
x+y 
x*y 
x/y
#----------------------- question 6 -----------------------------------
cbind(x,y) # matrice à 5 lignes et 2 colonnes 
rbind(x,y) # matrice à 2 lignes et 5 colonnes
#----------------------- question 7 -----------------------------------
M<-rbind(x,y,y,x) # matrice avec 4 lignes et 5 colonnes}
M                 # toute la matrice
M[3,2]            # élément de la 3ieme ligne 2ieme colonne
M[ ,1]            # élément de la premiere colonne
M[2:3, ]
M[, c(1,3)]
 
#----------------------------------------------------------------------
# Exercice 4
#----------------------------------------------------------------------
#----------------------- question 2 -----------------------------------
Rp <-c(40,38,6,1)        # vecteur des effectifs des Rhesus +
Rm <-c(7,7,1,0)          # vecteur des effectifs des Rhesus m
#----------------------- question 3 -----------------------------------
S <- rbind(Rp,Rm) ; S                       # table de contingence 2x4 : effectifs conjoints
rownames(S) <- c("R+","R-")                 # nom des lignes
colnames(S) <- c("O","A","B","AB")          # nom des colonnes
S
#----------------------- question 4 -----------------------------------
n <- sum(S)                            # effectifs total de l'échantillon
#----------------------- question 5 -----------------------------------
rowSums(S)                          # distribution en effectif du facteur Rhesus
rowSums(S)/n                        # distribution marginale en frequences du facteur
#----------------------- question 6 ------------------------------------
# représenter à l'aide d'un diagramme en barre la distribution  en fréquence du gpe
# a) indépendemment du rhésus : ie distribution marginale du groupe
colSums(S)/n#distribution marginale du groupe
barplot(colSums(S)/n, main="marginale du groupe")
# b) sur la sous-population des rhésus positifs
Rp/sum(Rp) #distribution conditionnelle du groupe sachant rhesus positif
barplot(Rp/sum(Rp),names=c("O","A","B","AB"),main="dist. cond. du groupe sachant facteur Rhesus = R+")
# c) sur celle des rhésus négatifs
Rm/sum(Rm) #distribution conditionnelle du groupe sachant rhesus négatif
barplot(Rm/sum(Rm),names=c("O","A","B","AB"),main="dist. cond. du groupe sachant facteur Rhesus = R-")
#Afin de comparer les graphiques affichons les sur une même page
par(mfrow=c(3,1)) # partitionne la fenêtre graphique en trois et remplit successivt les lignes 
barplot(colSums(S)/n, main="marginale du groupe")
barplot(Rp/sum(Rp),names=c("O","A","B","AB"),main="dist. cond. du groupe sachant facteur Rhesus = R+")
barplot(Rm/sum(Rm),names=c("O","A","B","AB"),main="dist. cond. du groupe sachant facteur Rhesus = R-")
#la ressemblance des trois distribution indique l'indépendance entre les facteurs étudiés
par(mfrow=c(1,1))#retour à une seule fenetre
# Exercice 5
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
TI <- read.table(file="titanic.csv",header=TRUE,sep=";") 
# charge le fichier de données depuis 
# le répertoire de travail 
#----------------------- question 2 -----------------------------------
head(TI)                                    # affiche les  6 premières lignes de TI
str(TI)                                     # décrit la structure d'un objet
#----------------------- question 3 -----------------------------------
names(TI)                                   # noms des colonnes
colnames(TI)
#----------------------- question 4 -----------------------------------
P <- TI[,1]                                 # discrete
S <- TI[,2]                                 # discrete
G <- TI[,3]                                 # discrete
A <- TI[,4]                                 # continue
#----------------------- question 5 -----------------------------------
TI[250:257,]                                # lignes selectionnees
TI[c(3,45,73), ]                       
TI[,c(1,3)]                                 # colonnes selectionnees
TI[c(67, 83, 101),c(2,4)]                   # colonnes et lignes selectionnes
#----------------------- question 6 -----------------------------------
TI[P==1,]                                   # données des passagers de premiere classe
TI[which(P==1),]                            # meme chose 
TI[P==3,]                                   # données des passagers de troisieme classe
TI[(P==1|P==2),]                            # données des passagers de premire et deuxieme classes
# | pour "ou" et & pour "et"
TI[-(P==3), ]                               # meme chose avec - pour enlever des lignes

#----------------------- question 7 -----------------------------------
TI[which(P==1 & G=="F"),]                   # données des femmes de premiere classe
TI[which(P==2 & G=="M"),]                   # données des hommes de deuxième classe
#----------------------- question 8 -----------------------------------
TI[A<1,]                                    # donnees des bebes
TI[A<18,]                                   # donnees des enfants
TI[(A>12)&(A<=18),]                         # donnees des adolescents
TI[A>18,]                                   # donnees des adultes
#----------------------- question 9 -----------------------------------
tP <- table(P)  ; tp                        # effectifs selon la classe et affichage
prop.table(tP)                              # proportions
barplot(tP)                                 # diagramme en barres
#----------------------- question 10 -----------------------------------
tS <- table(S); tS                          # effectifs selon la survie
prop.table(tS)                              # proportions
barplot(tS)                                 # diagramme en barres
tG <- table(G); tG                          # effectifs selon le sexe
prop.table(tG)                              # proportions
barplot(tG)                                 # diagramme en barres
#----------------------- question 11 -----------------------------------
tPS <- table(P,S); tPS                      # eff croisés selon classe(ligne) et survie(col)
prop.table(tPS)                             # proportions obs selon classe et survie
prop.table(tPS,1)                           # proportions de S conditionnelles à P
prop.table(tPS,2)                           # proportions de P conditionnelles à S
barplot(table(P,S))                         # repart en effectifs  de P selon la valeur de S
barplot(table(S,P))                         # S selon la valeur de P

#------------------------représentations graphiques possibles-----------------------------------
#pour aller un peu plus loin avec barplot
barplot(table(S,P),beside=T,col=c(2,3),legend=c("no survived","survived"))
#repartitions en effectifs de S selon la classe P, on observe plus de monde en 3 classe
#si on veut comparer des répartitions en fréquences
barplot(prop.table(table(S,P)),beside=T,col=c(2,3),legend=c("no survived","survived"))
#Ici la somme des 6 hauteurs vaut un car il s'agit de la loi conjointe
#on peut lire 10% des passagers etaient en premières classe et n'ont pas survécus

#Si on veut représenter les répartitions de S conditionnelles à P
barplot(prop.table(table(S,P),2),beside=T,col=c(2,3),legend=c("no survived","survived"))


#on peut dire par ex que sachant qu'on était en classe 3 on avait 3 fois plus de chances
#de mourir que survivre alors  que si on était en 1ere on avait presque 2 fois plus de chances
# de survivre que mourir 

# ==> manifestement les chances de survie sont liées à la classe occupée !!

#----------------------- question 12 -----------------------------------
tPG <- table(P,G); tPG                      # effectif
prop.table(tPG)                             # proportions conjointes
prop.table(tPG,1)                           # proportions conditionnelles à P
prop.table(tPG,2)                           # proportions conditionnelles à G
barplot(table(P,G))                         # P selon la valeur de G
barplot(table(G,P))                         # G selon la valeur de P




#----------------------------------------------------------------------
# Exercice 6
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
BO <- read.table(file="bosson.csv",header=TRUE,sep=";")
#----------------------- question 2 -----------------------------------
head(BO)                                    # 6 premières lignes
names(BO)                                   # nom des colonnes
#----------------------- question 3 -----------------------------------
C <- BO[,1]                                 # qualitative
G <- BO[,2]                                 # qualitative
R <- BO[,5]                                 # quantitative discrete
#----------------------- question 4 -----------------------------------
BO[120:123,]                                # lignes selectionnees
BO[c(67,83,101),c(1,3)]                     # colonnes et lignes selectionnes
BO[C=="Vietnam",]                           # données des vietnamiens
R[G=="M"]                                   # facteurs de risques des hommes
#----------------------- question 5 -----------------------------------
tC <- table(C); tC                          # effectifs par pays
prop.table(tC)                              # proportions
barplot(tC)                                 # barplot
tG <- table(G); tG                          # effectifs par sexe
prop.table(tG)                              # répartition (en fréquences) du sexe
barplot(tG)                                 # barplot
#----------------------- question 6 -----------------------------------
tCG <- table(C,G); tCG                      # effectifs
prop.table(tCG)                             # proportions conjointes (des couples de modalités)
prop.table(tCG,1)                           # répartitions de G conditionnelles à C
prop.table(tCG,2)                           # répartitions de C conditionnelles à G
barplot(table(C,G),legend=c("France","Vietnam"))            
# effectifs de C selon la valeur de G
barplot(table(G,C), legend=c("F","M"))      # effectifs de G selon la valeur de C
#----------------------- question 7 -----------------------------------
tCR <- table(C,R); tCR                      # effectifs conjoints
prop.table(tCR)                             # proportions conjointes
prop.table(tCR,1)                           # proportions de R conditionnelles à C
prop.table(tCR,2)                           # proportions de C conditionnelles à R
barplot(table(C,R))                         # eff de C selon la valeur de R
barplot(table(R,C))                         # effectifs de R selon la valeur de C
#----------------------- question 8 -----------------------------------
tGR <- table(G,R); tGR                      # effectifs
prop.table(tGR)                             # proportions conjointes
prop.table(tGR,1)                           # proportions de R conditionnelles à G
prop.table(tGR,2)                           # proportions de G conditionnelles à R
barplot(table(G,R))                         # G selon la valeur de R
barplot(table(R,G))                         # R selon la valeur de G
barplot(prop.table(table(G,R),1),beside=T,legend=c("F","M"))
# la répartition du risque chez les femmes diffère significativement 
# de celle observée chez les hommes : le risque est en moyenne moins élevé chez les femmes
# et dépend manifestement du sexe