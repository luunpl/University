#les données mtcars- 
help("mtcars") #donne une description des données : nom des variables et descr ou pas..
# Un des inconvénients de R : une aide parfois très succinte

#-------------------Exercice 1-----------------------------
#-----question 1----------------------------
mtcars
#-----question 2----------------------------
names(mtcars) #retourne le nom de chaque colonne du data.frame
#-----question 3----------------------------
head(mtcars)
#2 qualitatives : am et vs (modalités 0 ou 1),
#3 quanti discretes : cyl (4,6 ou 8); gear (3,4 ou 5) et carb (1,2,3,4,6 et 8)
mtcars$carb #retourne l'échantillon des nbre de carburateurs 
#-----question 4----------------------------
summary(mtcars) #un premier résumé numérique
#la moyenne de mpg est 20.09 
#(attention l'indicateur mpg donne une distance parcourue pour un gallonde carburant)
#plus le mpg est faible plus le moteur est gourmand
#la valeur max de disp est 472
#la proportion de manuelles (codé 0) est la moyenne de am (car 1 si man et 0 sinon)
#soit 40,62% donc 59,38% d'automatiques
#--------------fin exercice 1----------------------

#-------------------Exercice 2-----------------------------
#-----question 1----------------------------
mtcars$mpg->mpg #indicateur de consommation
mtcars$cyl->cyl #nb cylindres
mtcars$am->am #transmission 1 si manuelle
mtcars$disp->disp #vol de carb déplacé dans les pistons du moteur (gde va = gros moteur)
#-----question 2----------------------------
boxplot(mpg,main="distance parcourue en miles pour un gallon d'essence",ylab="mpg")
#-----question 3----------------------------
mtcars[am==0,]#tableau de données du sous echantillons des automatiques
mtcars[am==0,]$mpg->mpga#mpg #echant consomm pour les automatiques
mtcars[am==0,"mpg"]->mpga#autre moyen pour produire mpga
mtcars[am==1,"mpg"]->mpgm#consomm pour les manuelles
names(mtcars)
#-----question 4----------------------------
boxplot(mpga,mpgm,names=c("automatique","manuelle"),main="mpg selon la transmission")
#les manuelles sont plus économiques
#--------------fin exercice 2----------------------

#-------------------Exercice 3-----------------------------
#-----question 1----------------------------
table(am) #données présentées au format compact avec tab en effectifs
(table(am)/sum(table(am))->freqtab) #table de la loi de probab observé (en fréquences)
prop.table(table(am))#pareil
#-----question 2----------------------------
pie(table(am),labels=c("automatique","manuelle"), main="transmission")#camembert
pie(freqtab,labels=c("automatique","manuelle"), main="transmission")#le même
# help("pie")peut s'avérer utile pour customiser le graphique
barplot(freqtab, main="transmission",names=c("automatique","manuelle"),ylab="fréquences")
#attention pie s'applique sur les effectifs ou sur les fréquences mais  pour obtenir
#un diagramme en barre juste il faut appliquer barplot aux fréquences.
#-----question 3----------------------------
par(mfrow=c(1,2))
pie(freqtab,labels=c("automatique","manuelle"), main="transmission")
barplot(freqtab, main="transmission",names=c("automatique","manuelle"),ylab="fréquences")
#dès que plus de 5 modalités le diagramme en barres est préférable. Il permet de plus
#de représenter côte à côte deux distributions.
#-----question 4---------------------------
table(am,vs) #tableau des effectifs croisés : nbre d'individus par couple de modalités
prop.table(table(am,vs))# tableau des fréquences croisées
#-----question 5-------------------------
prop.table(table(am,vs),1)# rep. observées de vs conditionnelles à am (il y en a deux)
barplot(prop.table(table(am,vs),2),beside=T)#leurs représentations sur un même graphique
#la rep. obs. de vs pour les voitures auto (sachant am=0) est en gris foncé 
#pour les voitures manuelles en gris clair : elles sont différentes, il y a donc un lien
#entre elles.
#--------------fin exercice 3----------------------

#-------------------Exercice 4-----------------------------
#-----question 1----------------------------
cyl<-mtcars$cyl
#-----question 2----------------------------
sum(cyl) #retourne la somme
sum(cyl)/length(cyl) #moyenne empirique
sum(cyl*cyl) #somme des carrés
sum(cyl*cyl)/length(cyl) #moyenne des carrés
sum(cyl*cyl)/length(cyl)-(sum(cyl)/length(cyl))^2#variance empirique
#-----question 3----------------------------
mean(cyl) #moyenne empirique de cyl
var(cyl) #ATTENTION : variance empirique CORRIGEE : S'^2
var(cyl)*(length(cyl)-1)/length(cyl) #calcul de S^2 (varaince empirique) à partir de S'^2
sd(cyl) #ecart-type empirique corrigé S'
sd(cyl)*sqrt((length(cyl)-1)/length(cyl)) #ecart-type empirique S
quantile(cyl) #les quartiles le min et le max

