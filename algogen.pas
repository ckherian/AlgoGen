program algogen;


Const
 Taille_pop=10;
 Nb_machines=5;

Type Tableau=array[1..Taille_pop,1..Nb_machines] of Integer;
Type Tab_competences=array[1..Nb_machines,1..Nb_machines] of real;
Type lig_tableau=array[1..Nb_machines] of Integer;
Type Tab_fitness=array[1..Taille_pop] of real;
Type Tab_proba=array[1..Taille_pop,1..2] of real;

{Calcul de la fitness de la ieme ligne du tableau T}
function fitness(i:Integer; T:Tableau; V:Tab_competences):real ;
var f:real;j:integer;
begin
f:=0;
for j:=1 to Nb_machines do
    f:=f+(V[j,T[i,j]]);
fitness:=f;
end;

{Remplissage du Tableau T}
procedure remplissage(var T:Tableau; V:Tab_competences; var F:Tab_fitness);

var i,j,k,r,val:integer;ligne:lig_tableau;
begin
  randomize;
  {Pour chacune des lignes du tableau}
  for k:=1 to Taille_pop do
  begin
      {Remplir une ligne}
     for i:=1 to Nb_machines do
      ligne[i]:=i;
     {Pratiquer des permutations sur cette ligne}
     for i:=Nb_machines downto 2 do
           begin
           r:=random(i)+1;

          val:=ligne[r];
          ligne[r]:=ligne[i];
          ligne[i]:=val;
     end;
     {Recopier cette ligne dans le tableau}
     for i:=1 to Nb_machines do
         T[k,i]:=ligne[i];

  end;
  for i:=1 to Taille_pop do
  F[i]:=fitness(i,T,V);
end;



{Selectionne les deux meilleurs genomes de la population}
procedure meilleur(T:tableau; var F:Tab_fitness;Var S:Tableau);
var max,i:integer;
begin
     max:=1;
     for i:=1 to Taille_pop do
         begin
         if F[i]>F[max] then max:=i;
         end;
     for i:=1 to Nb_machines do
         S[Taille_pop,i]:=T[max,i];
     F[Taille_pop]:=F[max];
end;

procedure selection(T:tableau; var S:Tableau; var F:tab_fitness);
var P:Tab_proba;
    i,m,w,k:integer;
    r,ftot:real;
    Faux:Tab_fitness;
begin
{calcul de ftot}
ftot:=0;
for i:=1 to Taille_pop do
begin
     ftot:=ftot+F[i];

end;

{remplissage du tableau P}
for i:=1 to Taille_pop do
begin
     P[i,1]:=1000*(F[i])/ftot;  {multiplication par 1000 car random entier }
     P[i,2]:=0;
     for k:=1 to i do
         P[i,2]:=P[i,2]+P[k,1];

end;
{selection}
for k:=1 to Taille_pop-1 do
begin
     r:=random(1000);
     m:=1;
     if r<P[1,2] then
     begin
          for w:=1 to Nb_machines do
          begin
              S[k,w]:=T[1,w];
          end;
          Faux[k]:=F[1];
     end
     else
     begin
          while (P[m,2]<r) and (m<Taille_pop) do
                    m:=m+1;
          for w:=1 to Nb_machines do
              S[k,w]:=T[m,w];
          Faux[k]:=F[m];
     end;


end;
for i:=1 to Taille_pop-1 do
         F[i]:=Faux[i];
end;




function present(S:Tableau; i,chiffre:integer):boolean;
var k:integer; trouve:boolean;
begin
     trouve:=false;
     while (k<=Nb_machines) and (trouve=false) do
     begin
          if S[i,k]=chiffre then trouve:=true;
          k:=k+1;
     end;
end;

{

procedure crossover(S,T:tableau; i:integer);
var k,j:integer; M:lig_tableau;
begin
     for k:=1 to Nb_machines do
     M[k]:=random(1);                       RANDOM???????+1????
     T[i,k]:=0;
     T[i+1,k]:=0;
     for k:=1 to Nb_machines do
     begin
          if M[k]=0 then S[i,k]:=T[i,k]
                    else S[i+1,k]:=T[j,k];
          if T[i,k]=0 then
          begin
               j:=1;
               while (present(S,i,T[i+1,j])) and (j<Nb_machines) do
                    j:=j+1;
               if j<=Nb_machines then
                    S[i,k]:=T[i+1,j];
          end
          else
          begin
               j:=0;
               while (present(S,i+1,T[i,j]) and (j<Nb_machines) do
                    j:=j+1;
               if j<=Nb_machines then
                    S[i+1,k]:=T[i,j];
          end;
end;

}



procedure mutation(S:tableau; i:integer);
var aux,r1,r2:integer;
begin
     randomize;
     r1:=random(Nb_machines+1);
     r2:=random(Nb_machines+1);
     aux:=S[i,r1];
     S[i,r1]:=S[i,r2];
     S[i,r2]:=aux;
end;






procedure operation(S:Tableau; pm,pc:real; var F:Tab_fitness; V:Tab_competences);
var i:integer; r:real;
begin
     {for i:=1 to Taille_pop-3 by 2 do
     begin
          r:=random(10000);                     +1????????????
          if r<pc then crossover(S,i,i+1);
          end;}
     for i:=1 to Taille_pop-3 do
     begin
          r:=random(10000);                {         +1????????????     }
          if r<pm then mutation(S,i);
          end;

     for i:=1 to Taille_pop do
         F[i]:=fitness(i,S,V);
end;














procedure affichage_tableau(T:Tableau; F:Tab_fitness);
var i,j:integer;
begin
    for i:=1 to Taille_pop do
    begin
        for j:=1 to Nb_machines do
            write(T[i,j],'|      ');
        write('||',F[i]);
        writeln;
    end;
end;


{Programme principal}
var i,j,compteur:integer;r,pm,pc:real;V:Tab_competences;T,S:Tableau; F:Tab_fitness;
begin
{writeln('Probabilite de mutation:'); readln(pm);
writeln('Probabilite de crossover:'); readln(pc); }

{remplissage tableau de competences}
   V[1,1]:=17.5;
   V[1,2]:=15;
   V[1,3]:=9;
   V[1,4]:=5.5;
   V[1,5]:=12;
   V[2,1]:=16;
   V[2,2]:=16.5;
   V[2,3]:=10.5;
   V[2,4]:=5;
   V[2,5]:=10.5;
   V[3,1]:=12;
   V[3,2]:=15.5;
   V[3,3]:=14.5;
   V[3,4]:=11;
   V[3,5]:=5.5;
   V[4,1]:=4.5;
   V[4,2]:=8;
   V[4,3]:=14;
   V[4,4]:=17.5;
   V[4,5]:=13;
   V[5,1]:=13;
   V[5,2]:=9.5;
   V[5,3]:=8.5;
   V[5,4]:=12;
   V[5,5]:=17.5;



{remplissage tableau T}
writeln('Algo Genetique Power');
remplissage(T,V,F);
affichage_tableau(T,F);


{
compteur:=1;
repeat}

meilleur(T,F,S);
selection(T,S,F);
writeln('apres la selection');
affichage_tableau(S,F);
writeln;
operation(S,pm*10,pc,F,V);

{compteur:=compteur+1;
until compteur:=20}
writeln('apres operation');
{affichage_tableau(S,F);}
readln;
end.
