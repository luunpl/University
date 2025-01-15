#-------------Exercice 1-------------------------------------
#instruction pour travailler dans le répertoire de travail TP 
setwd("~/DocLinuxMai14/MesDocsPCport/cours/L2MIN/STA240/TP")
#aussi accessible avec le menu session  > set working directory > choose directory
#------question 5-----
1:10
#------question 6-----
init<-1:10 #affecte à init la liste des 10 premiers entiers
1:10-> init # meme chose que précédemment
init=1:10 # autre option pour définir un objet mais préférer les deux premières
init # affiche le contenu de l'objet
#------question 7-----
help(":")


#---------------------Exercice 2--------------
#------question 2-----
c(1,2,3,4,5)
#------question 3-----
c(1,2,3,4,5)->x
#------question 4-----
x[2] #affiche le second ellement de x
x[c(2,4)] #affiche les elements en positions 2 et 4
x[-2]#affiche tous les éléments de x sauf le deuxième
#------question 5-----
c(2,4,6,8,10)->y #crée y
c("a","b","c","d","e")->label #crée label
#------question 6----
matrix(c(x,y),ncol=2,byrow=F)->A #définit A qui contient les colonnes x et y
A
cbind(x,y) #produit la matrice des col x et y en donnant à chaque colonne le nom de son vect
#------question 7-----
A[1,2] #extrait et affiche l'élement en ligne 1 colonne 2
A[,1]#extrait la colonne 1
A[2,]#extrait la ligne 2
#------question 8-----
un<-rep(1,5) #vecteur de longueur 5 dont tous les élements sont 1.
matrix(c(x,y,un),ncol=3,byrow=F)->B # definit la matrice B
B # affiche B : matrice A complétée du vecteur un
cbind(A,un) # affiche A avec les noms de colonnes en plus
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
seq(from=1,to=10,by=.2)#construit la suite de nombres allant de 1 à 10 par pas de 0.2
seq(1,10,.2)#dit en plus court
#--------question 8-----------
x>0 #retourne un vecteur logique TRUE pour tous les indices où la condition est vraie
which(x>0)#les indices pourlesquels la condition est vérifiée
#--------question 9-----------
length(which(x>0))#le nombre de fois dans x ou la coordonnée est positive
#--------question 9-----------
which(x!=2) #les positions où la coordonnée ne vaut pas 2
x>0&x<2#logique resultat du test sur chaque coordonnées dans ]0,2[
sum(x>0&x<2)#nombre de coordonnées de x dans ]0,2[ 
# remarque :  TRUE est codé en 1 et False en 0



