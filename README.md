# AlgoGen
Genetic algorithm in Pascal to solve a salesman problem, project done in 2003

Project description and results in French:



Algorithmes génétiques appliqués à un problème d’affectation


Catherine KHERIAN – 2002/2003


 
Sommaire :


I.	Position du problème d’affectation	1

II.	Principe des algorithmes génétiques	2
1.	Vocabulaire employé	2
2.	Fonctionnement de l’algorithme	2

III.	Opérations Génétiques	4
1.	La sélection	4
2.	Le croisement	5
3.	La mutation	6

IV.	Interprétation des résultats	7
1.	Convergence des générations	7
2.	Influence des paramètres	8

V.	Conclusion	12

Annexe	13
1.	Tableau du problème d’affectation 20/20	13
2.	Algorithme génétique	14
3.	Bibliographie	22
4.	Sites internet	22
5.	Contacts	22

 
I.	Position du problème d’affectation


On cherche à résoudre un problème d’affectation simple, applicable à de nombreux domaines, sous le modèle suivant : on possède autant d’opérateurs que de machines, on connaît la performance de chaque opérateur sur chaque machine (sous la forme d’un tableau par exemple, présenté ci-dessous) et on veut affecter chaque homme à une unique machine pour avoir un rendement optimal (défini ici comme la somme de toutes les compétences).
	


Exemple de tableau de compétences pour 5 hommes et 5 machines :

Opé./Mach	1	2	3	4	5
A	17.5	15	9	5.5	12
B	16	16.5	10.5	5	10.5
C	12	15.5	14.5	11	5.5
D	4.5	8	14	17.5	13
E	13	9.5	8.5	12	17.5



Une solution possible serait donc exprimée par exemple sous la forme A4
-B1-C5-D2-E3 ou plus simplement sous la forme 4-1-5-2-3 :

 

On remarque que sous cette forme, une solution est une suite de chiffres où tous les chiffres de 1 à 5 apparaissent une et une seule fois, et où l’ordre de ces chiffres définit totalement la solution. On notera par la suite une solution réalisable au problème sous cette forme.

 
II.	Principe des algorithmes génétiques


Les algorithmes génétiques font partie de ce qu’on appelle les algorithmes évolutionnistes : ils se basent sur l’évolution naturelle, et plus précisément sur la théorie de Darwin « survival of the fittest » c’est à dire la sélection naturelle, élaborée en 1859 ; les individus les plus adaptés à l’environnement vivent plus longtemps et sont amenés à se reproduire davantage donc à se perpétrer. 
En 1962, John Holland puis David Goldberg imaginent de transposer les techniques propres à la génétique à la résolution de problèmes très variés : le principe est de générer des solutions potentielles (qu’on assimilera à des individus), de les évaluer, de sélectionner les meilleures, de les croiser et de les muter. 


1.	Vocabulaire employé

Chaque solution réalisable est un individu : par exemple « 4-5-1-2-3 »
Chaque chiffre ‘4’, ‘5’… est un gène, ce sont les gènes que l’on va manipuler lors des croisements et mutations.
Chaque ensemble d’individus est appelé population, et les populations que l’on va obtenir après les manipulations génétiques sont appelées générations.
La fitness (ou fonction d’évaluation) est la fonction qui évaluera chaque solution. Dans le cas présent, ce sera la somme des rendements de l’affectation de chaque opérateur. Si on revient sur le tableau d’exemple, la fitness de la solution 4-5-1-2-3 sera la somme des valeurs correspondantes dans le tableau : 5.5+16+5.5+8+8.5=43.5
La fitness est la fonction que l’algorithme cherche à maximiser puisqu’elle représente le rendement d’une affectation réalisable.


2.	Fonctionnement de l’algorithme

On génère une population initiale : ce sont des solutions créées aléatoirement mais qui sont possibles (donc de la forme voulue). Cette population est la première génération, elle est généralement médiocre, et les opérations successives la feront évoluer et s’améliorer.



Par exemple si on choisit de travailler avec une population de 4 individus, la population initiale pourra être par exemple l’ensemble : 



Individus	Fitness
4-5-2-3-1	58.5
2-3-5-1-4	47.5
5-1-2-3-4	69.5
5-4-2-1-3	45.5



 Pour chaque génération k, on passe à la génération k+1 ainsi :



Génération k

Sélection

Opérations

Génération k+1
 
III.	Opérations Génétiques


1.	La sélection

La sélection correspond à la sélection naturelle : les individus ayant une fitness élevée ont plus de chance de survivre, donc de se perpétrer à la génération suivante. Pour ce problème, on utilise la technique de la « roue de la fortune » (roulette wheel).

Chaque individu possède une probabilité d’être choisi proportionnelle à sa fitness : p(ind)=fitness(ind)/(fitness totale) où la fitness totale est la somme des fitness de tous les individus de la population. Par exemple pour l’individu 1 de la population initiale, sa probabilité d’être choisi sera 58.5/221=0.265

