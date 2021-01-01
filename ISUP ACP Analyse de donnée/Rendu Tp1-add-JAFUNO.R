#' ---	
#' title: "Compte Rendu TP1 par JAFUNO Douba"	
#' output:	
#'   pdf_document: default	
#'   html_document: default	
#' ---	
#' 	
#' 	
knitr::opts_chunk$set(echo = TRUE)	
	
#' 	
#' 	
library('ggplot2')	
library(cowplot)	
library(FactoMineR)	
library(gridExtra)	
library(factoextra)	
	
#' 	
#' ## Donnée Seeds	
#' 	
#' 	
#' ### Informations sur le jeu de données:	
#' 	
#' Le groupe examiné comprenait des noyaux appartenant à trois variétés différentes de blé: Kama, Rosa et Canadian, de 70 éléments chacun, choisis au hasard pour	
#' l'expérience. Une visualisation de haute qualité de la structure interne du noyau a été détectée à l’aide d’une technique de rayons X douce. Il est non destructif et considérablement moins coûteux que d'autres techniques d'imagerie plus sophistiquées telles que la microscopie à balayage ou la technologie laser. Les images ont été enregistrées sur des plaques KODAK à rayons X de 13 x 18 cm. Les études ont été menées à l'aide de grains de blé récoltés dans des moissonneuses-batteuses provenant de champs expérimentaux et examinés à l'Institut d'agrophysique de l'Académie des sciences de Pologne à Lublin.	
#' 	
#' L'ensemble de données peut être utilisé pour les tâches de classification et d'analyse par grappes.	
#' 	
#' 	
#' Informations d'attribut:	
#' 	
#' Pour construire les données, sept paramètres géométriques des grains de blé ont été mesurés:	
#' 	
#' 1. aire A,	
#' 	
#' 2. périmètre P,	
#' 	
#' 3. compacité C = 4 * pi * A / P ^ 2,	
#' 	
#' 4. longueur du noyau,	
#' 	
#' 5. largeur du noyau ,	
#' 	
#' 6. coefficient d'asymétrie.	
#' 	
#' 7. longueur de la gorge du noyau.	
#' 	
#' Tous ces paramètres étaient des valeurs réelles continues.	
#' 	
#' 	
#' **Nombres de valeur manquantes (nvm)**	
#' 	
#' 	
#' 	
	
#localiseNA<-is.na(seeds)	
#NAvar<-apply(localiseNA,2,sum)	
#NAvar	
#' 	
#' |.|Area |   Perimeter | Compactness |  Length| Width |   Asymmetry| GrooveLength |	
#' |----|-----|----|-----|-----|-----|-----|---|------|	
#' Nvm|0  | 0 |  0  |  0  |  0   | 0    |  0 |	
#' 	
#' 	
#' 	
#' \newpage	
#' 	
#' ### Distributions des variables 	
#' 	
#' 	
#' 	
	
seed<- read.table('Données/seeds.txt', header = F)	
seeds<-seed[,1:7]	
names(seeds)<-c("Area","Perimeter","Compactness","Length", "Width","Asymmetry","GrooveLength")	
boxplot(seeds, main ="Distribtion des variables")	
summary((seeds)) 	
	
#' 	
#' 	
#' \newpage	
#' 	
#' **Histogrammes de chaque variable**	
#' 	
#' 	
#' 	
#' 	
	
