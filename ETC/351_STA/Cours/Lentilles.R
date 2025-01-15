read.table("EchLentilles.csv",header=T,sep=",",dec=",")->lentilles
head(lentilles)
boxplot(FreqObsVert~NumSac,data=lentilles,xaxt="n",
        xlab="Couples (n,N) par Sac",
        main="Boites de distribution de la moyenne empirique selon le sac",
        col=c(6,4,rep(6,4),5,6),lty=c(rep(1,4),2,rep(1,3)))
        axis(1,at=1:8,labels=c("(25,10)","(25,15)",rep("(25,10)",2),"(50,10)","(25,10)","(25,20)","(25,10)"))
abline(h=0.5,col=2)
abline(h=0.6,col=3)
table(lentilles$NumSac)
lentilles$TailleEch
attach(lentilles)
binf<-FreqObsVert-sqrt(FreqObsVert*(1-FreqObsVert)/TailleEch)*qnorm(0.9)
bsup<-FreqObsVert+sqrt(FreqObsVert*(1-FreqObsVert)/TailleEch)*qnorm(0.9)

plot(FreqObsVert,pch=20,col=2,ylim=c(0.2,0.8), ylab="Estimation par intervalle de p",
     main="Intervalles de confiance de niveau 80% pour p proportion de vertes", 
xlab="Echantillons selon les sacs où les sacs 3 et 7 sont en vert")
segments(1:length(FreqObsVert),binf,1:length(FreqObsVert),bsup,col=c(NumSac[1:65],rep(3,20),NumSac[86:95]+1))
abline(h=0.5,lty=2)
abline(h=0.6,lty=2,col=3)
abline(h=0.55)
abline(h=0.58)
abline(h=0.52)
p0<-0.5
p1<-0.6
hist(FreqObsVert[-c(26:35,46:55,66:85)],prob=T,
     breaks=c(0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7),
     main="Répartition observée des moyennes d'échantillons tirés dans les sacs où p=0.5",
     xlab="estimations de p pour les sacs où p=0.5")
abline(v=mean(FreqObsVert[-c(26:35,46:55,66:85)]),col=1)
abline(v=0.5,col=3)
abline(v=0.52,col=4,lty=2)
abline(v=0.55,col=3,lty=2)
abline(v=0.58,col=5,lty=2)
curve(dnorm(x,p0,sqrt(p0*(1-p0)/25)),from=0.2,to=0.7,n=200,col=3,add=T)
curve(dnorm(x,p1,sqrt(p1*(1-p1)/25)),from=0.2,to=0.7,n=200,col=2,add=T)
abline(v=p1,col=2)
legend(0.601,4.2,lty=c(1,1,2,2,2),col=c(3,2,4,3,5),c("loi théo. si p=0.5","loi théo. si p=0.6","règle>0.52","règle>0.55","règle>0.58"),cex=0.7,bg="grey")


#pour obtenir graph Testp0p1Equilib
####################################