On assimile ensuite la population à un segment divisé en portions correspondant aux individus. Plus la probabilité d’être choisi d’un individu est grande, plus sa portion de segment est grande.

 

|_______________|_________|________________|__________|
0    individu1            individu 2           individu 3        individu 4    1

                                                      


Ensuite on tire un nombre au hasard entre 0 et 1, et on sélectionne l’individu dans la portion duquel le nombre est tombé. Ici le nombre (illustré par la flèche) tombe sur la portion correspondant à l’individu 3 donc celui-ci sera sélectionné.


On tire ainsi autant d’individus qu’il y en a dans une génération. Ainsi, on aura sans doute plusieurs fois les même individus, et des individus majoritairement « bons ». Cependant pour être sûr d’obtenir une génération suivante aussi bonne que la précédente, on recopie automatiquement le meilleur individu de la génération précédente dans la nouvelle génération.






2.	Le croisement

Le croisement (ou crossing-over) correspond à la reproduction sexuée : parmi les individus sélectionnés, on choisit 2 individus « parents » et on va croiser leurs gènes afin d’obtenir 2 nouveaux individus « enfants ».

Dans la plupart des problèmes, on peut simplement prendre une séquence d’un parent et compléter par une autre séquence du deuxième parent : par exemple on décide de couper les parents après le 3ème gène, on obtient alors

Parent1 : 1-2-3-4-5			Enfant1 : 1-2-3-2-1			
Parent2 : 5-4-3-2-1			Enfant2 : 5-4-3-4-5

Malheureusement, on ne peut pas utiliser cette méthode ici puisque on obtiendrait des enfants irréalisables : le même chiffre peut apparaître deux fois, or ceci voudrait dire affecter la même machine à deux opérateurs différents. Il faut donc utiliser une autre méthode de croisement qui évitera la répétition de gènes.

On utilise alors une méthode avec un masque : un masque binaire est généré aléatoirement, les emplacements des ‘1’ (respectivement ‘0’) correspondront aux emplacements où les gènes du parent 1 (resp. parent 2) seront recopiés tels quels dans l’enfant 1 (resp. enfant 2). 

Masque     1 - 1 – 0 – 1 - 0

Parent 1    5 – 1 – 2 – 3 - 4
Parent 2    4 – 5 – 2 – 3 - 1

Enfant 1    5 – 1 -     - 3 -  
Enfant 2       -    -  2 -    - 1


Les emplacements restants seront remplis avec les chiffres manquants, mais dans l’ordre où ils apparaissent chez l’autre parent : pour l’enfant 1 il manque les chiffres ‘1’ et ‘4’. Or ils sont dans l’ordre ‘4’-‘1’ chez le parent 2 donc ils seront remplis dans cet ordre :

Enfant 1 :    5 – 1 – 4 – 3 – 2

Pour l’enfant 2, il manque les chiffres ‘3’, ‘4’, ‘5’, et ceux-cis apparaissent dans l’ordre ‘5’-‘3’-‘4’ chez le parent 1 donc ils seront mis dans cet ordre :

Enfant 2 :    5 – 3 – 2 – 4 – 1

 
On obtient donc des solutions réalisables, qui remplacent leurs parents dans la nouvelle génération. Chaque individu a environ 80% de chances d’être croisé lors du passage à la génération suivante.



3.	La mutation

La mutation correspond aux erreurs introduites lors du recopiage des gènes, ici elle est présentée sous la forme d’un échange de gènes ;

1-2-3-4-5	1-5-3-4-2

Ainsi, le nombre de gènes et le nombre d’apparition de chaque chiffre est conservé : on obtient donc des solutions réalisables. 

La mutation est rare (comme dans la réalité) : elle a lieu dans 0.5 à 3% des cas. Son principal rôle est de diversifier totalement les solutions, ainsi la population ne restera pas bloquée autour d’un maximum local et cela lui évitera de converger vers une solution qui ne serait pas la solution optimale.



 
IV.	Interprétation des résultats


1.	Convergence des générations


On juge généralement une génération par son meilleur individu. Puisqu’on garde à chaque fois le meilleur individu de la génération précédente, chaque génération est au moins aussi performante que la précédente. 
Si on note dans un fichier le meilleur rendement de chaque génération, on obtient une courbe convergeant vers le maximum. Cependant, puisque l’algorithme repose beaucoup sur le hasard, il faut l’exécuter plusieurs fois pour avoir des résultats représentatifs. 


On étudie par exemple la résolution d’un problème d’affectation pour 20 opérateurs et 20 machines dont le tableau de compétences est en annexe 1 (généré aléatoirement avec des nombres de 0 à 100). L’algorithme utilisé est écrit en Pascal (annexe 2), et c’est en modifiant certains paramètres que l’on obtiendra les statistiques désirées dans des fichiers Excel. 