a<-ggplot(seeds) + aes(x = Area) + geom_histogram(bins = 40)	
b<-ggplot(seeds) + aes(x = Perimeter) + geom_histogram(bins = 40)	
c<-ggplot(seeds) + aes(x = Compactness) + geom_histogram(bins = 40)	
d<-ggplot(seeds) + aes(x = Length) + geom_histogram(bins = 40)	
e<-ggplot(seeds) + aes(x = Width) + geom_histogram(bins = 40)	
f<-ggplot(seeds) + aes(x = Asymmetry) + geom_histogram(bins = 40)	
g<-ggplot(seeds) + aes(x = GrooveLength) + geom_histogram(bins = 40)	
	
	
plot_grid(a,b,c,d,e,f,g)	
	
	
#' 	
#' 	
#' 	
#' 	
#' la variable **Aréa** présente une plus grande variabilité de 10.59 à 21.18 un peu plus que la variable **Perimeter** et **Asymmetry** qui elle est entre 0 et 8, La distribution de la variable Compactness est très concentré autour de 0.8 et 0.9 c'est celle qui a les plus petites valeur. On voit aussi que pour nos 7 variables les histogrammes sont plutot **asymétriques** mais le boxplot montre bien les différences entre nos 7 variables comme on s'y attendait. 	
#' \newpage	
#' 	
#' 	
#' 	
#' ### Corrélations entre nos variableS et nuages de points	
#' 	
#' #### Pour les corrélations comme il y a beaucoup de variables pour bien voir on peut se restreindre à quelques variables	
#' 	
#' 	
#' 	
a<-pairs(seeds)	
#' 	
#' 	
#' 	
#' 	
#round(cor(seeds), digits = 2)	
#sort(abs(cor(seeds)[, 1]))	
#' 	
#'              	
#'         	
#' |.|          Area|Perimeter| Compactness| Length |Width |Asymmetry |GrooveLength|	
#' |----|-----|----|-----|-----|-----|-----|---|------|	
#' |Area        |  1,00  |  0,99 |  0,61 |  0,95 | 0,97|  -0,23  |  0,86|	
#' |Perimeter    | 0,99  | 1,00  |0,53  | 0,97 | 0,94  |-0,22 |  0,89|	
#' |Compactness  | 0,61  |   0,53|  1,00|   0,37 | 0,76 |-0,33 | 0,23|	
#' |Length       | 0,95  |  0,97   | 0,37 |  1,00 | 0,86 |  -0,17 |0,93|	
#' |Width       |  0,97  | 0,94 |  0,76   |0,86  |1,00 | -0,26| 0,75|	
#' |Asymmetry    |-0,23| -0,22 |   -0,33  |-0,17 |-0,26|  1,00  |  -0,01|	
#' |GrooveLength | 0,86 |  0,89 |0,23   |0,93 | 0,75  | -0,01  | 1,00|	
#' 	
#' Aréa, Perimeter ,Length ,Width ,GrooveLength corrélés 2 à 2   Compactcness et Asymmetry sont moins corrélé avec les autres variables ont le voit avec leurs nuages de point qui n'ont pas de tendance linéaire, pas de structure particulière	
#' \newpage	
#' 	
#' ### Analyse en Composantes Principales 	
#' 	
#' L'objectif est de décrire sans à priori un jeu de données exclusivements de variables quantitatives, ici l'analyse sera donc effectuée sur 210 individus représentés par les grains de blé , décrits par nos 7 variables. Cette méthode permet de résumer l’information et d’en réduire la dimensionnalité.	
#' 	
#' 	
#' 	
	
