#----------------------------------------------------------------------
#                         TP8
#----------------------------------------------------------------------

#----------------------------------------------------------------------
#                        Exercise 1
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
mu <- -1; sig <- 0.3                          # moyenne et ecart-type
# L'hypothese dangereuse qu'on ne veut pas rejeter avec erreur est que le patient n'est pas à risque.
# Le patient n'est pas à risque si sa moyenne est egale a -1. On pose donc
# H0: "mu = -1" contre H1: "mu > -1"
# c'est un test unilateral a droite
#----------------------- question 2 -----------------------------------
# regle de decision : rejeter H0 si plus grande que
qnorm(0.95,mu,sig)
qnorm(0.99,mu,sig)
#----------------------- question 3 -----------------------------------
# -0.46 est plus grand que le seuil à 5%, il est considéré à risque pour ce seuil
# -0.46 est plus petit que le seuil à 1%, il n'est pas considéré à risque pour ce seuil
1-pnorm(-0.46,mu,sig)                          # p-valeur
#----------------------- question 4 -----------------------------------
# L'hypothèse dangereuse pour Dr Cuddy est de rejeter avec erreur le fait que le patient soit à risque.
# L'hypothèse nulle H0 est "le patient est à risque"
# H0: "mu = 0" contre H1: "mu < 0"
# c'est un test unilateral a gauche
#----------------------- question 5 -----------------------------------
qnorm(0.05,mean=0,sd=0.3)
qnorm(0.01,mean=0,sd=0.3)




#----------------------------------------------------------------------
# Exercice 2
#----------------------------------------------------------------------
#----------------------- question 1 -----------------------------------
mu <- 150; sig <- 5                         # moyenne et ecart-type
# H0: "mu = 150" contre H1: "mu < 150"
# c'est un test unilateral a gauche
# regle de decision : rejeter H0 si (concentration-mu)/sig est plus petit que
qnorm(0.05)
# Dans R, on peut calculer directement le seuil. On rejette HO si la concentration est plus petite que
qnorm(0.05,mu,sig)                          # au seuil 5%
#----------------------- question 2 -----------------------------------
# 140 < 141.77 : on rejette HO
pnorm(140,mu,sig)                           # p-valeur
# p-value=0.023<0.05, H0 est rejetee, le patient n'est pas a risque
 
#----------------------------------------------------------------------
# Exercice 3
#----------------------------------------------------------------------

#----------------------- question 1 -----------------------------------
mu <- 1000; sig <- 20                       # moyenne et ecart-type
# H0: "mu = 1000" contre H1: "mu different de 1000"
# regle de decision: on rejette H0 si le poids est trop grand ou trop petit, et en dehors des seuils suivants:
qnorm(c(0.025,0.975),mu,sig)                # au risque 5%
qnorm(c(0.005,0.995),mu,sig)                # au risque 1%
#----------------------- question 2 -----------------------------------
# H0: "mu = 1000" contre H1: "mu > 1000"
# regle de decision: on rejette H0 si le poids est plus grand que
qnorm(0.95,mu,sig)                          # au risque 5%
qnorm(0.99,mu,sig)                          # au risque 1%
#----------------------- question 3 -----------------------------------
# 960 < 1018 < 1039 : on ne rejette pas HO, le paquet n'est pas différent de 1kg
# 1018 < 1032 : on ne rejette pas HO, le paquet n'est pas plus grand que 1kg
pnorm(1018,mu,sig,lower.tail=FALSE)         # p-valeur
#----------------------- question 4 -----------------------------------
# H0: "mu = 1000" contre H1: "mu < 1000"
# regle de decision: on rejette H0 si le poids est plus petit que
qnorm(0.05,mu,sig)                          # au risque 5%
qnorm(0.01,mu,sig)                          # au risque 1%
#----------------------- question 5 -----------------------------------
# 982 > 967 : on ne rejette pas HO, le paquet n'est pas plus petit que 1kg
pnorm(982,mu,sig)                           # p-valeur

 
#----------------------------------------------------------------------
# Exercice 4
#----------------------------------------------------------------------

#----------------------- question 1 -----------------------------------
mu <- 30; sig <- 4                          # moyenne et ecart-type
# H0: "mu = 30" contre H1: "mu > 30"
# regle de decision: on rejette H0 si la concentration est plus grande
qnorm(0.95,mu,sig)                          # au risque 5%
qnorm(0.99,mu,sig)                          # au risque 1%

#----------------------- question 2 -----------------------------------
# H0: "mu = 30" contre H1: "mu < 30"
# regle de decision: on rejette H0 si la concentration est plus petite que  
qnorm(0.05,mu,sig)                          # au risque 5%
qnorm(0.01,mu,sig)                          # au risque 1%


