#' ---	
#' title: "Projet de fiabilité"	
#' author: "Oumar BALDE, Halil ERGUN et Douba JAFUNO"	
#' date: "`r format(Sys.time(), '%d %B %Y')`"	
#' output: pdf_document	
#' toc : true	
#' toc_depth: 2	
#' ---	
#' 	
#' 	
knitr::opts_chunk$set(echo = TRUE)	
#' 	
#' 	
#' 	
dat<-read.csv("fiabilite.csv",header=T, sep=",",encoding = "UTF-8")	
#read.table("surverse.txt",header=T, sep=",",encoding = "UTF-8")	
#ccmd<-read.table("ccmd.txt",header=T, sep=",",encoding = "UTF-8")	
#' 	
#' 	
#' \newpage	
#' 	
#' 	
#' # Introduction 	
#' 	
#' L'étude de ce projet porte sur le cas d'une usine industrielle qui est construite au bord d'une rivière. Cette usine risque d'être inondé à cause de l'écoulement des crues. Pour éviter cela, une digue de protection doit être construite. La problématique qui se pose est de déterminer la bonne hauteur de la digue. Nous pouvons observer la résolution de cette problématique, sous deux ongles différents. Soit d'un point de vue sureté avec lequel il s'agit principalement de s'assurer que l'installation est hautement protégée contre tout risque d'inondation. Soit d'un point de vue compromis cout/sureté.	
#' Afin de déterminer la hauteur de la digue, trois approches seront utilisées. Pour la première, il s'agit de déterminer la hauteur de la digue rien qu'a partir des relevés de mesures historiques pendant 149 ans. Pour la deuxième approche, nous allons s'appuyer sur le modèle hydraulique. Pour la troisième approche, nous allons combiner le modèle hydraulique avec le modèle économique. Nous commençons par traiter le problème des données manquantes puis nous allons présenter les approches utiles pour la détermination de la hauteur de la digue, et enfin nous terminons par une conclusion.	
#' 	
#' # Partie I - Détermination de la hauteur de la digue à partir des relevés de mesure historique.	
#' 	
#' 	
#' ## Mesures historiques de débit et de hauteur de crue avec une Imputation de données 	
#' 	
#' On dispose d'une base d’enregistrements historiques, sur 149 années (entre 1849 et 1997), des débits maxima annuels de crue Q et des hauteurs d'eau associées H, certaines données étant manquantes.	
#' 	
#' En observant les données mise à nos notre disposition on s'est aperçu que la variable hauteur contient plusieurs données manquantes. Pour les imputer, nous allons essayer 3 méthodes, les comparer puis choisir la meilleure.	
#' 	
#' 	
head(dat)	
#' 	
#' 	
#' **Knn** 	
#' Affecter aux valeurs manquantes la moyennes des k voisins retenus pour chaques valeur manquante.	
#' 	
#' **Random Forest** fonctionnent en construisant une multitude d' arbres de décision au moment de la formation et en produisant la classe qui est le mode des classes ou la prédiction moyenne (régression) des arbres individuels.	
#' 	
#' **Amelia**	
#' Il s'agit d'une combinaison de l’algorithme EM avec une approche bootstrap.	
#' 	
#' **SVD**	
#' Basée sur une régression avec une décomposition en valeurs singulières de la partie des données complètes 	
#' 	
#' 	
#install.packages("Amelia")	
#install.packages("bcv")	
#install.packages("VIM")	
#' 	
#' 	
#' 	
#' 	
library(Amelia)	
library(cowplot)	
	
#' 	
#' 	
#' 	
#' 	
	
dat.amelia=amelia(dat,m=1)$imputations$imp1  # voir le pdf imputation	
dat.amelia$Imputation<-is.na(dat[3])	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
library(bcv)	
dat.SVD=data.frame(impute.svd(dat,k=3,maxiter=1000)$x)	
dat.SVD$Imputation<-is.na(dat[3])	
colnames(dat.SVD)=c("Année","Débit","Hauteur","Imputation")	
dat.SVD	
#' 	
#' 	
#' 	
#' 	
# chargement de la bibliothèque	
library(VIM)	
dat.kNN=kNN(dat, k=5, imp_var=FALSE)	
dat.kNN$Imputation<-is.na(dat[3])	
dat.kNN	
#' 	
#' 	
#' 	
##RANDOM FOREST	
library(missForest)	
dat.Forest=missForest(dat)	
dat.Forest$ximp$Imputation<-is.na(dat[3])	
head(dat.Forest$ximp)	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
library(ggplot2)	
#' 	
#' 	
#' 	
amelia<-ggplot(dat.amelia , aes(x=Débit, y=Hauteur,colour=Imputation))+ geom_point()+ggtitle("Amelia")	
	