rec.pca<- PCA(seeds,scale.unit=T, ncp=5,graph=F)	
a<-plot(rec.pca, choix="var", autoLab="yes")#cercle de corellation	
#b<-plot.PCA(rec.pca, axes=c(1, 2), choix="ind")	
#plot_grid(a,b)	
#' 	
#' 	
#' #### Valeurs propres	
#' 	
#' Les valeurs propres (eigenvalues en anglais) mesurent la quantité de variance expliquée par chaque axe principal.	
#' Elles sont grandes pour les premiers axes et petites pour les axes suivants.	
#' Les premiers axes correspondent aux directions portant la quantité maximale de variation contenue dans le jeu de données.	
#' On peut examiner les valeurs propres pour déterminer le nombre de composantes principales à prendre en compte.	
#' 	
#' Les valeurs propres peuvent être utilisées pour déterminer le nombre d’axes principaux à conserver.	
#' Une valeur propre > 1 : la composante principale (PC) concernée représente plus de variance par rapport à une seule variable d’origine, lorsque les données sont standardisées.	
#' On peut regarder le nombre d’axes qui représente une certaine fraction de la variance totale. Par exemple, le nombre d’axe qui permet de parvenir à 70% de la variance totale expliquée.	
#' 	
#' 	
#' 	
#' 	
#' 	
eig.val<-get_eigenvalue(rec.pca)	
eig.val	
#' 	
#' 	
#' 	
#' Nous voyons ici que **Dim 1** et **Dim 2** ont des valeurs propres > 1. **Dim1** explique à elle seule 71,9%de la variance. En gardant les 2 premières composantes, on explique **89%** de la variance, et avec les 3 premières composantes plus de 97%de la variance.  On va donc prendre en compte ces 2 axes. 	
#' 	
#' #### Variables 	
#' 	
#' L’ACP permet également d’étudier les liaisons linéaires entre les variables.	
#' 	
#' Les objectifs sont de résumer la matrice des corrélations et de chercher des variables synthétiques : peut-on résumer les observations par un petit nombre de variables ?	
#' 	
#' 	
#' 	
#' 	
var = get_pca_var(rec.pca)	
#' 	
#' 	
#' #### Qualité et Contributions	
#' 	
#' **Cos2**	
#' 	
#' le cosinus carré des variables. Représente la qualité de représentation des variables sur le graphique de l’ACP. Il est calculé comme étant les coordonnées au carré : var.cos2=var.coord*var.coord. Avec var$coord les coordonnées des variables pour représenter le nuage de points.	
#' 	
#' Un cos2 élevé = bonne représentation de la variable sur les axes principaux → la variable est positionnée à proximité du bord du cercle de corrélation (ci dessous, il en est de meme pour la contibution).	
#' 	
#' Un faible cos2 = la variable n’est pas bien représentée par les axes principaux → la variable est proche du centre du cercle.	
#' 	
#' **Contributions des variables aux axes principaux**	
#' 	
#' Plus la valeur de la contribution est importante, plus la variable contribue à la composante principale en question.	
#' 	
#' Les contributions des variables sont exprimées en pourcentage.	
#' 	
#' Les variables corrélées avec **Dim.1** et **Dim.2** sont les plus importantes pour expliquer la variabilité dans le jeu de données.	
#' 	
#' 	
#var$cos2	
#var$contrib	
#' 	
#' |.|     cos2Dim.1  |      cos2Dim.2   |    cos2Dim.3 |	
#' |----|---|---|---|--|---|---|	
#' |Area    |     **0,99394755** |0,0008450341| 0,0004537914| 	
#' |Perimeter |  **0,98101057**| 0,0084506414 |0,0024277403| 	
#' |Compactness|  0,38608745| **0,3353216539** |0,2688363174 |	
#' |Length     |  0,90262715| 0,0508079572| 0,0304376025 |	
#' |Width   |     **0,94250493**| 0,0163067144| 0,0317746687 |	
#' Asymmetry   | 0,07087908 |**0,6154564499**| 0,3130532976 |	
#' GrooveLength| 0,75414445 |**0,1703843961** |0,0310200207 |	
#' 	
#' 	
#' |.|                contribDim.1|       contribDim.2 |   contribDim.3  | 	
#' |----|---|---|---|--|---|---|	
#' Area       |  **19,755671** | 0,07056223 | 0,06693054 |	
#' Perimeter    |**19,498536** | 0,70564738|  0,35807198  |	
#' Compactness  | 7,673862| **28,00010494**| 39,65117316 |	
#' Length     |  17,940589 | 4,24257759 | 4,48929913 |	
#' Width       | **18,733199** | 1,36164697  |4,68650554 | 	
#' Asymmetry    | 1,408790| **51,39198433** |46,17281857  |	
#' GrooveLength| 14,989352 |**14,22747656** | 4,57520109 |	
#' 	
#' **Cercle de corrélation**	
#' 	
#' Plus une variable est proche du cercle de corrélation, meilleure est sa représentation et elle est plus importante pour interpréter les composantes principales en considération	
#' Les variables qui sont proche du centre du graphique sont moins importantes pour interpréter les composantes.	
#' 	
	
