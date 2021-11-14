program ConvDispArr;

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
	nibble = array [1..4] of boolean;
	arrayNibble = array of nibble;

	dispSegments = array [1..7] of bool;
	arrayDispSegments = array of dispSegments;


// 1ère partie : Correction suivant ce que je t'ai envoyé

// S: Il manque la déclaration de procédure
// C: Ajout de la déclaration
procedure ConvDispArr(var binArr: nibble: var dispArr: dispSegments);
var
	// F: C'est mieux de mettre un espace après une virgule et un deux points
	// C: Ajout des espaces
	a, b, c, d: boolean;
	i: integer;
begin
	// Pas une faute de ta part, mais dans ce cas, ici le [i] causerait une erreur, vu que l'on ne parcoure qu'un tableau unidimensionnel
    a := binArr[i][1];
	b := binArr[i][2];
	c := binArr[i][3];
	d := binArr[i][4];

	dispArr[i][1] := a or c or (d = b);
	dispArr[i][2] := (not b) or (c = d);
	dispArr[i][3] := b or (not c) or d;
	dispArr[i][4] := a or (not b) and (c or (not d)) or (b and (not c) and d) or (c and (not d));
	dispArr[i][5] := (not d) and ((not b) or c);
	dispArr[i][6] := a or b or ((not c) and (not d));
	dispArr[i][7] := a or b xor c or (c and (not d));
end;


// 2ème partie : Version suivant ce que j'ai oublié de t'envoyer

procedure ConvDispArr(var binArr: nibbleArray; var dispArr: dispSegmentsArray);
var
	a, b, c, d: boolean;
	i, t: integer;
begin
	t := Length(binArr);
	SetLength(dispArr, t);

	for i := 0 to t - 1 do
	begin
		// Définition de raccourcis vers les bits
		a := binArr[i][1];
		b := binArr[i][2];
		c := binArr[i][3];
		d := binArr[i][4];

		// Application des formules de Karnaugh
		dispArr[i][1] := a or c or (d = b);
		dispArr[i][2] := (not b) or (c = d);
		dispArr[i][3] := b or (not c) or d;
		dispArr[i][4] := a or (not b) and (c or (not d)) or (b and (not c) and d) or (c and (not d));
		dispArr[i][5] := (not d) and ((not b) or c);
		dispArr[i][6] := a or b or ((not c) and (not d));
		dispArr[i][7] := a or b xor c or (c and (not d));
	end;
end.