Le graphique ci-dessous représente la convergence 20 essais de l’algorithme (chaque courbe fine correspond à une exécution de l’algorithme). Ces résultats pour environ 1000 générations sont obtenus en moins de 1 seconde sur un ordinateur de bureau ordinaire. Si on avait voulu résoudre le problème linéairement (en testant toutes les solutions réalisables et en donnant le maximum trouvé), il aurait fallu tester 20 ! = 2.4329.10^18 solutions, or là on en a testé 30*1000=30 000 seulement (chaque génération est constituée de 30 individus).


La courbe épaisse rouge représente la moyenne des 20 essais, et la courbe verte représente le meilleur rendement trouvé pour l’instant par l’algorithme (au cours d’autres essais), ce n’est donc peut-être pas l’optimum. 

 

L’algorithme est exécuté ici pour 1000 générations, ce qui me semblait être une valeur suffisante pour voir la convergence des solutions. J’ai obtenu la valeur maximale de 1827 en exécutant l’algorithme plusieurs fois pour 100 000 générations (environ 5 minutes) ou 1 000 000 générations, mais même sur de très nombreuses générations, l’algorithme ne trouve pas forcément de meilleures solutions que pour 1000 générations.


La condition de fin de l’algorithme peut être écrite de plusieurs manières, par exemple on peut donner une condition de convergence : si au bout d’un certain temps la solution maximale trouvée ne s’améliore pas, l’algorithme se termine. Cependant afin de pouvoir faire des tests et contrôler la durée du programme, j’ai plutôt choisi de demander à l’utilisateur au début de l’algorithme combien de générations il devait calculer. Ensuite, si on voit graphiquement que la solution continue d’augmenter régulièrement, il suffit d’exécuter l’algorithme de nouveau avec un nombre de générations plut important.


2.	Influence des paramètres


Taille de la population initiale

Pour une population initiale de 3, 10, 20, 50 et 100 individus, on effectue 20 exécutions de l’algorithme afin d’obtenir des courbes de résultats pour voir l’influence de ce paramètre. On fixe la probabilité de mutation à 1% et celle de croisement à 80%.

 

On voit donc qu’à partir d’une population de 20 individus, les résultats sont sensiblement les mêmes. Pour moins d’individus, les résultats sont nettement inférieurs pour un même nombre de générations. Cependant, il n’est pas nécessaire non plus d’utiliser une population trop importante puisque cela engendrait de nombreux calculs pour finalement aboutir à la même efficacité. On travaille donc ensuite avec une population initiale de 30 individus.




Probabilité de croisement

On fait maintenant varier la probabilité qu’a un individu d’être croisé pour passer à la génération suivante, avec les valeurs de 0, 5, 30, 60, 90 et 100%, en fixant la taille de la population initiale à 30 et la probabilité de mutation à 1%.

 

On remarque qu’à partir de 30%, les résultats sont semblables, et qu’à partir d’environ 900 générations tous les essais atteignent les mêmes valeurs, mais pour être conforme avec les valeurs habituelles de croisement des algorithmes génétiques (qui cherchent à être le plus proche de la réalité génétique), on choisit généralement la valeur de 80% pour assurer le renouvellement de la population.



Probabilité de mutation

Avec une taille initiale de 30 individus et une probabilité de croisement de 80%, on fait varier la probabilité de mutation : 0, 1, 3, 10, 80%.

 

Là également, à partir d’un seuil (1%), les résultats sont les mêmes. Cependant, s’il n’y avait aucunes mutations (courbe rouge), l’algorithme ne s’améliorerait pas réellement puisqu’il s’attacherait à un maximum local (environ 1600) et la population ne serait pas assez variée. Pour respecter les valeurs « naturelles », on choisit généralement la probabilité de mutation très faible, ici à 1%.
 
V.	Conclusion


Même si aucune loi générale n’a été trouvée pour l’instant pour décrire la convergence des algorithmes génétiques, leur efficacité semble montrée pour un problème d’affectation. Ils donnent accès à des solutions tout à fait convenables en un temps très réduit, et même en arrêtant l’algorithme à tout moment on obtient de bonnes solutions, contrairement à certains algorithmes comme la méthode hongroise qui nécessitent de nombreux calculs avant d’arriver à une solution. 

L’avantage des algorithmes génétiques réside surtout dans le fait qu’ils sont applicables à presque tous les domaines, et leur codage n’est pas très complexe, mis à part les opérateurs qu’il faut adapter à la nature du problème. Ils ont par exemple servi à la gestion de gazoducs ou à l’optimisation de l’aérodynamisme des ailes d’avions, puisque leurs résultats sont assez intéressants pour les problèmes d’optimisation (problème du sac à dos, du voyageur de commerce…) 

