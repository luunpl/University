###################################################
#------------Exercice 1-----------------------
###################################################

#--------question 1-------
data<-read.table("apnee.csv",header=T,sep=",")
#--------question 2-------
data[data$sexe==0,"taille"]->tailleH
#--------question 3-------
(muest<-mean(tailleH))#esb de la taille moyenne des hommes
(sigest<-sd(tailleH))#esb de l'ecart-type de la tailleH
#--------question 4--------
#test de HO : mu=mu0 contre H1:mu>mu0
mu0<-178
n<-length(tailleH)
(tcalc<-(mean(tailleH)-mu0)*sqrt(n)/sd(tailleH))#valeur de la statistique de test
alpha<-seq(0.01,0.1,0.01)
t<-qt(1-alpha,n-1)
tcalc>t# True si H1 acceptée
alpha[which(tcalc>t)] #niveaux pour lesquels on conclut H1
alpha[which(tcalc<t)] #niveaux pour lesquels on conclut H0
#pval comprise entre 2% et 3%
#--------question 5--------
(pval=1-pt(tcalc,n-1))
#--------question 6--------
t.test(tailleH,mu=mu0,alternative="greater")

###################################################
#------------Exercice 2-----------------------
###################################################

#--------question 1-------
#test de HO : sig=sig0 contre H1:sig != sig0
sig0<-sqrt(200)
var(tailleH)# est de sigma2 < sig02 on compare donc à zalpha/2
(tcalc<-(n-1)*var(tailleH)/(sig0^2)) 
alpha<-seq(0.01,0.9,0.01)
(z1<-qchisq(alpha/2,n-1))
(z2<-qchisq(1-alpha/2,n-1))
tcalc>z2|tcalc<z1 #si TRUE on rejette H0, donc ici à partir de alpha compris
#entre  72% et 73% on vailde H1. pvaleur appartient à [0.72;0.73]

#--------question 2-------
#comme tcalc < n-1 la pvaleur est P(T<tcalc)*2
pchisq(tcalc,n-1)*2 #calcul exact de la p-valeur

###################################################
#------------Exercice 3-----------------------
###################################################

#--------question 1-------
x<-as.numeric(data$taille>180)#echantillon de la loi bernoulli(p) X=1 si taille>180
sum(x)#nombre de succès
length(x)#nombre d'essais
pest<-sum(x)/length(x)#estimation de p qui peut aussi s'obtenir avec 
mean(x)
#--------question 2-------
#test de HO : p=p0 contre H1:p diff p0
p0<-0.15
prop.test(sum(x),length(x),p=p0,alternative="two.sided",conf.level=0.9,correct=F)
