###################################################
#------------Exercice 1-----------------------
###################################################

#--------question 1-------
(p<-0.3)
(n<-500)
(x<-rbinom(n,1,p))#tire un échantillon de taille n=500 d'une B(p)
mean(x)
#--------question 2--------
(moy.taille<-cumsum(x)/(1:n))
mean(moy.taille)
# pour k=1....n, calc en posit. $k$ la moy des $k$ prem. vals de x
#--------question 3--------
alpha<-0.05
(u<-qnorm(1-alpha/2))
Binf.taille<-moy.taille-u*sqrt(moy.taille*(1-moy.taille))/sqrt((1:n)) #bornes inférieures pour chaque $k$
Bsup.taille<-moy.taille+u*sqrt(moy.taille*(1-moy.taille))/sqrt((1:n)) #bornes sups
mean((Binf.taille<=p)&(p<=Bsup.taille))
#--------question 4----------
amplitude.taille<-Bsup.taille-Binf.taille
plot((1:n),amplitude.taille,type="l")#en abs. la taille de l'échan.et en ord. longeur de l'IC

#ATTENTION L'IC EST JUSTE POUR TAILLE SUFFISANTE
#si on veut représenter à partir d'une taille suffisante pour laquelle l'IC est juste
#soit pour K tel que nk>10 et k(1-p)>10 il faut prendre une taille supérieure à 34,
plot((34:n),amplitude.taille[34:n],type="l")
abline(h=0.1,col=2) #on lit la taille minimum cherchée
#on doit prendre environ 320 valeurs pour garantir une amplitude de 0.1

#FACULTATIF : POUR CALCULER NUMERIQUEMENT CETTE TAILLE OPTIMALE :
#calcul de cette valeur minimale) on va chercher pour quel indice dans amplitude.taille[34:n]
#on obtient une valeur <=0.1
which(amplitude.taille[34:n]<0.1) #les positions dans les amplitudes (à partir de taille 34)
#tailles pour lesquels |IC| inférieure à 0.1
(nopt<-min(which(amplitude.taille[34:n]<0.1))+34-1)#la taille minimum cherchée de l'ordre de 300
amplitude.taille[(nopt-3):(nopt+3)]

#--------------question 5--------------
moy.taille[n]==mean(x)
(Binfx<-Binf.taille[n]) #dernière borne inf calculée dans Binf au niveau alpha
(Binfx<-mean(x)-u*sqrt(mean(x)*(1-mean(x))/n))
(Bsupx<-Bsup.taille[n]) #dernière borne sup calculée dans Binf au niveau alpha
prop.test(sum(x),length(x)) #retourne l'IC de niveau 95% par défaut
prop.test(sum(x),length(x),conf.level=0.9) #retourne l'IC de niveau 90% 

#-------------question 6-----------------
(alpha<-seq(0.01,0.3,0.01))
(u<-qnorm(1-alpha/2))
(Binf.niveau<-mean(x)-u*sqrt(mean(x)*(1-mean(x))/n))
(Bsup.niveau<-mean(x)+u*sqrt(mean(x)*(1-mean(x))/n))
(amplitude.niveau<-Bsup.niveau-Binf.niveau)

#--------------question 7-----------------
plot(alpha,amplitude.niveau,type="l")
abline(h=0.1)

#--------------question 8-------------
alphaopt<-2*(1-pnorm(0.05*sqrt(n/(mean(x)*(1-mean(x))))))
abline(v=alphaopt,col=2) #les deux droites se croisent bien à l'amplitude 0.1



###################################################
#------------Exercice 2------------------------
###################################################

#-----------question 1--------------------------
read.table("apnee.csv",sep=",",header=T)->data
head(data)
#-----------question 2---------------------
(data[data$sexe==0,"poids"]->poidsH)
#-----------question 3--------------------
qqnorm(poidsH)#le quantile-quantile plot pour tester la loi normale
abline(mean(poidsH),sd(poidsH),col=2)#la droite de Henry
qqline(poidsH)
hist(poidsH)
#OK à part pour les six individus les plus lourds en haut à droite
boxplot(poidsH)
#-----------question 4-----------------------
#même si la répartition n'est pas parfaitement gaussienne pas grave car n=75 est grand
#dans ce cas le TCL garantit les résultats même si la loi n'est pas gaussienne
(muest<-mean(poidsH))
(sigest<-sd(poidsH))
#-----------question 5--------------------
(n<-length(poidsH))
alpha<-0.05
u<-qnorm(1-alpha/2)
(Binf<-mean(poidsH)-u*19/sqrt(n))#borme inf avec sigma connu
(Bsup<-mean(poidsH)+u*19/sqrt(n))#borne sup avec sigma connu
#----------question 6---------------------
t<-qt(1-alpha/2,n-1)
(Binf<-mean(poidsH)-t*sd(poidsH)/sqrt(n))#borme inf avec sigma inconnu
(Bsup<-mean(poidsH)+t*sd(poidsH)/sqrt(n))#borne sup avec sigma inconnu
t.test(poidsH)
#----------question 7---------------------
t.test(poidsH,conf.level=0.99)
#----------question 8---------------------
alpha<-0.1
z1<-qchisq(1-alpha/2,n-1)#quantile d'ordre 1-alpha/2 du Chideux et utile pour la borne inf
z2<-qchisq(alpha/2,n-1)#quantile d'ordre alpha/2 du Chideux et utile pour la borne sup
(Binf<-var(poidsH)*(n-1)/z1)
(Bsup<-var(poidsH)*(n-1)/z2)
#----------question 9-----------------------
#n étant grand d'après le TCL tous les resultats valable pour le modèle gaussien
#s'applique pour un modèle non gaussien.

###################################################
#------------Exercice 3---------------------
###################################################


#--------question 1------------
#p1 : probab d'apnee si fumeur
#p2 : proba d'apne si non fumeur
#--------question 2-------------
(apnee.fumeurs<-data[data$tabac==1,"apnee"])
(apnee.non.fumeurs<-data[data$tabac==0,"apnee"])
(p1est<-mean(apnee.fumeurs))#estimation de p1
(p2est<-mean(apnee.non.fumeurs))#estiamtion de p2

#----------question 3---------------
prop.test(sum(apnee.fumeurs),length(apnee.fumeurs),conf.level=0.9) # on lit l'IC pour p1
#[0.22,0.42]
prop.test(sum(apnee.non.fumeurs),length(apnee.non.fumeurs),conf.level=0.9)#on lit l'IC pour p2
#[0.28,0.57]

#ils ont grande partie commune ce qui pourrait laisser penser que p1=p2 
# il faudra le verifier par un test de comp de prop. 

p1est-qnorm(1-0.025)*sqrt(p1est*(1-p1est)/length(apnee.fumeurs))
p1est+qnorm(1-0.025)*sqrt(p1est*(1-p1est)/length(apnee.fumeurs))