Plus récemment, ils ont permis l’élaboration de filtres électroniques : en plaçant différents condensateurs, bobines et résistances, un algorithme a « retrouvé » en quelques jours tous les filtres brevetés depuis le début du siècle, et en a même trouvé d’encore plus performants. Ils sont alors susceptibles d’être brevetés comme les premières inventions faites par des machines.

Dans le domaine de l’intelligence artificielle, les algorithmes évolutionnistes et génétiques sont également très présents. A l’université de Göteborg, un robot doté d’ailes en bois a réussi en 3 heures à reconstituer le battement d’ailes lui permettant de voler : il pouvait bouger ses ailes comme il voulait et ses capteurs mesuraient alors l’altitude qu’il prenait. Il a d’abord fait des mouvements brusques pour induire en erreur ses capteurs, puis s’est appuyé sur un livre qui traînait pour se hisser, et enfin a battu ses ailes symétriquement et a reproduit le battement d’ailes naturel. Que les robots puissent ainsi s’adapter et prendre des décisions est très utile pour faire face à tout sortes d’obstacles, par exemple lors de l’exploration de planètes.
 
Annexe



1.	Tableau du problème d’affectation 20/20





Opé./mach.	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20
1	99	15	75	9	71	76	84	94	10	9	8	89	71	81	50	36	80	76	77	26
2	3	8	79	35	25	88	54	99	12	25	97	88	21	9	78	70	13	80	26	10
3	40	67	33	1	29	17	66	7	44	82	19	46	42	12	68	51	50	12	23	60
4	51	56	25	95	22	6	32	67	3	57	83	61	28	77	63	97	6	45	6	43
5	99	79	71	100	5	53	68	27	38	11	59	79	48	34	20	58	59	45	32	72
6	95	90	17	33	21	30	2	55	37	27	78	21	46	21	63	4	85	58	71	77
7	81	17	9	76	10	81	59	27	93	39	34	3	42	6	56	89	67	60	76	76
8	55	0	34	18	59	86	53	72	68	1	63	57	10	10	39	1	59	57	43	60
9	16	69	19	84	72	95	28	83	20	9	1	60	91	63	64	34	52	2	64	38
10	64	48	51	77	32	31	55	51	39	64	63	64	68	15	64	25	54	62	77	99
11	10	68	81	3	23	88	63	66	15	34	84	59	48	83	30	33	25	67	65	6
12	66	50	40	49	1	43	85	11	80	49	87	49	48	58	50	11	80	42	91	57
13	31	50	27	67	17	86	14	73	91	78	25	40	50	11	14	16	89	19	40	24
14	56	57	64	55	36	58	44	10	95	82	40	6	60	69	87	80	34	60	20	88
15	91	46	48	18	52	74	81	28	100	20	71	96	94	61	51	41	46	1	22	15
16	100	53	91	7	34	41	99	97	32	4	92	31	69	62	54	78	71	81	46	72
17	53	42	42	85	69	81	85	73	38	41	70	12	74	9	9	50	94	94	10	82
18	89	2	68	83	83	91	97	34	66	30	51	1	92	61	92	82	26	70	19	99
19	84	46	46	75	43	14	30	36	5	96	37	11	63	39	44	3	84	89	37	67
20	49	62	62	23	55	35	100	19	76	73	65	58	25	53	55	80	51	80	41	63



 
2.	Algorithme génétique



Program algogen;

{Déclarations}


Const
  Taille_pop = 30;
  Nb_machines = 20;
  NomFich = 'resultats.csv';

Type Tableau = array[1..Taille_pop,1..Nb_machines] Of Integer;

Type Tab_competences = array[1..Nb_machines,1..Nb_machines] Of real;

Type lig_tableau = array[1..Nb_machines] Of Integer;

Type Tab_fitness = array[1..Taille_pop] Of real;

Type Tab_proba = array[1..Taille_pop,1..2] Of real;



{Fonctions de calcul et détection}


{Calcul de la fitness (rendement) de la ieme ligne du tableau T}

Function fitness(i:Integer; T:Tableau; V:Tab_competences): real ;

Var f: real;
  j: integer;
Begin
  f := 0;
  For j:=1 To Nb_machines Do
    f := f+(V[j,T[i,j]]);
  fitness := f;
End;



{Selectionne le meilleur genome de la population et le met a la fin du nouveau tableau}

Procedure meilleur(T:tableau; Var F:Tab_fitness;Var S:Tableau);

Var max,i: integer;
Begin
     max := 1;
     For i:=1 To Taille_pop Do
         Begin
           If F[i]>F[max] Then max := i;
         End;
     For i:=1 To Nb_machines Do
         S[Taille_pop,i] := T[max,i];
     F[Taille_pop] := F[max];
End;


Function present(T:lig_tableau; nb:integer): boolean;

Var j: integer;
  trouve: boolean;
Begin
     J := 1;
     trouve := false;
     while (j<=Nb_machines) and (trouve=false) Do
     Begin
          If T[j]=nb Then trouve := true;
          j := j+1;
     End;
     present := trouve;