a=fviz_pca_var(rec.pca, col.var = "cos2",	
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),	
             repel = TRUE # Évite le chevauchement de texte	
             )	
b=fviz_pca_var(rec.pca, col.var = "contrib",	
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),	
             repel = TRUE # Évite le chevauchement de texte	
             )	
plot_grid(a,b)	
#' 	
#' 	
#' 	
#' 	
#' On voit bien que les variables **Area**, **Perimeter** et **Width**  sont bien représentées sur l'axe **Dim1** et **GrooveLength**, **Asymmetry** et **Compactness** sont mieux représenté sur l'axe **Dim2** mais avec des cos2 inférieurs à 0.5 pour **GrooveLength** et **Compactness** , on voit sur le cercle que les 3 premieres variables: **Area**, **Perimeter** et **Width** contribuent  le mieux sur les axes et ont une meilleur qualité de représentation des variables sur le graphique de l’ACP	
#' 	
#' 	
#' #### Individu	
#' 	
#' #### Graphique : qualité et contribution	
#' 	
#' Comme on a beaucoup trop d'individu regardons les graphiques des individus qur les 5 individus les mieux représsentés	
#' 	
#' **Contribution sur Dim1 et Dim2**	
#' 	
ind = get_pca_ind(rec.pca)	
#' 	
#' 	
# Contribution totale sur PC1 et PC2	
a<-fviz_contrib(rec.pca, choice = "ind", axes = 1,xlim=c(0,5))	
b<-fviz_contrib(rec.pca, choice = "ind", axes = 2,xlim=c(0,5))	
c<-fviz_contrib(rec.pca, choice = "ind", axes = 1:2,xlim=c(0,5))	
a	
b	
#' 	
#' 	
plot_grid(c)	
	
#' 	
#' 	
#' **Qualité de représentation** 	
#' 	
#' 	
#' 	
a<-fviz_cos2(rec.pca, choice = "ind", axes = 2,xlim=c(0,5))	
b<-fviz_cos2(rec.pca, choice = "ind", axes = 1,xlim=c(0,5))	
c<-fviz_cos2(rec.pca, choice = "ind", axes = 1:2,xlim=c(0,5))	
a	
b	
	
#' 	
#' 	
#' 	
plot_grid(c)	
#' 	
#' Nous voyons que les grains **89 ,90 et 115** ont une meilleur contribution sur **Dim 1**, **19 95 et 152** sur **Dim 2** mais les 3 premiers contribuent mieux sur les 2 axes en meme temps.	
#' Nous voyons que les grains **58,49 et 6**ont unr meilleur qualité de représentation sur **Dim1**, **93 205 et 118** sur **Dim 2** et **61,164 et 177** sur les 2 axes en meme temps.	
#' 	
#' 	
#' **Conclusion**	
#' 	
#' Nous avons pu synthétiser l’information relative à 210 graines en 2 dimensions à partir des différentes variables avec une précision de **89%**.	
#' 	
#' \newpage	
#' 	
#' ## Données Crabes	
#' 	
#' ### Informations sur le jeu de données:	
#' 	
#' La base de données sur les crabes comporte 200 lignes et 8 colonnes, décrivant 5 mesures morphologiques sur 50 crabes de deux formes colorées et des deux sexes, de l'espèce Leptograpsus variegatus, collectées à Fremantle, Australie occidentale.	
#' 	
#' 	
#' Ce cadre de données contient les colonnes suivantes :	
#' 	
#' sp - "B" ou "O" pour bleu ou orange.	
#' 	
#' le sexe comme il est dit.	
#' 	
#' Index 1:50 à l'intérieur de chacun des quatre groupes.	
#' 	
#' FL Taille du lobe frontal (mm).	
#' 	
#' RW largeur arrière (mm).	
#' 	
#' Longueur de la carapace CL (mm).	
#' 	
#' Largeur de la carapace CW (mm).	
#' 	
#' Profondeur du corps BD (mm).	
#' 	
#' 	
#' tout au long de notre étude nous allons nous restreindre aux 5 variables **FL, RW, CL, CW et BD**	
#' 	
#' 	
crabs1<- read.table('Données/crabs.csv', header = T,sep=",")	
crabs2<-crabs1[,2:9]	
crabs<-crabs1[,5:9]	
##	
##names(crabs)<-c("Area","Perimeter","Compactness","Length", "Width","Asymmetry","GrooveLength")	
#head(crabs)	
	
