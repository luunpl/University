#-------------Exercice 1-------------------------------------

#-------------question 4-----------------
#------question 5-----
1:10
#------question 6-----
init <- 1:10 #affecte à init la liste des 10 premiers entiers
1:10 -> init # meme chose que précédemment
init=1:10 # autre option pour définir un objet mais préférer les deux premières
init # affiche le contenu de l'objet
#------question 7-----
help(":") #affiche l'aide pour l'opérateur :
#---------------------Exercice 2--------------
#------question 2-----
c(1,2,3,4,5)
#------question 3-----
x <- c(1,2,3,4,5)
#------question 4-----
x[2] #affiche le second ellement de x
x[c(2,4)] #affiche les elements en positions 2 et 4
x[-2]     #affiche tous les éléments de x sauf le deuxième
#------question 5-----
y <- c(2,4,6,8,10) #crée y
label <- c("a","b","c","d","e") #crée label
#------question 6----
A <- matrix(c(x,y),ncol=2,byrow=F) #définit A qui contient les colonnes x et y
A
cbind(x,y) #produit la matrice des col x et y en donnant à chaque colonne le nom de son vect
#------question 7-----
A[1,2] #extrait et affiche l'élement en ligne 1 colonne 2
A[,1]#extrait la colonne 1
A[2,]#extrait la ligne 2
#------question 8-----
un <- rep(1,5) #vecteur de longueur 5 dont tous les élements sont 1.
B <- matrix(c(x,y,un),ncol=3,byrow=F) # definit la matrice B
B # affiche B : matrice A complétée du vecteur un
cbind(A,un) # affiche B avec les noms de colonnes en plus
x[x>2]
x>2&x<5
A+A

#---------------------Exercice 3--------------
#--------question 1------------
x/5 #divise chaque element de x par 5
x*5 #multiplie chaque element par 5
#--------question 2-----------
x+2 #ajoute 2 à chaque coordonnée de x
#--------question 3-----------
sum(x) #calcule la somme des coordonnées de x
cumsum(x) #calcule les sommes cumulées
#--------question 4-----------
length(x) #retourne la taille du vecteur x

#--------question 5-----------
sqrt(x) #calcule les racines
#--------question 6-----------
x^3 #calcul les puissance 3
#--------question 7-----------
c(x,6)#ajoute un nouvel élément au vecteur x
length(c(x,6))#retourne la longueur de x complété de la valeur 6
c(x,1,1,1,1,1)#concatene x et le vecteur (1,1,1,1,1)
c(x,rep(1,5))#une autre façon de faire
c(x,c(1,1,1,1,1))
seq(from=1,to=10,by=.2) #construit la suite de nombres allant de 1 à 10 par pas de 0.2
seq(1,10,.2)            #dit en plus court
#--------question 8-----------
x>0 #retourne un vecteur logique TRUE pour tous les indices où la condition est vraie
which(x>0) #les indices pourlesquels la condition est vérifiée
#--------question 9-----------
length(which(x>0)) #le nombre de fois dans x ou la coordonnée est positive
#--------question 9-----------
which(x!=2)  #les positions où la coordonnée ne vaut pas 2
x>0&x<2      #logique resultat du test sur chaque coordonnées dans ]0,2[
sum(x>0&x<2) #nombre de coordonnées de x dans ]0,2[ 
# remarque :  TRUE est codé en 1 et False en 0

#---------------------Exercice 4--------------
#--------question 1------------
x+y #ajoute les coordonnées deux à deux
x-y #les soustrait
#--------question 2------------
x*y #produit deux à deux
x/y #divise deux à deux
#--------question 3------------
cbind(x,y) #produit une matrice à deux colonnes avec x dans la premiere et y ds la sde
t(cbind(x,y))#transpose la matrice précédente. On pouvait l'obtenir directement avec
rbind(x,y) #concatène deux lignes pour produire une mat à deux lignes et 5 colonnes

#---------------------Exercice 5--------------
#--------question 1------------
sum(x)/length(x)#moyenne empirique à la main
mean(x)#avec la fonction auto de R
sum(x*x)/length(x)#moyenne des carrés
sum(x*x)/length(x)-(sum(x)/length(x))^2#variance empirique s2 à la main
var(x)#varianec empirique corrigée s'2 avec var()
(sum(x*x)/length(x)-(sum(x)/length(x))^2)*length(x)/(length(x)-1)
#variance empirique corrigée calculée à la main
#--------question 2------------
mean(x<=2)
#--------question 3------------
length(which(x>y))

#---------------------Exercice 6--------------
#--------question 1------------
abs <- seq(0,7,.1) #crée le vecteur abs
abs #affiche abs
#--------question 2------------
ord <- sin(abs) #calcule f(abs) pour f=sin
ord #affiche ord
#--------question 3------------
plot(abs,ord,type="l",main="graphe de la fonction sinus",xlab="abscisse ",ylab="sinus")
curve(sin(x),from=0,to=7,n=100,col="red",add=T) #tracé du sin en rouge
#--------question 4------------
abline(h=1,col="red")
abline(0,1,col="green")
abline(h=0) # ajoute l'axe des abscisses
abline(v=0) # ajoute l'axe des ordonnées
#--------question 5------------
points(3,1)
#--------question 6-------------
curve(cos, add=T,col=1) #ajoute le tracé de la fonction cos en rouge.

#---------------------Exercice 7--------------

# pour lire un fichier, on doit indiquer à R son emplacement: 
#  1) soit avec le menu session  > set working directory > choose directory
#  2) soit directement avec l'instruction setwd("~/mypathtoSTA401/Data")
#  3) soit en donnant le fichier complet à read.table: read.table("~/mypathtoSTA401/Data/apnee.csv")
#--------question 1------------
apnee <- read.table("apnee.csv")
head(apnee)
#101 observations d'une seule variable ==> separateur de champs incorrect
apnee  <- read.table("apnee.csv",sep=",")
#les séparateurs de champs sont à présent corrects mais pas la première ligne
#ne l'est pas car elle contient les titres de colonnes et R à nommé
#par défaut les colonnes V1,V2...V13
apnee <- read.table("apnee.csv",sep=",",header=T)
head(apnee) #le fichier est correctement chargé et les variables correctement intitulées

#On peut utiliser le raccourci read.csv lorsque le séparateur dans le fichier 
#contenant les données est ","; la décimale "." et la première ligne une ligne de titres
head(read.csv("apnee.csv"))

#--------question 2------------
cardiaque <- read.table("cardiaque.csv",sep=",",dec=".",header=T)
head(cardiaque)
cardiaque$tabac #extrait l'échantillon donné dans la colonne "tabac" du data.frame "cardiaque"

#--------question 3------------
her <- read.table("her.txt",sep="\t",dec=".",header=T)
head(her) #les premières lignes du data.frame : titre de col., séparateurs et ligne 1 OK
her[2,3]  #obervation de la variable de la colonne 3 (sex), pour l'ind. ligne 2(I0003)
her[2,] #valeurs de toutes les variables pour indiv ligne 2
her[,3] #variable colonne 3 pour tous les individus