#' 	
#' 	
#' 	
#' 	
#' 	
knn<-ggplot(dat.kNN , aes(x=Débit, y=Hauteur,colour=Imputation))+ geom_point()+ggtitle("KNN")	
	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
svd<-ggplot(dat.SVD , aes(x=Débit, y=Hauteur,colour=Imputation))+ geom_point()+ggtitle("SVD")	
	
#' 	
#' 	
#' 	
forest<-ggplot(dat.Forest$ximp , aes(x=Débit, y=Hauteur,colour=Imputation))+ geom_point()+ggtitle("RandomForest")	
#' 	
#' 	
#' 	
par(mfrow=c(2,2))	
plot_grid(amelia,knn,svd,forest)	
	
#' 	
#' 	
#' Nous pouvons observer ses résultats graphiquement. Donc comme vous pouvez le voir nous avons tracé la hauteur H en fonction du débit Q, les points roses correspondent aux données complètes et les points verts aux données manquantes.	
#' On voit clairement que pour **KNN**, **Random Forest** et Amélia, les données complètes imputés ont la même allure que les données complètes contrairement a la méthode SVD.	
#' KNN Random Forest et Amélia sont donc meilleure que SVD on pourrait choisir n'importe lequel parmis les 3.	
#' Pour la suite, nous avons donc choisis de retenir les données complètes avec **KNN**.	
#' 	
#' Avec les méthodes **Amelia** et **KNN** les données imputées ont la même allure que les données complètes.	
#' 	
#' La méthode **SVD** en revanche remplace toutes les données manquantes, elle est donc moins bonne que les deux autres	
#' 	
#' La méthode **KNN** est retenue. 	
#' 	
#' 	
#' 	
#' \newpage	
#' 	
#' ## Loi de la Hauteur 	
#' 	
#' On trace l'allure des données de la Hauteur via un histogramme et on regarde sa distribution via une boîte à moustache.	
#' 	
#' 	
	
H<-dat.kNN$Hauteur	
mH<-mean(H)	
sdH<-sd(H)	
hist(H , col="blue", main="Histogramme de H", freq = FALSE,xlab=NA,ylab=NA)	
#curve(dnorm(x,mH,sdH), col = "red", add = TRUE)	
boxplot(H,col="blue",main="Boxplot de H")	
	
#' 	
#' 	
#' La variable **Hauteur** prend ses valeurs dans $\mathbb{R}$, l'histogramme et le boxplot semblent symétriques. On peut supposer une loi normale pour la loi de la Hauteur. On a aussi effectué un test de Shapiro et d'après le test de Shapiro on a une $p_{value} = 0.3385 > 0.05$ On confirme donc l'hypothèse que la Hauteur suit une **loi Normale** 	
#' 	
#' 	
#' 	
#shapiro.test(dat.kNN$Hauteur)	
#' 	
#' Pour vérifier on peut superposer la densité de la loi de Normale avec l'histogramme. On voit bien que notre hypothèse est cohérente :	
#' 	
#' 	
hist(H , col="blue", main="Histogramme de H", freq = FALSE,xlab=NA,ylab=NA)	
curve(dnorm(x,mH,sdH), col = "red", add = TRUE)	
legend(x="topright",c('densité loi normale'),col='red',pch=1)	
#' 	
#' 	
#' 	
alpha<-seq(0.001,0.05,0.001) # On varie alpha  0.001 à 0.05	
#alpha	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
Hd<- qnorm(1-alpha, mean = mH, sd = sdH)# on peur uriliser quantile(H,1-alpha) pas sur 	
#Hd	
#' 	
#' 	
#' ## La hauteur $h_{d}$ qui minimise la proba que $H-h_d$ soit positive	
#' 	
#' Maintenant, nous allons determiner la hauteur de la digue grâce aux relevés de mesure historique avec comme objectif d'identifier le $h_{d}$ qui minimise la proba que $H-Hd$ soit positive donc $h_{d}$ tel que $\underset{h_{d}}{min} P( H-h_{d}>0)$	
#' 	
#' Notons que cette proba égale a alpha.	
#' Comme vous pouvez le voir, Hd correspond au quantile d'ordre (1-alpha) de la variable H.	
#' 	
#' On a donc décidé de faire varier alpha et les résultats obtenus sont regroupés dans le graphe suivant	
#' 	
#' Comme vous pouvez le voir pour des risques d'inondation alpha de plus en plus petit, la hauteur $h_{d}$ augmente.	
#' 	
#' Un Hd élevé assure donc un niveau de sureté élevé, ...il faut choisir un $h_d$ élevé mais pas trés grand.	
#' 	
#' Nous choisissons donc un $\alpha=0.005$ environ ce qui nous donne un $h_d$=8.	
#' 	
#' 	
library(latex2exp)	
#' 	
#' 	
#' 	
#u<- seq(6,8,0.0001)	
plot(Hd,1 - pnorm(q = Hd, mean = mH, sd = sdH),type="b",pch=19,col='blue',ylab=TeX("P(H> h_d)"),xlab=TeX("$h_d$")) 	
#pnorm(Hd,mH,sdH) renvoie P(H<= Hd) car H Loi normale(mH,sdH) d'apres slide 7	
# Nous on veut P(H> Hd) = 1-P(H<= Hd) c'est la fonction de survie 	
#' 	
#' 	
#' 	
#' \newpage	
#' 	
#' 	
library(evd) 	
	