#' 	
#' 	
#' **Nombres de Valeurs manquantes (nvm)**	
#' 	
#' 	
localiseNA<-is.na(crabs)	
NAvar<-apply(localiseNA,2,sum)	
#NAvar	
#' 	
#' |.|FL |RW| CL| CW |BD|	
#' |---|---|---|---|---|	
#' nvm|0| 0| 0| 0 |0|	
#' 	
#' ### Distributions des variables 	
#' 	
#' 	
boxplot(crabs, main= "Distibution des Variables")	
summary((crabs)) 	
#' 	
#' 	
#' 	
#' **Histogramme avec Ggplot**	
#' 	
#' 	
#' 	
	
a<-ggplot(crabs) + aes(x = FL) + geom_histogram(bins = 40)	
b<-ggplot(crabs) + aes(x = RW) + geom_histogram(bins = 40)	
c<-ggplot(crabs) + aes(x = CL) + geom_histogram(bins = 40)	
d<-ggplot(crabs) + aes(x = CW) + geom_histogram(bins = 40)	
e<-ggplot(crabs) + aes(x = BD) + geom_histogram(bins = 40)	
plot_grid(a,b,c,d,e)	
#' 	
#' **CL** et **CW** ont  une plus grande variabilité les boxplots semblent symétrique et montrent les différences des distributions; cependant le nombre de variable n'étant pas assez grand on ne peut pas émettre d'hypothèse concrète sur la normalité meme avec les histogrammes qui semblent etre symétrique	
#' \newpage	
#' 	
#' ### Corrélation entre nos variables et nuages de point	
#' 	
#' 	
#cor(crabs)	
#round(cor(crabs), digits = 2)	
#sort(abs(cor(crabs)[, 1]))	
#' 	
#' 	
#' |.|   FL |       RW   |     CL    |    CW   |     BD|	
#' |---|----|----|---|----|----|----|----|	
#' FL| 1,0000000 |0,9069876 |0,9788418| 0,9649558 |0,9876272|	
#' RW |0,9069876| 1,0000000 |0,8927430 |0,9004021| 0,8892054|	
#' CL |0,9788418 |0,8927430| 1,0000000| 0,9950225| 0,9832038|	
#' CW |0,9649558 |0,9004021 |0,9950225| 1,0000000 |0,9678117|	
#' BD |0,9876272| 0,8892054| 0,9832038| 0,9678117| 1,0000000|	
#' 	
#' On remarque que toutes nos variables sont bien corrélées entre elles 	
#' 	
#' 	
#' ### Analyse en Composantes Principales	
#' 	
#' 	
#' 	
#' 	
rec.pca<- PCA(crabs,scale.unit=T, ncp=5,graph=F)	
	
#' 	
#' 	
#' 	
eig.val<-get_eigenvalue(rec.pca)	
eig.val	
#' 	
#' 	
#' 	
#' Nous voyons ici que **Dim 1** à une valeur propres > 1. **Dim1** explique à elle seule 95.7% de la variance. En gardant les 2 premières composantes, on explique **98%** de la variance, et avec les 3 premières composantes plus de **99%** de la variance.  On va donc prendre en compte ces 2 axes. 	
#' 	
#' **Variables**	
#' 	
var = get_pca_var(rec.pca)	
##var$cos2	
##var$contrib	
#' 	
#' |.|cos2Dim.1 |cos2Dim.2 | contribDim.1| contribDim.2 |	
#' |----|----|----|---|---|---|	
#' FL| **0,9785672**| 0,002871189| **20,43435** | 1,892860|	
#' RW |0,8775551| **0,122355169** |18,32502 |**80,663877** |	
#' CL |**0,9835409** |0,010914009 |**20,53821**  |7,195170  |	
#' CW |0,9745407 |0,004947193 |20,35027  |3,261487| 	
#' BD |**0,9746309** |0,010597646 |**20,35215** | 6,986605 |	
#' 	
#' 	
	
