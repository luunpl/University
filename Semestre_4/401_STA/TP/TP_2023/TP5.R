###################################################
#------------Exercice 1------------------------
###################################################

#--------question 1------------
(n<-100)
(p<-0.45)
(x<-rbinom(n,1,p))
#--------question 2------------
cumsum(x)
(taille<-1:n)
(suitemoy<-cumsum(x)/taille)
#--------question 3------------
plot(suitemoy,type="l")
abline(h=p,col="red")




###################################################
#------------Exercice 2------------------------
###################################################

#--------question 1------------
(n<-100)
(mu<--2)
(sigma<-2)
rm(xg)
(xg<-rnorm(n,mu,sigma))
#--------question 2------------
cumsum(xg)
rm(taille)
(taille<-1:n)
rm(suitemoyg)
suitemoyg
(suitemoyg<-cumsum(xg)/taille)
#--------question 3------------
plot(suitemoyg,type="l", ylim=c(-10,6))
abline(h=mu,col="red")







###################################################
#------------Exercice 3------------------------
###################################################

#---------question 1--------------------------
mu<--2
sigma<-2
n<-5
rm(x) #efface l'objet précedemment créé x
(x<-rnorm(n,mu,sigma))# echantillon de n tirages de X
(moyx<-mean(x))#moyenne de l'échantillon de taille n x

#---------question 2--------------------------
(y<-rnorm(n,mu,sigma))# second echantillon de n tirages de X
(moyy<-mean(y)) #moyenne de l'échantillon y
(rbind(x,y)->M) #range les deux échantillons dans M à 2 lignes et n colonnes
rowMeans(M)

#---------question 3--------------------------
N<-1000
Mdata<-matrix(rnorm(n*N,mu,sigma),ncol=n,byrow=T)# N échantillons de taille n disposés en lignes
dim(Mdata) #dimension de la matrice N lignes et n colonnes


#---------question 4--------------------------
(rowMeans(Mdata)->moyennes) #calcule les moyennes pour les N, n-échantillons tirés.
apply(Mdata,MARGIN=1,mean) #alternative pour effectuer les moyennes en ligne

#---------question 5--------------------------
mean(moyennes) #moyenne empirique des N réalisations de Xbar_n
sd(moyennes)*sqrt((length(moyennes)-1)/length(moyennes))#ecart-type empirique
sd(moyennes)#écart-type estimé sans biais = ecart-type empirique corrigé

#---------question 6--------------------------
hist(moyennes,prob=T, main="Répartition de la moyenne empirique des Xi, i=1,....,n")#la répartition observée de Xbar_n
(abs<-seq(1.2*min(moyennes),1.2*max(moyennes),(max(moyennes)-min(moyennes))/100))
points(abs,dnorm(abs,mu,sigma/sqrt(n)),col=2,type="l")
abline(v=mean(moyennes),col=3,lty="dashed")#moyenne de l'échantillon
abline(v=mu,col=2)#moyenne théorique mu de la loi de Xbar
#belle adéquation de l'échantillon à la normale, que l'on peut verifier avec dte de Henry
qqnorm(moyennes) #les points sont presque alignés la loi de Xbar_n est donc bien normale
qqline(moyennes,col=2) # autour de la droite rouge qui passe par les deux points
# (1er quartile theo de la centrée réduite,1er quartile empirique) et
# (3ieme quartile theo de la centrée réduite,3ieme quartile empirique)
# mean(echantillon) et écart-type empirique sd(échantillon)*sqrt((n-1)/n). e
# En effet si on ajoute la droite passant par ces deux points elle se confond
# avec qqline. droite de Henry

(x1<-qnorm(0.25))
(x2<-qnorm(0.75))
(y1<-quantile(moyennes,0.25,type=1))
(y2<-quantile(moyennes,0.75,type=1))
abline(y1-(y2-y1)*x1/(x2-x1),(y2-y1)/(x2-x1),col=3) #droite de Henry

#----------question 7-------------------------
moyennecr<-sqrt(n)*(moyennes-mu)/sigma
hist(moyennecr,prob=T,main="Répartition observée de la moyenne empirique centrée réduite")
(abscr<-seq(1.2*min(moyennecr),1.2*max(moyennecr),(max(moyennecr)-min(moyennecr))/100))
points(abscr,dnorm(abscr),col=2,type="l")
abline(v=mean(moyennecr),col=3,lty="dashed")#moyenne empirique de l'échantillon
abline(v=0,col=2)#moyenne théorique  de la loi normale centrée réduite

