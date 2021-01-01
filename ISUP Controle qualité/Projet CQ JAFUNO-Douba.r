data1<- read.table('//home/jafuno/Téléchargements/Controle Qualité/Qualite-JAFUNO.csv', header = TRUE,sep=",")
data<- data1[,2:109]

head(data)


par(mfrow=c(2,3))
for(i in 1:6){

    data2 <- (data[,i]- mean(data[,i]))/sd(data[,i])
#Xbar <- (Xbar- mean(Xbar))/sd(Xbar)
qqnorm(data2,ylab='R', main = names(data[i]))
#distribution normales de R 
abline(0, 1, col='blue')
}



shapiro.test(data[,1])

shapiro.test(data[,5])

shapiro.test(data[,6])

par(mfrow=c(2,2))
z=data[,1]
hist(z, breaks =50, freq= F,main= "Distribution de Date")
lines(density(z), col= 'red',lwd=3)

y=data[,5]
hist(y, breaks =50, freq= F,main= "Distribution de V5")
lines(density(y), col= 'red',lwd=3)

x<-data[,6]
hist(x, breaks =50, freq= F,main= "Distribution de V6")
curve(dexp(x,1/mean(data[,6])), col = "red",lwd=3, add = TRUE)  ## Bonne adéquation à une loi exponentielle 
##,ylim=c(0,0.00015) ,xlim=c(0,30000)

datachart<- data[,7:106]
head(datachart)

library(SixSigma)# pour les coefficients 
n=100
d2<-ss.cc.getd2(n=100)
d3<-ss.cc.getd3(n=100)
A2<-3/(d2*sqrt(n))
D4=1+(3*d3/d2)
D3=1-(3*d3/d2) 
c4<-4*(n-1)/(4*n-3)
A3<-3/(c4*sqrt(n))
B3<-1-(3/(c4*sqrt(2*(n-1))))
B4<-1+(3/(c4*sqrt(2*(n-1))))


Xbar<-apply(datachart, 1,mean) 
w<-apply(datachart, 1,range) 
R<-w[2,]-w[1,]
Xbarbar = mean(Xbar)

Rbar= mean(R)

lcl = Xbarbar - A2*Rbar
ucl = Xbarbar + A2*Rbar

lclR=D3*Rbar
uclR=D4*Rbar

#par(mfrow=c(2,1))
plot(Xbar, col= 'blue', ylim=c(lcl-10,ucl+10),type="b",pch=19, main ='Carte Xbar')
abline(Xbarbar,0, col ='green')
abline(ucl,0, col ='black')
abline(lcl,0, col ='red')
legend(1,28,c("UCL= 18.6","Mean= 11.34","LCL= 4.04"),col=c('black','green','red'),lty = 1)

plot(R, col= 'blue', ylim=c(lclR-250,uclR+250),type="b",pch=19, main = 'Carte R')
abline(Rbar,0, col ='green')
abline(uclR,0, col ='black')
abline(lclR,0, col ='red')
legend(0,390,c("UCL= 166","Mean= 122","LCL= 77"),col=c('black','green','red'),lty = 1)

S<-apply(datachart, 1,sd) 
Sbar= mean(S)
A3=3/(c4*sqrt(n))
B3=1-(3/(c4*sqrt(2*(n-1)))) 
B4=1+(3/(c4*sqrt(2*(n-1)))) 
Sbar= mean(S)
lcl = Xbarbar - A3*Sbar
ucl = Xbarbar + A3*Sbar


uclS=B4*Sbar
lclS=B3*Sbar


plot(Xbar, col= 'blue', ylim=c(lcl-10,ucl+10),type="b",pch=19, main ='Carte Xbar')
abline(Xbarbar,0, col ='green')
abline(ucl,0, col ='black')
abline(lcl,0, col ='red')
legend(1,27,c("UCL= 17,2 ","Mean= 11.3","LCL= 5.4"),col=c('black','green','red'),lty = 1)

plot(S, col= 'blue', ylim=c(lclS-39,uclS+39),type="b",pch=19, main = 'Carte S')
abline(Sbar,0, col ='green')
abline(uclS,0, col ='black')
abline(lclS,0, col ='red')
legend(0,62,c("UCL= 23","CL= 19.6","LCL= 15"),col=c('black','green','red'),lty = 1)


d107<- data[,107]
head(d107)

#Estimation de sigma
MR<-c() # CQ3 page 29

for( i in 1:999){
  MR[i]<- abs(d107[i+1]-d107[i])
}
MRbar= mean(MR)
sigma= MRbar/ 1.128

d107<- data[,107]
#mean(d107[1:2])
mu0 =2# On veut detecter un changement par rapportà une moyenne égal à 2
k=0.25
K=k*sigma

h=8.01
H=h*sigma
UCL=H
Cusum<-c()
Cusum[1]=0
for(i in 2:1000){
  Cusum[i] = max(0,d107[i]-(mu0+K)+ Cusum[i-1])
}

