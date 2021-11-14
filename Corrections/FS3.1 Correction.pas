program ConvBin;

// Trois types d'erreurs possibles :
// F -> Forme : Pas nécessaire à la machine, mais meilleur à la lecture
// S -> Syntaxe : Erreur pour la machine
// L -> Logique : Ca marche, mais pas comme voulu

// Les corrections sont indiquées sous la forme :
// C: Original -> Corigée
// C: Description de l'ajout

// Je répète pas les erreurs de style d'avant, mais elles sont quand même corrigées

type
    // F: Le nom représente mal le type, ici ce n'est qu'une representation binaire, plus exactement sur 4 bits, pas un tableau de ces représentations
    // Il est important de préciser dans le type que ça ne contient que 4 bits, car c'est pas utilisable avec plus
    // C: binReprArr -> nibble
    nibble = array [1..4] of boolean;
var
    i: integer;

procedure ConvBin(n: integer; var binRepr: nibble);
begin
    i := 4;

    repeat
        binRepr[i] := n mod 2 = 1;

        n := n div 2
        i := i - 1;
    until n = 0;
end.