
#--------chargement des données après selection du répertoire les contenant-------
#####################################################################################
data<-read.table("her.csv",header=T,sep=" ")
read.table("her.txt",header=T,sep="\t")
data
names(data)
###################################################
#------------Exercice 1-----------------------
###################################################


#--------question 1-------
data$sys->sys #echantillon des pressions systoliques
data$dia->dia #echantillon des pressions diatoliques
diff<-sys-dia #echantillon des différences
#--------question 2-------
qqnorm(diff)
abline(mean(diff),sd(diff),col=2)# à part les extremes assez gaussien quoiqu'il en soit comme n est grand
#---------question 3------
t.test(diff) #intervalle de conf à 95% 
#--------question 4-------
#H0 : mudia-musys=0 H1 mudia diff musys : comparaison de moyenne pour echantillons appariés
# équivaut au test : H0: mudiff=0 contre H1: mudiff diff 0

#à la main 
(tcalc<-(mean(diff)*sqrt(length(diff))/sd(diff)))#statistique du test
length(diff)->n
2*(1-pt(abs(tcalc),n-1))#pval tres petite...
#--------question 5-----------
t.test(diff,mu=0) #moyenne pression sys différent de moyenne dia
t.test(sys,dia,paired=T,mu=0)#resultat analogue
#--------question 6-----------
mu0<-40
t.test(diff,mu=mu0) #moyenne pression sys différent de moyenne dia
t.test(sys,dia,paired=T,mu=mu0,alternative="greater")#resultat analogue

###################################################
#------------Exercice 2-----------------------
###################################################

#--------question 1-------
data[data$sex==0,"sys"]->sysH
data[data$sex==1,"sys"]->sysF
(length(sysH)->nH)
moyest.sysH<-mean(sysH)
(length(sysF)->nF)
moyest.sysF<-mean(sysF)
par(mfrow=c(1,1))
boxplot(sysF,sysH) #suggère qu'en moyenne sys un peu plus élévée chez les hommes que chez les femmes
#--------question 2-------
# muF:moyenne pression systolique chez les femmes
# muH : moyenne pression systolique chez les hommes
# On veut tester : H0:muF=muH contre H1 :muF différent de muH pour juger de l'effet sexe
# et H0:muF=muH contre H1 :muF < muH : pour montrer qu'elle est en moyenne supérieure
#chez les hommes. Il faut s'assurer de la normalité et l'indépendance des deux variables.
#il faut également savoir si les variances des deux variables sont supposées ou non égales
#--------question 3-----
par(mfrow=c(1,2))
qqnorm(sysF)
abline(mean(sysF),sd(sysF),col=2)#2 indiv extr. (avec sys>140) s'écartent de la "gaussianité"
qqnorm(sysH)
abline(mean(sysH),sd(sysH),col=2)#un indiv extrême (avec sys>140) 
#on pourrait voir ce qui change lorsque l'on écarte ces trois individus
#--------question 4-------
sysF[-which(sysF>140)]->sysFR
sysH[-which(sysH>140)]->sysHR
par(mfrow=c(1,2))
qqnorm(sysFR)
abline(mean(sysFR),sd(sysFR),col=2)# bien gaussien
qqnorm(sysHR)
abline(mean(sysHR),sd(sysHR),col=2)# bien gaussien

#--------question 5---------
#test de comparaison des variances avec les echantillons complets
var(sysF)
var(sysH)
(tcalc=var(sysF)/var(sysH))#statistique de test
2*(1-pf(tcalc,df1=length(sysF)-1,df2=length(sysH)-1))

#--------question 6--------------
var.test(sysF,sysH) #on ne peut supposer l'égalité des variances si on garde les
# echantillons complets mais heureusement
# les echantillons sont assez grands pour pouvoir se passer de cette hypothèse.
var.test(sysFR,sysHR) # sans les indiv extremes on supposera l'egalité des variances


#--------question 7--------
#test de H0:muF=muH contre H1 :muF < muH  avec les échantillons complets à variances différentes
t.test(sysF,sysH,alternative="less", paired=F,var.equal=F) #on conclut H1 avec une pval assez faible
#la moyenne est signific plus basse chez les femmes que chez les hommes

#-------question 8-----------
#avec les échantillons réduits et les variances égales
t.test(sysFR,sysHR,alternative="less", paired=F,var.equal=T)
#l'effet sexe est encore plus significatif car la p val est plus petite



###################################################
#------------Exercice 3-----------------------
###################################################
boxplot(data$chol)
mean(data$chol>350)
data[data$sex==0,"chol"]->cholH
data[data$sex==1,"chol"]->cholF
#--------question 1-------
par(mfrow=c(1,1))
boxplot(cholH,cholF) #beaucoup plus de dispersion dans les grandes valeurs chez les hommes que chez
#les femmes
#--------question 2---------
# H0 : p_H=p_F H1: p_H différente de p_F
#--------question 3---------
prop.test(c(sum(cholH>350),sum(cholF>350)),c(length(cholH),length(cholF)))
#au niveau alpha =5% on concluera H1