#' 	
#' 	
#' 	
	
 rTriangle <- function(n, b, a) { 	
    rtriangl<-function(b,a){	
        u <- runif(1)	
        if(0<= u  && u<=0.5){ 	
            return( a*sqrt(2*u) +b-a)	
        }	
        if(0.5< u && u <1){	
            return (a*abs(1-sqrt(2*(1-u)))+b)	
        }	
        else{	
            return (0)	
        }	
        }	
     replicate(n, rtriangl(b, a))   	
}     	
      	
    	
#' 	
#' 	
#' 	
x<-rgumbel(1000,1013,558)	
n<-rnorm(1000,30,7.5)	
#' 	
#' 	
b<-rTriangle(1000,50,1)	
w<-rTriangle(1000,55,1)	
#' 	
#' 	
#' # Partie II - Détermination de la hauteur de la digue à partir du modèle hydraulique	
#' 	
#' 	
#' L'approche 2 quant à elle, a pour objectif de déterminer la hauteur de la digue $h_{d}$ tel que $\underset{H_{d}}{min}P(S>0) =\alpha$.	
#' $S$ est déterminer par le modèle hydraulique représenté par les deux équations suivantes : 	
#' 	
#' $S= Z_{c}- Z_{d}= Z_{v}+ H - h_{d}-Z_{b}$	
#' 	
#' $\mathbf{H}=\left(\frac{\mathbf{Q}}{\mathbf{K}_{\mathrm{s}} \sqrt{\frac{\mathbf{Z}_{\mathbf{m}}-\mathbf{Z}_{\mathbf{v}}}{\mathbf{L}}} \mathbf{B}}\right)^{3 / 5}$	
#' 	
#' Les Histogrammes ci-dessous illustrent toutes les variables utilisés pour le modèle hydraulique avec H, (on a choisit des valeurs de $Q$ positif ou nul, du fait de la puissance $3/5$ de la formule de H), on visualise les distributions des variables utilisées qu'on a simulé sous R et on a choisis de simuler 1000 réalisations de $H$ .	
#' 	
#' Avec Q(m3/s): Loi de Gumbel(1013,558), $K_s$: Loi Normale(30,7.5) une normale, $Z_v$ et $Z_m$ des lois triangulaires de paramètre (50,1) et (55,1) respectivement.	
#' 	
#' 	
par(mfrow=c(2,2))	
hist(x, col="red", main="Q(m3/s)" ,xlab=NA,ylab=NA)	
hist(n, col="red", main="Ks",xlab=NA,ylab=NA)	
hist(b,col="red", main="Zv",xlab=NA,ylab=NA)	
hist(w,col="red", main="Zm",xlab=NA,ylab=NA)	
	
