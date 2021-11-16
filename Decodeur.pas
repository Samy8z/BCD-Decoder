program Decodeur;

// Import du module d'affichage
uses
	Crt;

// Definition des types
type
	intArray = array of Int64;
	nibble = array [1..4] of boolean;
	nibbleArray = array of nibble;
	dispSegments = array [1..7] of boolean;
	dispSegmentsArray = array of dispSegments;


procedure TakeInput(var inputInt: Int64; var zoom, x, y: integer);
// TAKE_INPUT
// AL 2021-11-12
// Demande à l'utilisateur d'entrer un entier, un niveau de zoom, et des coordonnées
// IN: -
// OUT: inputInt, zoom, x, y
begin
	// On demande à l'utilisateur d'entrer les variables
	write('Enter a number, a zoom level, and coordinates: ');

	// Lecture des variables
	read(inputInt);
	read(zoom);
	read(x);
	readLn(y);
end;


procedure RevArray(var arr: intArray);
// REV_ARRAY
// AL 2021-11-12
// Inverse l'ordre des éléments d'un tableau
// IN: arr
// OUT: arr
var
	i, j: integer;
	tmp: integer;
begin
	// Initialisation des variables
	i := 0;
    j := Length(arr) - 1;


	// On bouge le curseur de début et de fin, jusqu'à ce qu'ils se croisent
    while (i < j) do
    begin
		// On échange les éléments
        tmp := arr[i];
        arr[i] := arr[j];
        arr[j] := tmp;

		// On incrémente et décrémente les curseurs
        i := i + 1;
        j := j - 1;
    end;

	// Autre version considérée, fonctionellement équivalente
	{ n := Length(arr);
	for i := 0 to (n div 2) - 1 do
	begin
		temp := arr[i];
		arr[i] := arr[n - 1 - i];
		arr[n - 1 - i] := temp;
	end; }
end;

procedure IntToDigitArr(inputInt: Int64; var digitArr: intArray);
// INT_TO_DIGIT_ARR
// AL 2021-11-12
// Transforme un entier en tableau de chiffres
// IN: inputInt
// OUT: digitArr
var
	n: integer;
begin
	// On initialise le tableau
	SetLength(digitArr, 0);

	// On boucle tant que l'entier n'est pas nul
	repeat
		// On ajoute une case de chiffre au tableau
		n := Length(digitArr);
		SetLength(digitArr, n + 1);

		// On récupère le chiffre des unités du nombre
		digitArr[n] := inputInt mod 10;
		// On divise le nombre par 10
		inputInt := inputInt div 10;
	until inputInt = 0;

	RevArray(digitArr);
end;


procedure ConvBin(digit: integer; var binRepr: nibble);
// CONV_BIN
// AL 2021-11-12
// Transforme un chiffre en tableau de 4 bits
// IN: digit
// OUT: binRepr
var
	i: integer;
begin
	i := 4;

	// On boucle tant que le chiffre n'est pas nul
	repeat
		// On récupère la valeur du bit
		binRepr[i] := digit mod 2 = 1;
		// On divise le chiffre par 2
		digit := digit div 2;

		// On décrémente le compteur
		i := i - 1;
	until digit = 0;

	// Étant sur du nombre de bits, on peut parcourir la liste à l'envers, pour éviter d'avoir à appeller RevArray
end;

procedure DigitArrToBinArr(var digitArr: intArray; var binReprArr: nibbleArray);
// DIGIT_ARR_TO_BIN_ARR
// AL 2021-11-12
// Transforme un tableau de chiffres en tableau de tableau de 4 bits
// IN: digitArr
// OUT: binReprArr
var
	i, t: integer;
begin
	// On initialise le tableau, en lui allouant la même taille que digitArr
	t := Length(digitArr);
	SetLength(binReprArr, t);

	// On boucle sur tous les chiffres du tableau
	for i := 0 to t - 1 do
		ConvBin(digitArr[i], binReprArr[i]);
end;


procedure ConvDispArr(var binReprArr: nibbleArray; var dispArr: dispSegmentsArray);
// CONV_DISP_ARR
// AL 2021-11-12
// Transforme un tableau de tableau de 4 bits en tableau de tableau de 7 bits pour l'affichage
// Le fait en utilisant les formules de Karnaugh
// IN: binReprArr
// OUT: dispArr
var
	a, b, c, d: boolean;
	i, t: integer;
