###################################################
#------------Exercice 1-----------------------
###################################################

#--------question 1-------
(mu<-2)
(sig<-1)
(N<-1000)
(n<-50)
dataG<-matrix(rnorm(n*N,mu,sig),ncol=n)#tire N échantillon de taille n=50 d'une N(mu,sig)
#--------question 2--------
#test de HO : mu=mu0 contre H1:mu>mu0
mu0<-2
#--------question 3--------
rowMeans(dataG)->moy #N réalisatiuon de muest=xbarn
#test 1: si xbarn>mu0 ==> rejet de H0
mean(moy>mu0)#evalue son risque de première espéce : refus de H0 alors qu'elle est vraie
#test 2: si xbarn>mu0 + 2/racine(n)==> rejet de H0
mean(moy>mu0+2/sqrt(n))#evalue le risque de première espéce du test 2
#test 3: si xbarn>mu0 + 3/racine(n)==> rejet de H0
mean(moy>mu0+3/sqrt(n))#evalue le risque de première espéce du test 3
#---------question 4-----------
alpha<-0.05
u<-qnorm(1-alpha)
#test 4: si xbarn>mu0+u*sig/sqrt(n) : ets en principe de niveau alpha en effet
mean(moy>mu0+u/sqrt(n))#evalue le  niveau du test 4 qui est bien d'environ alpha
#----------question 5------------
#la statistique de test est tcalc=(xbarn_mu0)*sqrt(n)/sig et on la compare à u
tcalc<-(moy-mu0)*sqrt(n)/sig #les N réalistaions de tcalc
mean(tcalc>u)==mean(moy>mu0+u/sqrt(n))#c'est pareil d'exprimer le test sur muest ou sur tcalc
#A PRESENT ON UTILISERA TOUJOURS LA STAT DE TEST CENTREÉ ET RENORMALISÉE SOUS HO C. A. D : T