a=fviz_pca_var(rec.pca, col.var = "cos2",	
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),	
             repel = TRUE # Évite le chevauchement de texte	
             )	
b=fviz_pca_var(rec.pca, col.var = "contrib",	
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),	
             repel = TRUE # Évite le chevauchement de texte	
             )	
plot_grid(a,b)	
#' 	
#' Au vue du tableau et des cercles de coorrélation ont voit que les variables **RW** et **CL** présentent une meilleure contribution et qualité de représentation sur nos 2 axes	
#' 	
#' \newpage	
#' **Graphes des Individus**	
#' Contribution et qualité 	
#' 	
ind = get_pca_ind(rec.pca)	
#' 	
#' 	
# Contribution totale sur PC1 et PC2	
a<-fviz_contrib(rec.pca, choice = "ind", axes = 1, top = 10,xlim=c(0,5))	
b<-fviz_contrib(rec.pca, choice = "ind", axes = 2, top = 10,xlim=c(0,5))	
c<-fviz_contrib(rec.pca, choice = "ind", axes = 1:2, top = 10,xlim=c(0,5))	
a	
b	
#' 	
#' 	
plot_grid(c)	
	
#' 	
#' 	
#' 	
a<-fviz_cos2(rec.pca, choice = "ind", axes = 2, top = 10,xlim=c(0,5))	
b<-fviz_cos2(rec.pca, choice = "ind", axes = 1, top = 10,xlim=c(0,5))	
c<-fviz_cos2(rec.pca, choice = "ind", axes = 1:2, top = 10,xlim=c(0,5))	
a	
b	
	
#' 	
#' 	
plot_grid(c)	
#' 	
#' 	
#' Nous voyons que les grains **89 ,90 et 115** ont une meilleur contribution sur **Dim 1**, **19 95 et 152** sur **Dim 2** mais les 3 premiers contribuent mieux sur les 2 axes en meme temps.	
#' Nous voyons que les grains **58,49 et 6**ont unr meilleur qualité de représentation sur **Dim1**, **93 205 et 118** sur **Dim 2** et **61,164 et 177** sur les 2 axes en meme temps.	
#' 	
#' **Conclusion**	
#' 	
#' Nous avons pu synthétiser l’information relative à 210 graines en 2 dimensions à partir des différentes variables avec une précision de **89%**.	
#' \newpage	
#' 	
#' 	
#' 	
#' ## Controverse sur la théorie de l’hérédité de Mendel	
#' 	
#' Danss cette partie j'ai seulemennt traité le jeux de données cotyledon 	
#' 	
#' 	
Cotyledon<- read.table('Données/Cotyledon.csv', header = TRUE,sep=";")	
	
#' 	
#' 	
#' ### Test d’ajustement au paramètre d’une loi binomiale sans approximation normale de la binomiale.	
#' 	
#' Pour ce test selon la colonne Set on effectue un test sur chaque selon la variable **Set** on utilise la commmande binom.test(p,n) n, notre échantillon total est de 122 qui correspond à la longueur de notre colonne 	
#' et p la proportion de chacun des 16 groupes de graine on obtient donc la probabilité de succès alternative. Hypothèse: H0 la probabilité de succes est égal à 0,5 et H1 le contraire	
#' 	
#' 	
a=table(Cotyledon$Set)	
#for (i in 1:16){	
  #  print(binom.test(as.integer(a[i]),length(Cotyledon$Set)))	
  #  }	