End;




{ Fonctions de manipulation de tableaux}


{Remplissage du Tableau T : tableau avec la génération initiale créée aléatoirement}

Procedure remplissage(Var T:Tableau; V:Tab_competences; Var F:Tab_fitness);

Var i,j,k,r,val: integer;
  ligne: lig_tableau;
Begin
  {Pour chacune des lignes du tableau}
  For k:=1 To Taille_pop Do
    Begin
      {Remplir une ligne}
      For i:=1 To Nb_machines Do
        ligne[i] := i;
     {Pratiquer des permutations sur cette ligne}
      For i:=Nb_machines Downto 2 Do
           Begin
             r := random(i)+1;
             val := ligne[r];
             ligne[r] := ligne[i];
             ligne[i] := val;
        End;
     {Recopier cette ligne dans le tableau}
      For i:=1 To Nb_machines Do
         T[k,i] := ligne[i];
    End;
  For i:=1 To Taille_pop Do
    F[i] := fitness(i,T,V);
End;




{ procédure de sélection des individus} 

Procedure selection(T:tableau; Var S:Tableau; Var F:tab_fitness);

Var P: Tab_proba;
    i,m,w,k: integer;
    r,ftot: real;
    Faux: Tab_fitness;
Begin
{calcul de ftot}
  ftot := 0;
  For i:=1 To Taille_pop Do
    Begin
      ftot := ftot+F[i];
    End;
{remplissage du tableau P}
  For i:=1 To Taille_pop Do
    Begin
      P[i,1] := 1000*(F[i])/ftot;  {multiplication par 1000 car random entier }
      P[i,2] := 0;
      For k:=1 To i Do
         P[i,2] := P[i,2]+P[k,1];
    End;
{selection}
  For k:=1 To Taille_pop-1 Do
    Begin
      r := random(1001);
      m := 1;
      If r<P[1,2] Then
        Begin
          For w:=1 To Nb_machines Do
            Begin
              S[k,w] := T[1,w];
            End;
          Faux[k] := F[1];
        End
      Else
        Begin
          while (P[m,2]<r) and (m<Taille_pop) Do
                    m := m+1;
          For w:=1 To Nb_machines Do
              S[k,w] := T[m,w];
          Faux[k] := F[m];
        End;
    End;
  For i:=1 To Taille_pop-1 Do
         F[i] := Faux[i];
End;




{procédure de croisement}

Procedure crossover(Var S:tableau; i:integer);

Var k,j: integer;
  M,T,U: lig_tableau;
Begin
     {cr‚ation du masque M}
     For j:=1 To Nb_machines Do
       Begin
          M[j] := random(2);
          T[j] := 0;
          U[j] := 0;
       End;
     For j:=1 To Nb_machines Do
       Begin
          If M[j]=0 Then
              T[j] := S[i,j]
          Else
              U[j] := S[i+1,j];
       End;

     For j:=1 To Nb_machines Do
       Begin
          If T[j]=0 Then
            Begin
               k := 1;
               while(present(T,S[i+1,k]))  Do
                  k := k+1;
               T[j] := S[i+1,k];
            End
          Else
            Begin
               k := 1;
              while(present(U,S[i,k]))  Do
                   k := k+1;
              U[j] := S[i,k];
            End;
       End;

     For j:=1 To Nb_machines Do
       Begin
          S[i,j] := T[j];
          S[i+1,j] := U[j];
       End;
End;



{procédure de mutation d’un individu}

Procedure mutation(Var S:tableau; i:integer);

Var aux,r1,r2: integer;
Begin
     r1 := random(Nb_machines)+1;
     r2 := r1;
     while (r2=r1) Do
     Begin
          r2 := random(Nb_machines)+1;
     End;
     aux := S[i,r1];
     S[i,r1] := S[i,r2];
     S[i,r2] := aux;
End;





{procédure qui décide si un individu est croisé avec un autre ou muté}

Procedure operation(Var S:Tableau; pm,pc:real; Var F:Tab_fitness; V:Tab_competences);

Var i: integer;
  r: integer;
Begin
     pm := pm*100;
     pc := pc*100;
     i := 1;
     while i<= (Taille_pop Div 2)-1 Do
                Begin
                  r := random(10000+1);
                  i := 2*i;
                  If r<pc Then
                    Begin
                      crossover(S,i);
                    End;
                  i := i Div 2;
                  i := i+1;
                End;


     For i:=1 To Taille_pop-1 Do
       Begin
          r := random(10000+1);
          If r<=pm Then mutation(S,i);
       End;

     For i:=1 To Taille_pop Do
         F[i] := fitness(i,S,V);
End;




{fonctions utilitaires}


{ Affiche un tableau et une fitness}

Procedure affichage_tableau(T:Tableau; F:Tab_fitness);