D<-c()
D[1]=0
for(i in 2:1000){
  D[i] = max(0,(mu0-K)-d107[i]+ D[i-1])
}
plot(Cusum,ylim=c(-10,35700),xlim=c(0,1000), col= 'blue',type="b",pch=19,main='Carte Cusum, k=0.25, h=8.01 ')
lines(D,ylim=c(-0.5,0.5),xlim=c(0,26), col= 'red',type="b",pch=19)
abline(0,0,col='black')
abline(H,0,col='pink',lty = 1)
abline(-H,0,col='green',lty = 1)
legend("topleft",c("C+","C-","UCL= 128.8 ","CL= 0","LCL= -128.8"),col=c('blue','red','pink','black','green'),lty = 1)



a<-c()
for(i in 1:1000){
    a[i]<-(Cusum[i]<H)
}
n=sum(a)
print(paste("Le signal du processus n'est pas sous controle, les pts après le",as.character(n),'ème dépassent les limites de controle'))

#EWMA
lambda=0.5
mu0=2
L=3
EWMA_Z<-c()
EWMA_Z[1]=lambda*d107[1]+(1-lambda)*mu0
for(i in 2:1000){
  EWMA_Z[i]=lambda*d107[i]+(1-lambda)*EWMA_Z[i-1]
}
LCL<-c()
for(i in 1:1000){
  LCL[i]<- mu0 -L*sigma*sqrt((lambda/(2-lambda))*(1-(1-lambda)^(2*i)))
}

#LCl<- mu0 -L*sigma*sqrt((lambda/(2-lambda)))
                    

UCL<-c()
for(i in 1:1000){
  UCL[i]<- mu0 +L*sigma*sqrt((lambda/(2-lambda))*(1-(1-lambda)^(2*i)))
}


plot(EWMA_Z,ylim=c(-100,150),xlim=c(0,1000), col= 'green',type="b",pch=19, main = 'Carte EWMA, lambda= 0.5, L= 3')
lines(UCL,ylim=c(7.96,8.13),xlim=c(0,1000), col= 'blue',type="b",pch=19)
lines(LCL,ylim=c(7.96,8.13),xlim=c(0,1000),col= 'red',type="b",pch=19)
legend(0,150,c("UCL","Z","LCL"),col=c('blue','green','red'),lty = 1)

for(i in 1:1000){
    a[i]<-(EWMA_Z[i]<max(UCL))
}
n=sum(a)
print(paste("Le signal du processus n'est pas sous controle, les pts après le",as.character(n),"ème dépassent les limites de controle"))

d108<- data[,108]
head(d108)

MR<-c() # CQ3 page 29

for( i in 1:999){
  MR[i]<- abs(d108[i+1]-d108[i])
}
MRbar= mean(MR)
sigma2= MRbar/ 1.128

d108<- data[,108]
mu0 =2# On veut detecter un changement par rapport à une moyenne égal à 2
k=0.5
K=k*sigma2
h=4.77
H=h*sigma2
UCL=H
UCL=H
Cusum<-c()
Cusum[1]=0
for(i in 2:1000){
  Cusum[i] = max(0,d108[i]-(mu0+K)+ Cusum[i-1])
}
D<-c()
D[1]=0
for(i in 2:1000){
  D[i] = max(0,(mu0-K)-d108[i]+ D[i-1])
}
plot(Cusum,ylim=c(-15,200),xlim=c(0,1000), col= 'blue',type="b",pch=19,main='Carte Cusum, k= 0.5, h=4.77')
lines(D,ylim=c(-0.5,0.5),xlim=c(0,26), col= 'red',type="b",pch=19)
abline(0,0,col='black')
abline(H,0,col='pink')
abline(-H,0,col='green')
legend("topleft",c("C+","C-","UCL= 2.4 ","Mean= 0","LCL= -2.4"),col=c('blue','red','pink','black','green'),lty = 1)




for(i in 1:1000){
    a[i]<-(Cusum[i]<H)
    if(D[i]>H){m=i}
}
n=sum(a)

print(paste("Le signal du processus n'est pas sous controle, Pour C+ les points après le",as.character(n),'ème dépassent les limites de controle'))
print(paste("pour C- seul le",as.character(m),"ème point est hors des limites de controle"))

#EWMA
lambda=0.2
mu0=2
L=3
EWMA_Z<-c()
EWMA_Z[1]=lambda*d108[1]+(1-lambda)*mu0
for(i in 2:1000){
  EWMA_Z[i]=lambda*d108[i]+(1-lambda)*EWMA_Z[i-1]
}
LCL<-c()
for(i in 1:1000){
  LCL[i]<- mu0 -L*sigma2*sqrt((lambda/(2-lambda))*(1-(1-lambda)^(2*i)))
}
             

UCL<-c()
for(i in 1:1000){
  UCL[i]<- mu0 +L*sigma2*sqrt((lambda/(2-lambda))*(1-(1-lambda)^(2*i)))
}

plot(EWMA_Z,ylim=c(1,3.25),xlim=c(0,1000), col= 'green',type="b",pch=19, main = 'Carte EWMA, Lambda=0.2, L=3')
lines(UCL,ylim=c(7.96,8.13),xlim=c(0,24), col= 'blue',type="b",pch=19)
lines(LCL,ylim=c(7.96,8.13),xlim=c(0,24),col= 'red',type="b",pch=19)
legend("topleft",c("UCL","Z","LCL"),col=c('blue','green','red'),lty = 1)