#' 	
#' 	
#' 	
#' 	
#' $\underset{h_{d}}{min} P(S>0)= \alpha$ se transforme en $\underset{h_{d}}{min} P(M>h_d)= \underset{h_{d}}{min} (1-P(M \le h_d))= \alpha$ c'est la fonction de survie de $M$ au point $h_d$ avec $M=Z_v+H-Z_b$ 	
#' 	
#' Comme vous pouvez le voir $H_d= F^{-1}_M (1-\alpha)= q_{1-\alpha}(M)$, le quantile d'ordre $1-\alpha$ de la variable $M$.	
#' 	
#' 	
#' 	
#' 	
Zb<-55.5	
B<-300	
L<-5000	
#' 	
#' 	
#' 	
#' 	
Ks<-rnorm(1,30,7.5)	
Zv<-rTriangle(1,50,1)	
Zm<-rTriangle(1,55,1)	
Q<-rgumbel(1000,1013,558)	
Q<-Q[Q>0]	
#' 	
#' 	
#' 	
#' 	
#' 	
H<-(Q/(Ks*B*sqrt((Zm-Zv)/L)))^(3/5)	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
H<-na.omit(H)	
#' 	
#' 	
#' 	
#' 	
#H	
#' 	
#' 	
#' \newpage	
#' 	
#' ## La Variable M 	
#' 	
#' Ici nous avons essayé de déterminer la loi de la variable M 	
#' Voici l'histogramme et le Boxplot de M	
#' 	
#' 	
W<-Zv + H -Zb	
hist(W,main="M" ,xlab=NA,ylab=NA, col="green")	
boxplot(W, col="green")	
#' 	
#' 	
#' ![image](projet1.png)	
#' La variable **$M=Z_v+H-Z_b$ ** prend ses valeurs dans $\mathbb{R}$ mais on a bcp plus de valeurs négatives en effet sur le schéma ci dessus on pourrais voir que $Z_b > Z_v + H$, l'histogramme semble légèrement asymétrique et le boxplot semble être à peu près symétriques avec des valeurs aberrantes qui sont pour la plupart positives. Au vue du boxplot on a pu effecter un test de Shapiro et d'après le test de Shapiro on a une $p_{value} < 0.05$ On confirme donc l'hypothèse que M ne suit pas une **loi Normale** 	
#' 	
#' 	
#' 	
##shapiro.test(W) # pa une loi normale LOI a determiné 	
#' 	
#' 	
#' \newpage	
#' Sous R nous avons donc choisis la commande "quantile(M,1-$\alpha$)" pour calculer $h_d=q_{1-\alpha}(M)$ les variables et la fonction ecdf pour calculer $P(M \le h_d)$ et ainsi obtenir la fonction de survie de M en $h_d$: $P(M>h_d)$ .Sous R on a fait varier le $\alpha$, et les résultats peuvent être visualisé sur le graphe suivant :  ...	
#' 	
#' 	
#' 	
#' 	
#W.ordered = sort(W)	
	
#' 	
#' 	
#' 	
#' 	
#n<- sum(!is.na(W))	
#' 	
#' 	
#' 	
#' 	
#plot(W.ordered, (1:n)/n, type = 's', ylim = c(0, 1), xlab = 'Sample Quantiles of W', ylab = '', main = 'FDR de W ')	
	
