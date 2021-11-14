program RevArr;

// Trois types d'erreurs possibles :
// F -> Forme : Pas nécessaire à la machine, mais meilleur à la lecture
// S -> Syntaxe : Erreur pour la machine
// L -> Logique : Ca marche, mais pas comme voulu

// Les corrections sont indiquées sous la forme :
// C: Original -> Corigée
// C: Description de l'ajout

// Je répète pas les erreurs de style d'avant, mais elles sont quand même corrigées

type
    ArrayInt = array of integer;

var
    // F: Très mineur, mais séparer les variables selont leur utilisation peut être mieux à lire (j'avais oublié de le faire sur la fiche)
    // Ici, i et j sont des compteurs, et temp une variable de stockage temporaire
    // C: temp à maintenant sa propre ligne
    i, j: integer;
    temp: integer;

// S: On met un point virgule à la fin d'une définition de procédure (même si je suppose que c'est juste un oubli)
// C: Ajout d'un point virgule
procedure RevArr(var arr: ArrayInt);
begin
    // S: Il manque les points virgules de fin de ligne
    // C: Ajout des point virgule
    i := 1;
    j := Length(arr);

    while (i < j) do
    begin
        tmp := arr[i];
        arr[i] := arr[j];
        arr[j] := tmp;

        // F: C'est bien de séparer la partie process de la boucle de la partie itération avec un peu de vide
        // C: Ajout d'une lignes vide
        i := i + 1;
        j := j - 1;
    end;
end.