qqnorm(moyennecr)
qqline(moyennecr)#droite de Henry

#-----------question 8------------
n<-50
#puis réexecuter les lignes 67 à 107 : la loi reste gaussienne mais
#l'écart-type de Xbarn est plus petit avec n=50 qu'avec n=2
sd(moyennes)
sigma/sqrt(n)

n<-2
#puis réexecuter les lignes 67 à 107 : LA LOI EST TOUJOURS GAUSSIENNE MEME AVEC n PETIT
#C'EST UNE PROPRIETES CARACTÉRISTIQUE DE LA LOI NORMALE MAIS QUI NE S'APPLIQUE PAS AUX AUTRES
#LOIS COMME PAR EX A LA BERNOULLI ==> VOIR EXO SUIVANT
sd(moyennes)
#l'écart type empirique est EN REVANCHE plus faible avec n=2 qu'avec n=50 :
#normal il estime sigma/sqrt(n) or :
sigma/sqrt(n)

#####################################################################################
# CE QU'IL FAUT RETENIR DE CET EXERCICE : LA LOI DE XBAR EST GAUSSIENNE SI L'ÉCHANTILLON EST
# GAUSSIEN ET DE TAILLE QUELCONQUE n. LE RESULTAT DU THEOREME CENTRAL LIMITE EST VRAI DANS CE CAS
# POUR TOUT n ET PAS SEULEMENT POUR n GRAND
###################################################################################

###################################################
#------------Exercice 4------------------------
###################################################

#---------question 1--------------------------
p<-0.45
n<-5
N<-100
rm(Mdata) #efface l'objet précedemment créé Mdata

Mdata<-matrix(rbinom(n*N,1,p),ncol=n,byrow=T)# N échantillons de taille n disposés en lignes
dim(Mdata) #dimension de la matrice N lignes et n colonnes

(rowMeans(Mdata)->moyennes) #calcule les moyennes pour les N, n-échantillons tirés.


mean(moyennes) #moyenne empirique des N réalisations de Xbar_n
sd(moyennes)*sqrt((length(moyennes)-1)/length(moyennes))#ecart-type empirique
sd(moyennes)#écart-type estimé sans biais = ecart-type empirique corrigé

#---------histogramme de xbar_n--------------------------
hist(moyennes,prob=T, ylim=c(0,max(dnorm(p,p,sqrt(p*(1-p)/n)),4)),main="Répartition de la moyenne empirique des Xi, i=1,....,n")#la répartition observée de Xbar_n
(abs<-seq(.8*min(moyennes),1.2*max(moyennes),(max(moyennes)-min(moyennes))/100))
points(abs,dnorm(abs,p,sqrt(p*(1-p)/n)),col=2,type="l")
abline(v=mean(moyennes),col=3,lty="dashed")#moyenne de l'échantillon
abline(v=p,col=2)#moyenne théorique mu de la loi de Xbar
qqnorm(moyennes)  # vraiment pas gaussien !
qqline(moyennes,col=2)
# AUCUNE ADEQUATION  de l'échantillon à la normale CAR n EST TROP PETIT ET LE TCL N'EST
# PAS VERIFIE. ON REFAIT LA SIMUL AVEC n=200 :

n<-200
#puis réeéxuter les lignes 142 à 161

# EUREKA CA MARCHE BEAUCOUP MIEUX ET ON A BIEN UNE REPARTITION GAUSSIENNE CAR n EST SUFFISAMMENT GRAND POUR
# QUE LE TCL SOIT VERIFIE !
######################################

qqnorm(moyennes)
qqline(moyennes,col="red")

#Si on augmente N on améliore l'estimation de la densité de Xbarn par l'histogramme
#des N réalisations de Xbarn mais si n est petit on n'observe pas un histogramme 
#ressemblant à une gaussienne puisque le TCL ne s'applique que si n est assez grand.
#Essayer avec
N<-1000
n<-4
#puis lignes 142 à 159. 
N<-1000
n<-100
#puis lignes 142 à 159. 

