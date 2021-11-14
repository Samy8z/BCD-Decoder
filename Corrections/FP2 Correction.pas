program IntToDigitArr;

// Trois types d'erreurs possibles :
// F -> Forme : Pas nécessaire à la machine, mais meilleur à la lecture
// S -> Syntaxe : Erreur pour la machine
// L -> Logique : Ca marche, mais pas comme voulu

// Les corrections sont indiquées sous la forme :
// C: Original -> Corigée
// C: Description de l'ajout

// Je répète pas les erreurs de style d'avant, mais elles sont quand même corrigées

type
	arrayInt = array of integer;

var
	i: integer

procedure IntToDigitArr(n: integer; var digitArr: ArrayInt);
begin
	SetLength(digitArr, 0);
	i := 0;

	repeat
		// S: Il ne faut pas oublié les point-virgules
		// C: Ajout des point-virgules
		i := i + 1;
		SetLength(digitArr, i);

		digitArr[i] := n mod 10;
		n := n div 10;
	until n = 0
	RevArr(digitArr);
end;
