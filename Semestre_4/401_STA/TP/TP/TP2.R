#-------------Exercice 1-------------------------------------
help(mtcars)
mtcars
names(mtcars)
head(mtcars)

cyl <- mtcars$cyl
am <- mtcars$am
mtcars$mpg
disp <- mtcars$disp
# Qualiquative : vs, am
# Quantitative : disp, wt

help(summary) # Summary va donner min max mean median ...
max(disp)
summary(disp)

#-------------Exercice 2-------------------------------------
mtcars$mpg->mpg

boxplot(mpg)
boxplot(disp)
boxplot(cyl)
boxplot(am)

mtcars[am==0,"mpg"]->mpga # Automatique
mpga
mtcars[am==1,"mpg"]->mpgm # Manuel
mpgm

boxplot(mpga,mpgm,names=c("automatique","manuelle"),main="mpg selon la transmission")
boxplot()        