#' 	
#' 	
#' |Classe|Proportion /122 |Probabilité de Succès|	
#' |----|---|---|	
#' |1|8|0,06557377| 	
#' 2|7|0,05737701	
#' 3|4|0,03278689 	
#' 4|6|0,04918033	
#' 5|11|0,09016393	
#' 6|8|0,06557377	
#' 7|7|0,05737705 	
#' 8|9|0,07377049 	
#' 9|10|0,08196721 	
#' 10|9|0,07377049	
#' 11|3|0,02459016 	
#' 12|10|0,08196721 	
#' 13|9|0,07377049 	
#' 14|7|0,05737705 	
#' 15|9|0,07377049 	
#' 16|5|0,04098361 	
#' 	
#' et toutes les pvalue sont telle que p-value < 2.2e-16. On rejette Ho et on accepte H1	
#' 	
#' 	
#' ### Test de Kolmogorov Smirnov 	
#' 	
#' il s'agit d'un test pour tester qu’une statistique bien choisie suit une loi normale N (0, 1) il s'agit de notre hypothèse H0.	
#' Mais cette statistiques (échantillon) ne doit pas avoir de doublon . Ici nous avons fait les test de kolmogorov de nos 16 groupes pour les graines à caractere dominant et récursif	
#' 	
#' 	
d<-c()	
for (i in 1:16){	
Cotyledon1<- Cotyledon[Cotyledon$Set == i,]	
for(k in 1:length(Cotyledon1$r)){	
  for(j in (k+1):length(Cotyledon1$r)){	
    if((Cotyledon1$r[k]==Cotyledon1$r[j])&& (j<=length((Cotyledon1$r)))){	
      Cotyledon1$r[j]=Cotyledon1$r[k]+0.1 # On rajoute 0.1 a chaque doublon 	
    }	
  }	
}	
   #print(as.character(i))	
   a<-ks.test(Cotyledon1$r,"pnorm",mean=0,sd=1)	
#print(a)	
#print(Cotyledon1)	
}	
	
##Cotyledon2	
	
#' 	
#' POur les **Dominants**	
#' On obtient des p-values inférieur à 0.05 donc l'Hypothèse H0 est écartée.	
#' Pour les **récessifs**	
#' le **11** ème groupe a une p-value de 0.07 environ ce qui est supérieur l'hypotèse H0 n'est pas rejetée	
#' 	
#' 	
#' ### Test du khi2	
#' 	
#' On étudie l'influence du caractère dominants ou récessifs sur les ensembles de graines grouperpar la variable Set	
#' 	
#' Pour tester l’indépendance de deux variables qualitatives, on teste l’hypothèse nulle H0: “les deux variables sont indépendantes” contre l’hypothèse alternative H1 : “les deux variables ne sont pas indépendantes”. Pour cela, on construit la statistique de test suivante : 	
#' 	
#' On va effectuer un test de chi 2 sur les proportions (parmi toutes les graines) de caractères dominants et récessifs qui sont ici nos 2 variables qualitatives.	
#' 	
#' 	
#' 	
tab<-matrix(nrow=2, ncol=16)	
	
for (i in 1:16){	
    c<-Cotyledon[Cotyledon$Set==i ,]	
    tab[1,i]<-sum(c$D)	
    tab[2,i]<-sum(c$r)	
    }	
colnames(tab)<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)	
rownames(tab)<-c("Dominants","Récessifs")	
#' 	
#' 	
#' 	
#' 	
tab	
#' 	
#' 	
#' 	
#' 	
#' 	
#' 	
par(mfrow=c(1,2))	
	
barplot(tab[1,],main="Dominants")	
barplot(tab[2,],main="Récessifs")	
#' 	
#' 	
#' 	
#' 	
resultat<-chisq.test(tab)	
#' 	
#' 	
#' 	
#' 	
resultat	
#' 	
#' On obtient une p-value inférieur à 0.05 on rejette donc H0 au profit de H1.	
#' 	