#' 	
#' 	
#' 	
#' 	
#' 	
alpha<-seq(0.001,0.05,0.0001) # On varie alpha 	
#alpha	
#' 	
#' 	
#' 	
Hd<- quantile(W,1-alpha) # on peur uriliser quantile(H,1-alpha) pas 	
#' 	
#' 	
#' 	
Hd<-as.numeric(Hd)	
#' 	
#' 	
#' 	
#' 	
plot(Hd, 1- ecdf(W)(Hd),type="b",pch=19,col='blue',ylab=TeX("P(M> h_d)"),xlab=TeX("$h_d$")) 	
#' 	
#' 	
#' 	
#' \newpage	
#' 	
#' # Partie III - Détermination de la hauteur de la digue à partir du modèle économique	
#' 	
#' $C_{t}(T)=C_{i}(h_d)+TC_{m}(h_d)$ sur la durée T	
#' 	
#' $C_{d}=C_{s}(S)+C_{g}(S,h_d)$ sur une année	
#' 	
#' $C_{c}=C_{t}(T)+\sum \limits_{{j=0}}^T C_{d,j}(S_{j},h_d)$ sur la durée T	
#' 	
#' $C_{c,moyenné}=\frac{C_{c}(T)}{T}$	
#' 	
#' $C_{m}=0.01C_{i}$ sur une année	
#' 	
#' $T=30$	
#' 	
#' but : Déterminer  Hd telle que $Hd=argmin(C_{c,moyenné})$	
#' 	
#' 	
#' 	
surverse<-read.table("surverse.txt",header=T, sep=",",encoding = "UTF-8")	
ccmd<-read.table("ccmd.txt",header=T, sep=",",encoding = "UTF-8")	
#' 	
#' 	
#' ## Algorithme	
#' 	
#' 1. On se donne une hauteur Hd pour la digue de façon aléatoire parmis les hd proposées dans le dataframe ccmd	
#' 	
#' 2. On chercher le coût d'investissement Ci associé à Hd 	
#'  	
#' 3. Pour i allant de 1 à T :	
#' 	
#'   1-- on tire une surverse s correspondant à l'année i dans les surverses(S) données dans le dataframe surverse	
#'    	
#'   2-- on identifie le coût de dommage au site Cs associé à la surverse s et coût de dommage à la digue Cg associé à s et Hd	
#'    	
#'   3-- on calcule le coût total de dommage Cd=Cs+Cg pour l'année i	
#'  	
#' 4. On calcule le coût total de la digue Ct(T)= Ci(hd)+ T  *0.01* Ci(hd) sur la durée T	
#' 	
#' 5. On calucle le le coût complet $Cc=Ct(T)+\sum \limits_{{j=0}}^T C_{d,j}(S_{j},hd)$ sur la durée T	
#' 	
#' 6. Et enfin on calcule $C_{c,moyenné}=\frac{C_{c}(T)}{T}$	
#' 	
#' 	
#head(surverse)	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
#ccmd	
#' 	
#' 	
#' 	
#' 	
#' 	
T<-30	
#' 	
#' 	
#' 	
#' 	
#Ct<-ccmd$Coûtotalx*1/100 + T*ccmd$Coûtotalx	
#' 	
#' 	
#' 	
#' 	
#Ct	
#' 	
#' 	
#' 	
n=sample(1:1000,replace=TRUE)	
set.seed(n)	
Cd=c()	
T=30	
ccm<-function(hd){	
   ind_hd=which(ccmd$hd==hd) # on récupére l'indice de hd pour avoir le Ci associé	
   Ci=ccmd$Ci[ind_hd]	
for(i in 1:T){	
    s=sample(surverse$S,1,replace=TRUE )#pour avoir la surverse ainsi que le Cg et le Cs associés dans le dataframe surverse	
    ind_sur=which(surverse$S==s) # récupération de l'indice afin d'obtenir Cg et Cs   	
    	
    Cs=surverse$Cs[ind_sur]	
    Cg=Ci*surverse$Cg_par_rapport_Ci[ind_sur]	
    Cd[i]=Cs+Cg ## Cd correspondant à l'année i	
    }	
Ct=Ci+T*0.01*Ci	
Cc=Ct+sum(Cd)	
C_c_moy=Cc/T 	
return(C_c_moy)	
}	
cmy=c()	
for (i in 1:13){	
    cmy[14-i]=ccm(ccmd$hd[i])	
}	
	
mn=min(cmy)	
ind_mn=which(cmy==mn)	
#' 	
#' 	
#' 	
plot(ccmd$hd,cmy,type='b',lwd=3,col="blue",main=TeX("$C_{c,moyenné}$ en fonction de $h_d$"),xlab="Hd",ylab=TeX("$C_{c,moyenné}$"))	
#text(ccmd$hd[ind_mn],mn,pos=4,col='red')	
points(ccmd$hd[ind_mn],mn,lwd=4,col='red')	
legend(max(ccmd$hd)-6,max(cmy)-2000,legend=c(TeX("C_{c,moyenné}"),TeX("Hd=argmin(C_{c_moyenné})")),	
           col=c("blue","red"),pch=21)	
#' 	
#' 	
#' Pour la troisième approche, le modèle utilisé est le modèle hydraulique pour simuler des réalisations de la surverse S auquel nous avons rajoutés une dimension économique. Nous avons donc pris en considération les différents coût liés a la digue et au site. L'enjeu principal est de trouver la bonne hauteur digue Hd pour minimiser le Cc, moyéné. Sous R nous avons tracés ce graphique représentant le Cc, moyéné pour différentes valeurs de Hd sur lequel on constate que Hd minimisant Cc, moyéné est égale à 8m ou 9m.	
#' Au vu du graphique ci-dessus, on voit la hauteur de la digue minimisant le coût complet moyenné vaut 8m ou 9m	
#' 	
#' # Conclusion 	
#' 	
#' Pour conclure, on peut dire que la première approche n’utilise que l’information concernant la hauteur maximale de l’eau dans la rivière contrairement à la deuxième approche dans laquelle le modèle a été enrichi par d’autres informations.	
#' La troisième approche quant à elle, nous fournit un meilleur niveau de sûreté que celui des deux autres approches. La troisième approche semble plus pertinente. 	
