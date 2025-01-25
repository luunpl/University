#-------------Exercice 1-----------
# Q4
1:10 # Rien a afficher
# Q5
init<-1:10 # Affecter a init une liste de 10 premiers nombres
init=1:10  # Pareil avec la ligne ci dessus mais avec diffente facon
# Q6
help(":")

#-------------Exercice 2-----------
# Q2
c(1,2,3,4,5)
# Q3
x <- c(1,2,3,4,5) # Affecter la liste au variable x
x # Appeler
# Q4
x[2]      # pour obtenir l´element d’indice 2 du vecteur x et
x[c(2,4)] # pour obtenir les elements d’indices 2 et 4.
x[-2]     # Afficher le vecteur sans l'indice 2
# Q5
y <- c(2,4,6,8,10)
label<-c("a","b","c","d","e")
# Q6
A <- matrix(c(x,y),ncol=2,byrow=F) 
help("nrow") # Retourner le nombre de collone ou de ligne qui present dans x
cbind(x,y)   # Retourner comme nrow mais avec x ,y
# Q7
A[1,2] # Retourner la la valeur de premiere ligne, dexieme collone
A[,1]
A[2,]
un <- rep(1,5) # Creer un vecteur de 5 elems 1
B <- matrix(c(x,y,un), ncol=3, byrow=F) # Creer un matrix avec 3 vecteur x, y et un

#-------------Exercice 3-----------
# Q1
x/5
x*5
# Q2
x+2
# Q3
sum(x)    # Somme de tout les valeurs dans le vecteur
cumsum(x) # Retourner un vecteur de valeur cumule, le dernier valeur est egal a sum(x)
# Q4
length(x) # 5 valeurs
# Q5
sqrt(x)
# Q6
x ^ 3
# Q7
c(x,6)
c(x,1,1,1,1,1)
c(x,rep(1,5))
c(x,c(1,1,1,1,1))

seq(1,10,2)
seq(from=1,to=10,by=2)
seq(from=1,to=2,by=.2)
# Q8
x>0
which(x>0)
# Q9
length(which(x>0)) # Retourner le nombre de valeur qui valide la condition > 0 (ici c'est 5)
# Q10
which(x!=2)
x>0&x<2
sum(x>0&x<2)
# D'abord which renvoie le vecteur avec les elems qui sont differents de 2
# 2e commande donne une vecteur 1 TRUE et 4 FALSE car 1 valide les conditions
# 3e commande donner la somme des elems qui valident les conditions(ici somme d'un elem et le resultat est 1)

#-------------Exercice 4-----------
# Q1
x+y
x-y
# Q2 
x*y
x/y
# Q3
cbind(x,y)
rbind(x,y)
t(cbind(x,y))
# t() retourne la matrice transparente, cad reverser les lignes et collones(rbind(x,y) = t(cbind(x,y)))
#-------------Exercice 5-----------
# Moyenne empirique de x
sum(x) / length(x) 
mean(x)
# Variance empirique
# Proportion des coor de x<=2
length(which(x<=2))/length(x) # 40%
length(which(x>y)) # 0 fois

#-------------Exercice 6-----------
# Q1
abs <- seq(from=0,to=7,by=0.1)
# Q2
ord <- sin(abs) 
ord # Afficher ord
# Q3
plot(abs,ord,type="l",main="Graphe de f(x) = sin(x)",xlab="abscisse ",ylab="sinus",col="yellow")
curve(sin(x),from=0,to=7,n=100,col="black",add=T) #tracé du sin en rouge
# Q4
abline(h=1,col="red")
abline(0,1,col="green")
abline(h=0) # ajoute l'axe des abscisses
abline(v=0) # ajoute l'axe des ordonnées
# Q5
points(3, 1)
# Q6
curve(cos(x),from=0,to=7,n=100,col="black",add=T) #tracé du sin en rouge

#-------------Exercice 7-----------
# Q1
read.table("apnee.csv")
# Q2
apnee <- read.table("apnee.csv")
head(apnee)
summary(apnee)
# Summary retourne le detail d'une affection avec la taille, classe et mode
# Q3
read.table("cardiaque.csv",sep=",",dec=".",header=T)->card
head(card)
card
card$tabac # Extrait les donnees dans la colonne "tabac" du data.frame "cardiaque"
# Q4
her <- read.table("her.txt") 
her[2,3]  # Retourner la variable de la colonne 3 (sex), pour l'ind. ligne 2(I0003)
her[2,] # Valeurs de toutes les variables pour indiv ligne 2
her[,3] # Variable colonne 3 pour tous les individus
mean(her$V2)