Var i,j: integer;
Begin
    For i:=1 To Taille_pop Do
      Begin
        For j:=1 To Nb_machines Do
            write(T[i,j],'|      ');
        write('||',F[i]);
        writeln;
      End;
End;





{ Recopie d'un tableau dans un autre}

Procedure copie_tableau(A:Tableau;Var B:Tableau);

Var i,j: integer;
Begin
    For i:=1 To Taille_pop Do
      Begin
        For j:=1 To Nb_machines Do
            B[i,j] := A[i,j];
        End;
End;



{Programme principal}

Var i,j,compteur,gene: integer;
  r,pm,pc: real;
  V: Tab_competences;
  T,S,X: Tableau;
  F: Tab_fitness;
  Test: lig_tableau;
  Fichier: Text;
  Erreur: Byte;
  txt: real;

Begin
{ Crée le fichier texte, puis l'ouvre en mode écriture }
  Assign (Fichier, NomFich);
  FileMode := 1;
  Rewrite (Fichier);


 randomize;
writeln('Probabilite de mutation:'); readln(pm);
writeln('Probabilite de crossover:'); readln(pc);
writeln('Nombre de g‚n‚rations:'); readln(gene);

{remplissage tableau de compétences}

v[1,1]:=99; v[1,2]:=15; v[1,3]:=75; v[1,4]:=9; v[1,5]:=71;
v[1,6]:=76; v[1,7]:=84; v[1,8]:=94; v[1,9]:=10; v[1,10]:=9;
v[1,11]:=8; v[1,12]:=89; v[1,13]:=71; v[1,14]:=81; v[1,15]:=50;
v[1,16]:=34; v[1,17]:=80; v[1,18]:=76; v[1,19]:=77; v[1,20]:=26;

v[2,1]:=3; v[2,2]:=8; v[2,3]:=79; v[2,4]:=35; v[2,5]:=25;
v[2,6]:=88; v[2,7]:=54; v[2,8]:=99; v[2,9]:=12; v[2,10]:=25;
v[2,11]:=97; v[2,12]:=88; v[2,13]:=21; v[2,14]:=9; v[2,15]:=78;
v[2,16]:=70; v[2,17]:=13; v[2,18]:=80; v[2,19]:=26; v[2,20]:=10;

v[3,1]:=40; v[3,2]:=67; v[3,3]:=33; v[3,4]:=1; v[3,5]:=29;
v[3,6]:=17; v[3,7]:=66; v[3,8]:=7; v[3,9]:=44; v[3,10]:=82;
v[3,11]:=19; v[3,12]:=46; v[3,13]:=42; v[3,14]:=12; v[3,15]:=68;
v[3,16]:=51; v[3,17]:=50; v[3,18]:=12; v[3,19]:=23; v[3,20]:=60;

v[4,1]:=51; v[4,2]:=56; v[4,3]:=25; v[4,4]:=95; v[4,5]:=22;
v[4,6]:=6; v[4,7]:=32; v[4,8]:=67; v[4,9]:=3; v[4,10]:=57;
v[4,11]:=83; v[4,12]:=61; v[4,13]:=28; v[4,14]:=77; v[4,15]:=63;
v[4,16]:=97; v[4,17]:=6; v[4,18]:=45; v[4,19]:=6; v[4,20]:=43;

v[5,1]:=99; v[5,2]:=79; v[5,3]:=71; v[5,4]:=100; v[5,5]:=5;
v[5,6]:=53; v[5,7]:=68; v[5,8]:=27; v[5,9]:=38; v[5,10]:=11;
v[5,11]:=59; v[5,12]:=79; v[5,13]:=48; v[5,14]:=34; v[5,15]:=20;
v[5,16]:=58; v[5,17]:=59; v[5,18]:=45; v[5,19]:=32; v[5,20]:=72;

v[6,1]:=95; v[6,2]:=90; v[6,3]:=17; v[6,4]:=33; v[6,5]:=21;
v[6,6]:=30; v[6,7]:=2; v[6,8]:=55; v[6,9]:=37; v[6,10]:=27;
v[6,11]:=78; v[6,12]:=21; v[6,13]:=46; v[6,14]:=21; v[6,15]:=63;
v[6,16]:=4; v[6,17]:=85; v[6,18]:=58; v[6,19]:=71; v[6,20]:=77;

v[7,1]:=81; v[7,2]:=17; v[7,3]:=9; v[7,4]:=76; v[7,5]:=10;
v[7,6]:=81; v[7,7]:=59; v[7,8]:=27; v[7,9]:=93; v[7,10]:=39;
v[7,11]:=34; v[7,12]:=3; v[7,13]:=42; v[7,14]:=6; v[7,15]:=56;
v[7,16]:=89; v[7,17]:=67; v[7,18]:=60; v[7,19]:=76; v[7,20]:=76;

v[8,1]:=55; v[8,2]:=0; v[8,3]:=34; v[8,4]:=18; v[8,5]:=59;
v[8,6]:=86; v[8,7]:=53; v[8,8]:=72; v[8,9]:=68; v[8,10]:=1;
v[8,11]:=63; v[8,12]:=57; v[8,13]:=10; v[8,14]:=10; v[8,15]:=39;
v[8,16]:=1; v[8,17]:=59; v[8,18]:=57; v[8,19]:=43; v[8,20]:=60;

v[9,1]:=16; v[9,2]:=69; v[9,3]:=19; v[9,4]:=84; v[9,5]:=72;
v[9,6]:=95; v[9,7]:=28; v[9,8]:=83; v[9,9]:=20; v[9,10]:=9;
v[9,11]:=1; v[9,12]:=60; v[9,13]:=91; v[9,14]:=63; v[9,15]:=64;
v[9,16]:=34; v[9,17]:=52; v[9,18]:=2; v[9,19]:=64; v[9,20]:=38;

v[10,1]:=64; v[10,2]:=48; v[10,3]:=51; v[10,4]:=77; v[10,5]:=32;
v[10,6]:=31; v[10,7]:=55; v[10,8]:=51; v[10,9]:=39; v[10,10]:=64;
v[10,11]:=63; v[10,12]:=64; v[10,13]:=68; v[10,14]:=15; v[10,15]:=64;
v[10,16]:=25; v[10,17]:=54; v[10,18]:=62; v[10,19]:=77; v[10,20]:=99;

v[11,1]:=10; v[11,2]:=68; v[11,3]:=81; v[11,4]:=3; v[11,5]:=23;
v[11,6]:=88; v[11,7]:=63; v[11,8]:=66; v[11,9]:=15; v[11,10]:=34;
v[11,11]:=84; v[11,12]:=59; v[11,13]:=48; v[11,14]:=83; v[11,15]:=30;
v[11,16]:=33; v[11,17]:=25; v[11,18]:=67; v[11,19]:=65; v[11,20]:=6;

v[12,1]:=66; v[12,2]:=50; v[12,3]:=40; v[12,4]:=49; v[12,5]:=1;
v[12,6]:=43; v[12,7]:=85; v[12,8]:=11; v[12,9]:=80; v[12,10]:=49;
v[12,11]:=87; v[12,12]:=49; v[12,13]:=48; v[12,14]:=58; v[12,15]:=50;
v[12,16]:=11; v[12,17]:=80; v[12,18]:=42; v[12,19]:=91; v[12,20]:=57;

v[13,1]:=31; v[13,2]:=50; v[13,3]:=27; v[13,4]:=67; v[13,5]:=17;
v[13,6]:=86; v[13,7]:=14; v[13,8]:=73; v[13,9]:=91; v[13,10]:=78;
v[13,11]:=25; v[13,12]:=40; v[13,13]:=50; v[13,14]:=11; v[13,15]:=14;
v[13,16]:=16; v[13,17]:=89; v[13,18]:=19; v[13,19]:=40; v[13,20]:=24;

v[14,1]:=56; v[14,2]:=57; v[14,3]:=64; v[14,4]:=55; v[14,5]:=36;
v[14,6]:=58; v[14,7]:=44; v[14,8]:=10; v[14,9]:=95; v[14,10]:=92;
v[14,11]:=40; v[14,12]:=6; v[14,13]:=60; v[14,14]:=69; v[14,15]:=87;
v[14,16]:=80; v[14,17]:=34; v[14,18]:=60; v[14,19]:=20; v[14,20]:=88;

v[15,1]:=91; v[15,2]:=46; v[15,3]:=48; v[15,4]:=18; v[15,5]:=52;
v[15,6]:=74; v[15,7]:=81; v[15,8]:=28; v[15,9]:=100; v[15,10]:=20;
v[15,11]:=71; v[15,12]:=96; v[15,13]:=94; v[15,14]:=61; v[15,15]:=51;
v[15,16]:=41; v[15,17]:=46; v[15,18]:=1; v[15,19]:=22; v[15,20]:=15;

v[16,1]:=100; v[16,2]:=53; v[16,3]:=91; v[16,4]:=7; v[16,5]:=34;
v[16,6]:=41; v[16,7]:=99; v[16,8]:=97; v[16,9]:=32; v[16,10]:=4;
v[16,11]:=92; v[16,12]:=31; v[16,13]:=69; v[16,14]:=62; v[16,15]:=54;
v[16,16]:=78; v[16,17]:=71; v[16,18]:=81; v[16,19]:=46; v[16,20]:=72;

v[17,1]:=53; v[17,2]:=42; v[17,3]:=42; v[17,4]:=85; v[17,5]:=69;
v[17,6]:=81; v[17,7]:=85; v[17,8]:=73; v[17,9]:=38; v[17,10]:=41;
v[17,11]:=70; v[17,12]:=12; v[17,13]:=74; v[17,14]:=9; v[17,15]:=9;
v[17,16]:=50; v[17,17]:=94; v[17,18]:=94; v[17,19]:=10; v[17,20]:=82;

v[18,1]:=89; v[18,2]:=2; v[18,3]:=68; v[18,4]:=83; v[18,5]:=83;
v[18,6]:=91; v[18,7]:=97; v[18,8]:=34; v[18,9]:=66; v[18,10]:=30;
v[18,11]:=51; v[18,12]:=1; v[18,13]:=92; v[18,14]:=61; v[18,15]:=92;
v[18,16]:=82; v[18,17]:=26; v[18,18]:=70; v[18,19]:=19; v[18,20]:=99;

v[19,1]:=84; v[19,2]:=46; v[19,3]:=46; v[19,4]:=75; v[19,5]:=43;
v[19,6]:=14; v[19,7]:=30; v[19,8]:=36; v[19,9]:=5; v[19,10]:=96;
v[19,11]:=37; v[19,12]:=11; v[19,13]:=63; v[19,14]:=39; v[19,15]:=44;
v[19,16]:=3; v[19,17]:=84; v[19,18]:=89; v[19,19]:=37; v[19,20]:=67;

v[20,1]:=79; v[20,2]:=62; v[20,3]:=62; v[20,4]:=23; v[20,5]:=55;
v[20,6]:=35; v[20,7]:=100; v[20,8]:=19; v[20,9]:=76; v[20,10]:=73;
v[20,11]:=65; v[20,12]:=58; v[20,13]:=25; v[20,14]:=53; v[20,15]:=55;
v[20,16]:=80; v[20,17]:=51; v[20,18]:=80; v[20,19]:=41; v[20,20]:=63;
  



{remplissage tableau T}
  writeln('Debut Algorithme Génétique');
  remplissage(T,V,F);
  affichage_tableau(T,F);
  writeln('-----------');
  compteur := 1; {compte le nombre de générations}
  Repeat
      meilleur(T,F,S);
      selection(T,S,F);
      operation(S,pm,pc,F,V);
      copie_tableau(S,T);
      { Ecrit la meilleure fitness du tableau de cette génération dans une ligne du fichier}
      txt := F[Taille_pop];
      writeln(Fichier,txt);
      compteur := compteur+1;

  Until compteur=gene+1;

  writeln;
  meilleur(S,F,X);

{affichage de la meilleure combinaison trouvée et sa fitness}
  For j:=1 To Nb_machines Do
       	write(X[Taille_pop,j],'|      ');
  write('||',F[Taille_pop]);
  writeln;

  readln;

  Close (Fichier);
End.


 
3.	Bibliographie

- D.E. GOLDBERG, Genetic Algorithms in search, optimization and machine learning (Addison Wesley)
- D.A. COLEY, An introduction to Genetic Algorithms for scientists and engineers (World Scientific)
- T. BACK, Evolutionary algorithms in theory and practice (Oxford University Press)
- A. KAUFMANN, R. FAURE, Invitation à la recherche opérationnelle (Dunod)
- ICGA Proceedings of the Fifth International Conference on Genetic Algorithms (Morgan Kaufmann Publishers)
- J.R. KOZA, M.A. KEANE, M.J. STREETER, « Evolving inventions » (Scientific American, fev 2003)
- E. SENDER, « Les robots coupent le cordon » (Science et Avenir, nov 2002)
- « Jeu : la révolution ‘Ryzom’ » (Science et Vie junior, dec 2002)
- I. CHARON, A. GERMA, O. HUDRY, Méthodes d’optimisation combinatoire (Masson)


4.	Sites internet

http://www.eudil.fr/~vmagnin/coursag/
http://www.guill.net/reseaux/algogen.html
http://etna.int-evry.fr/~ap/EC-tutoriel/tutoriel.html
http://www.recherche.enac.fr/opti/papers/thesis/habit/main002.html
http://www.genetic-programming.com
http://www.nd.com/genetic/
http://www.rennard.org/alife
http://www.chez.com/produ/abdou/index.htm


5.	Contacts

- John R. KOZA, Professeur au Stanford Biomedical Informatics program et dans le département d’ingénierie électrique de Stanford
- Thomas BOURDEAUD’HUY , doctorant au Laboratoire d’automatique et d’informatique industrielle de Lille
- Alain PETROWSKI, ingénieur à France Télécom, membre de l’IEEE, professeur à INT et chercheur en informatique évolutionniste
- Jean-Philippe RENNARD, docteur en économie, ancien enseignant-chercheur à l’université de Grenoble, créateur d’un site internet consacré à la vie artificielle
- Marc SCHOENAUER, directeur de recherche à l’INRIA (projet fractales), professeur à l’Ecole Polytechnique
- Olivier SIGAUD, AnimatLab, Laboratoire d'Informatique de Paris 6 et  enseignant à l’ENSTA