curve(dnorm(x,p0,sqrt(p0*(1-p0)/25)),from=0.2,to=0.9,n=200,col=3,
      main="Modéle de Bernoulli B(p) : lois de la moy emp pour deux valeurs de p et règle
      de décision équilibrée entre p=0.5 et p=0.6 ",ylab="densité de la loi de la moy. emp. ")
curve(dnorm(x,p1,sqrt(p1*(1-p1)/25)),from=0.2,to=0.9,n=200,col=2,add=T)
segments(0.55,0,0.55,dnorm(0.55,p0,sqrt(p0*(1-p0)/25)),col=3)
segments(0.55,0,0.9,dnorm(0.9,p0,sqrt(p0*(1-p0)/25)),col=3)
polygon(c(seq(0.55,0.9,0.001),0.55,0.55),
        c(dnorm(seq(0.55,0.9,0.001),p0,sqrt(p0*(1-p0)/25)),0,dnorm(0.55,p0,sqrt(p0*(1-p0)/25))),
        col=3,border=3)
legend(0.51,1,"P(H1|H0)=0.31",cex=1,bty="n",bg="n")
abline(v=0.55,col=1)
abline(v=0.5,col=3)
abline(v=0.6,col=2)
abline(h=0)
polygon(c(0.2,0.55,seq(0.55,0.2,-0.001)),c(0,0,dnorm(seq(0.55,0.2,-0.001),p1,sqrt(p1*(1-p1)/25))),col=2,lty=3)
legend(0.4,1,"P(H0|H1)=0.31",cex=1,bty="n",bg="n")
points(rep(0.55,3),c(-0.07,0,0.07),pch=23)
points(seq(0.555,0.9,0.005),rep(0,length(seq(0.555,0.9,0.005))),pch=18)
legend(0.75,3,c("p=0.5","p=0.6","rejet de p=0.5"), col=c(3,2,1),lty=c(1,1,1),pch=c(20,20,18))


1-pnorm(0.55,p0,sqrt(p0*(1-p0)/25))
pnorm(0.55,p1,sqrt(p1*(1-p1)/25))
alpha<-seq(0.1,0.50,0.1)
#calpha de l'unilateral sup
p0+sqrt(p0*(1-p0)/25)*qnorm(1-alpha)

#pour obtenir graph Testp0p1Favp0
####################################

curve(dnorm(x,p0,sqrt(p0*(1-p0)/25)),from=0.2,to=0.9,n=200,col=3,
      main="Modéle de Bernoulli B(p) : lois de la moy emp pour deux valeurs de p et règle
      de décision favorisant p=0.5 contre p=0.6 ",ylab="densité de la loi de la moy. emp. ")
curve(dnorm(x,p1,sqrt(p1*(1-p1)/25)),from=0.2,to=0.9,n=200,col=2,add=T)
segments(0.58,0,0.58,dnorm(0.58,p0,sqrt(p0*(1-p0)/25)),col=3)
segments(0.58,0,0.9,dnorm(0.9,p0,sqrt(p0*(1-p0)/25)),col=3)
polygon(c(seq(0.58,0.9,0.001),0.58,0.58),
        c(dnorm(seq(0.58,0.9,0.001),p0,sqrt(p0*(1-p0)/25)),0,dnorm(0.58,p0,sqrt(p0*(1-p0)/25))),
        col=3,border=3)
legend(0.54,1,"P(H1|H0)=0.21",cex=1,bty="n",bg="n")

abline(h=0)
polygon(c(0.2,0.58,seq(0.58,0.2,-0.001)),c(0,0,dnorm(seq(0.58,0.2,-0.001),p1,sqrt(p1*(1-p1)/25))),col=2,lty=3)
legend(0.37,1,"P(H0|H1)=0.41",cex=1,bty="n",bg="n")
points(rep(0.58,3),c(-0.07,0,0.07),pch=23)
points(seq(0.585,0.9,0.005),rep(0,length(seq(0.585,0.9,0.005))),pch=18)
legend(0.75,3,c("p=0.5","p=0.6","rejet de p=0.5"), col=c(3,2,1),lty=c(1,1,1),pch=c(20,20,18))
abline(v=0.5,col=3)
abline(v=0.6,col=2)

1-pnorm(0.58,p0,sqrt(p0*(1-p0)/25))
pnorm(0.58,p1,sqrt(p1*(1-p1)/25))

#Graphes avec les deux régles
##############################

par(mfrow=c(2,1))

curve(dnorm(x,p0,sqrt(p0*(1-p0)/25)),from=0.2,to=0.9,n=200,col=3,
      main="Modéle de Bernoulli B(p) : lois de la moy emp pour deux valeurs de p et règle
      de décision équilibrée entre p=0.5 (vert) et p=0.6 (rouge) ",ylab="densité de la loi de la moy. emp. ")
curve(dnorm(x,p1,sqrt(p1*(1-p1)/25)),from=0.2,to=0.9,n=200,col=2,add=T)
segments(0.55,0,0.55,dnorm(0.55,p0,sqrt(p0*(1-p0)/25)),col=3)
segments(0.55,0,0.9,dnorm(0.9,p0,sqrt(p0*(1-p0)/25)),col=3)
polygon(c(seq(0.55,0.9,0.001),0.55,0.55),
        c(dnorm(seq(0.55,0.9,0.001),p0,sqrt(p0*(1-p0)/25)),0,dnorm(0.55,p0,sqrt(p0*(1-p0)/25))),
        col=3,border=3)
#legend(0.51,1,"P(H1|H0)=0.31",cex=1,bty="n",bg="n",cex=0.5)
abline(v=0.55,col=1)
abline(v=0.5,col=3)
abline(v=0.6,col=2)
abline(h=0)
polygon(c(0.2,0.55,seq(0.55,0.2,-0.001)),c(0,0,dnorm(seq(0.55,0.2,-0.001),p1,sqrt(p1*(1-p1)/25))),col=2,lty=3)
#legend(0.4,1,"P(H0|H1)=0.31",cex=1,bty="n",bg="n",cex=0.5)
points(rep(0.55,3),c(-0.07,0,0.07),pch=23)
points(seq(0.555,0.9,0.005),rep(0,length(seq(0.555,0.9,0.005))),pch=18)
#legend(0.75,3,c("p=0.5","p=0.6","rejet de p=0.5"), col=c(3,2,1),lty=c(1,1,1),pch=c(20,20,18))

curve(dnorm(x,p0,sqrt(p0*(1-p0)/25)),from=0.2,to=0.9,n=200,col=3,
      main="Modéle de Bernoulli B(p) : lois de la moy emp pour deux valeurs de p et règle
      de décision favorisant p=0.5 (vert) contre p=0.6 (rouge)",ylab="densité de la loi de la moy. emp. ")
curve(dnorm(x,p1,sqrt(p1*(1-p1)/25)),from=0.2,to=0.9,n=200,col=2,add=T)
segments(0.58,0,0.58,dnorm(0.58,p0,sqrt(p0*(1-p0)/25)),col=3)
segments(0.58,0,0.9,dnorm(0.9,p0,sqrt(p0*(1-p0)/25)),col=3)
polygon(c(seq(0.58,0.9,0.001),0.58,0.58),
        c(dnorm(seq(0.58,0.9,0.001),p0,sqrt(p0*(1-p0)/25)),0,dnorm(0.58,p0,sqrt(p0*(1-p0)/25))),
        col=3,border=3)
#legend(0.54,1,"P(H1|H0)=0.21",cex=0.5,bty="n",bg="n")

abline(h=0)
polygon(c(0.2,0.58,seq(0.58,0.2,-0.001)),c(0,0,dnorm(seq(0.58,0.2,-0.001),p1,sqrt(p1*(1-p1)/25))),col=2,lty=3)
#legend(0.37,1,"P(H0|H1)=0.41",cex=0.5,bty="n",bg="n")
points(rep(0.58,3),c(-0.07,0,0.07),pch=23)
points(seq(0.585,0.9,0.005),rep(0,length(seq(0.585,0.9,0.005))),pch=18)
#legend(0.8,4,c("p=0.5","p=0.6","rejet de p=0.5"),cex=1, col=c(3,2,1),lty=c(1,1,1),pch=c(20,20,18))
abline(v=0.5,col=3)
abline(v=0.6,col=2)