begin
	// On initialise le tableau, en lui allouant la même taille que binReprArr
	t := Length(binReprArr);
	SetLength(dispArr, t);

	// On boucle sur toutes les représentations binaires
	for i := 0 to t - 1 do
	begin
		// Définition de raccourcis vers les bits
		a := binReprArr[i][1];
		b := binReprArr[i][2];
		c := binReprArr[i][3];
		d := binReprArr[i][4];

		// Application des formules de Karnaugh
		dispArr[i][1] := a or c or (d = b);
		dispArr[i][2] := (not b) or (c = d);
		dispArr[i][3] := b or (not c) or d;
		dispArr[i][4] := a or (not b) and (c or (not d)) or (b and (not c) and d) or (c and (not d));
		dispArr[i][5] := (not d) and ((not b) or c);
		dispArr[i][6] := a or b or ((not c) and (not d));
		dispArr[i][7] := a or b xor c or (c and (not d));
	end;
end;


procedure DrawRect(xStart, yStart, xSize, ySize: integer);
// DRAW_SQUARE
// AL 2021-11-12
// Dessine un carré dans la console
// IN: xStart, yStart, xSize, ySize
// OUT: -
var
	i, j: integer;
begin
	// On boucle sur les lignes
	for i := 0 to ySize - 1 do
		// On boucle sur les colonnes
		for j := 0 to xSize - 1 do
		begin
			// On va à la position courante, et on affiche '*'
			GotoXY(xStart + j, yStart + i);
			write('*');
		end;
end;

procedure DrawVLine(xStart, yStart, ySize: integer);
// DRAW_V_LINE
// AL 2021-11-12
// Dessine une ligne verticale
// IN: xStart, yStart, ySize
// OUT: -
begin
	// Un rectangle de largeur 1 est une ligne verticale
	DrawRect(xStart, yStart, 1, ySize);
end;

procedure DrawHLine(xStart, yStart, xSize: integer);
// DRAW_H_LINE
// AL 2021-11-12
// Dessine une ligne horizontale
// IN: xStart, yStart, xSize
// OUT: -
begin
	// Un rectangle de hauteur 1 est une ligne horizontale
	DrawRect(xStart, yStart, xSize, 1);
end;

procedure DrawNumbers(x, y, zoom: integer; var dispArr: dispSegmentsArray);
// DISPLAY_NUMBERS
// AL 2021-11-12
// Affiche les nombres dans la console
// IN: x, y, zoom, dispArr
// OUT: -
var
	i, t: integer;
begin
	// Pour chaque chiffre du nombre
	t := Length(dispArr);
	for i := 0 to t - 1 do
	begin
		// On affiche les segments, suivant le tableau
		if dispArr[i][1] then
			DrawHLine(x+1, y, zoom);
		if dispArr[i][2] then
			DrawVLine(x+zoom+1, y+1, zoom);
		if dispArr[i][3] then
			DrawVLine(x+zoom+1, y+zoom+2, zoom);
		if dispArr[i][4] then
			DrawHLine(x+1, y+zoom*2+2, zoom);
		if dispArr[i][5] then
			DrawVLine(x, y+zoom+2, zoom);
		if dispArr[i][6] then
			DrawVLine(x, y+1, zoom);
		if dispArr[i][7] then
			DrawHLine(x+1, y+zoom+1, zoom);
		
		// On décale l'affichage de 1 caractère
		x := x + zoom + 3;
	end;
end;


var
	// Variables entrées par l'utilisateur
	inputInt: Int64;
	zoom: integer;
	x, y: integer;

	// Variables utilisées par le programme
	isNeg: boolean;
	digitArr: intArray;
	binReprArr: nibbleArray;
	dispArr: dispSegmentsArray;

	// Utilisée seulement pour éviter l'arrêt imédiat du programme
	_: string;

begin
	// Data-in
	TakeInput(inputInt, zoom, x, y);

	{ Pas dans l'analyse, rajouté en bonus }
	// On gère le cas où l'entrée est négative
	isNeg := inputInt < 0;
	if isNeg then
		inputInt := -inputInt;

	// Décalage des coordonnées, pour correspondre à un système commençant en (0, 0)
	x := x + 1;
	y := y + 1;

	// Data-process
	IntToDigitArr(inputInt, digitArr);
	DigitArrToBinArr(digitArr, binReprArr);
	ConvDispArr(binReprArr, dispArr);

	// Data-out
	ClrScr;

	{ Pas dans l'analyse, rajouté en bonus }
	// Si l'entrée est négative, on affiche un '-'
	if isNeg then
	begin
		// On affiche le signe
		DrawHLine(x+1, y+zoom+1, zoom);

		// On décale l'affichage de 1 caractère
		x := x + zoom + 3
	end;

	DrawNumbers(x, y, zoom, dispArr);

	// Pour empêcher l'arrêt immédiat du programme
	read(_);
end.