#-----question 4----------------------------
mean(mpg) 
sd(mpg)
mean(mpg)/sd(mpg) #rapport signal sur bruit 
disp<-mtcars$disp #echantillon de disp
mean(disp)
sd(disp)
mean(disp)/sd(disp) #rapport signal sur bruit
#plus de dispersion relativement à la moyenne pour disp que pour mpg

#--------------fin exercice 4----------------#


#-------------------Exercice 5-----------------------------
#-----question 1----------------------------
freqtabcyl<-table(cyl)/sum(table(cyl))
freqtabcyl
sum(freqtabcyl) #1 donc ce sont bien des fréquences !
par(mfrow=c(1,2))
pie(freqtabcyl,labels=c("4","6","8"), main="répartition de nombre de cylindre")
barplot(freqtabcyl, main="répartition observée de cyl", names=c("4","6","8"),ylab="fréquences")
#-----question 2----------------------------
par(mfrow=c(1,1))
disp<-mtcars$disp
hist(disp,prob=T,main="distribution observée de disp", ylab="densité",xlab="disp")
#-----question 3----------------------------
curve(dnorm(x,m=mean(disp),sd=sd(disp)),add=T,col=2) #ajoute la densité de la loi normale
#-----question 4--------------------------
hist(mpg,prob=T,main="distribution observée de mpg", ylab="densité",xlab="mpg")
curve(dnorm(x,mean(mpg),sd(mpg)),col=2,add=T)
 #pas terrible comme adéquation !

####################################
# On peut représenter les deux graphiques dans une même fenetre pour une comparaison
# plus aisée avec   --------------------------
######################
par(mfrow=c(1,2))
#premier graphique
disp<-mtcars$disp
hist(disp,prob=T,main="distribution observée de disp", ylab="densité",xlab="disp")
curve(dnorm(x,m=mean(disp),sd=sd(disp)),add=T,col=2)
#second graphique
hist(mpg,prob=T,main="distribution observée de mpg", ylab="densité",xlab="mpg")
curve(dnorm(x,mean(mpg),sd(mpg)),col=2,add=T)
#adequation à une normale meilleur semble-t-il pour mpg que disp 

#--------------fin exercice 5----------------------

#-------------------Exercice 6-----------------------------
#-----question 1----------------------------
freqtabcyl
cumsum(freqtabcyl)
c(0,as.vector(cumsum(freqtabcyl)),1)->cumfreqcyl
cumfreqcyl
#-----question 2--------------------------- 
par(mfrow=c(1,1))
plot(c(3,4,6,8,9),cumfreqcyl,type="s",ylab="fréquences cumulées",main="FdR empirique de cyl")
#-----question 3--------------------------- 
ecdf(cyl)
plot(ecdf(cyl)) #en escalier comme elle est définie
#-----question 4-------------------------
plot(ecdf(mpg)) #en principe celle-ci devrait être représentée linéaire par morceaux


#Solution 1
cutpoints=c(10,15,20,25,30,35)
cut(mpg,breaks=cutpoints,right=T)#borne supérieure incluse right=T choix par défaut
table(cut(mpg,breaks=cutpoints))
freq_mpg<-prop.table(table(cut(mpg,breaks=cutpoints)))
freq_mpg
sum(freq_mpg)#tous les individus sont bien pris en compte
#solution 2
hist(mpg)->h
names(h)
h$breaks
h$counts #effectifs par classe 
h$density
hist(mpg,prob=T)
h_mpg<-hist(mpg,breaks=cutpoints,right=T)
freq_mpg<-h_mpg$counts/sum(h_mpg$count)
freq_mpg

#calcul des fréquences cumulées
cumfreq_mpg<-cumsum(freq_mpg)#premier élément : card(<=15)/32,....
cumfreq_mpg
plot(c(0,cutpoints,40),c(0,0,cumfreq_mpg,1),"l",xlab='mpg',ylab="frequences cumulées",main="fonction de repart. de mpg",pch=20)
abline(v=0,h=0)#axes abs et ord
#pour une lecture du quantile d'ordre 0.2
abline(h=0.2,col=3)
abline(v=quantile(mpg,prob=0.2),type=7,col=3)
help(quantile)
#
#si on veut rajouter les segments
cumfreq_mpg
cutpoints[-1]
segments(c(cutpoints[-1],40),rep(0,6),c(cutpoints[-1],40),c(cumfreq_mpg,1),col="red",lty=2)
segments(rep(0,6),c(cumfreq_mpg,1),c(cutpoints[-1],40),c(cumfreq_mpg,1),col="red",lty=2)

segments(20,0,30,0,col=3)
