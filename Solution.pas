program Solution;

// Import du module d'affichage
uses
	Crt;

// Definition des types
type
	intArray = array of integer;
	nibble = array [1..4] of boolean;
	nibbleArray = array of nibble;
	dispArray = array [1..7] of boolean;
	dispArrayArray = array of dispArray;

procedure TakeInput(var inputInt, zoom, x, y: integer);
// TAKE_INPUT
// AL 2021-11-12
// Demande à l'utilisateur d'entrer un entier, un niveau de zoom, et des coordonnées
// IN: -
// OUT: inputInt, zoom, x, y
begin
	write('Enter a number, a zoom level, and coordinates: ');
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
	i, n: integer;
	temp: integer;
begin
	n := Length(arr);
	for i := 0 to (n div 2) - 1 do
	begin
		temp := arr[i];
		arr[i] := arr[n - 1 - i];
		arr[n - 1 - i] := temp;
	end;
end;

procedure IntToDigitArr(inputInt: integer; var digitArr: intArray);
// INT_TO_DIGIT_ARR
// AL 2021-11-12
// Transforme un entier en tableau de chiffres
// IN: inputInt
// OUT: digitArr
var
	n: integer;
begin
	SetLength(digitArr, 0);
	repeat
		n := Length(digitArr);
		SetLength(digitArr, n + 1);
		digitArr[n] := inputInt mod 10;
		inputInt := inputInt div 10;
	until inputInt = 0;
	RevArray(digitArr);
end;

procedure ConvBin(digit: integer; var bin: nibble);
// CONV_BIN
// AL 2021-11-12
// Transforme un chiffre en tableau de 4 bits
// IN: digit
// OUT: bin
var
	i: integer;
begin
	i := 4;
	repeat
		bin[i] := digit mod 2 = 1;
		digit := digit div 2;

		i := i - 1;
	until digit = 0;
end;


procedure DigitArrToBinArr(var digitArr: intArray; var binArr: nibbleArray);
// DIGIT_ARR_TO_BIN_ARR
// AL 2021-11-12
// Transforme un tableau de chiffres en tableau de tableau de 4 bits
// IN: digitArr
// OUT: binArr
var
	i: integer;
begin
	SetLength(binArr, 0);
	for i := 0 to Length(digitArr) - 1 do
	begin
		SetLength(binArr, Length(binArr) + 1);
		ConvBin(digitArr[i], binArr[i]);
	end;
end;

procedure ConvDispArr(var binArr: nibbleArray; var dispArr: dispArrayArray);
// CONV_DISP_ARR
// AL 2021-11-12
// Transforme un tableau de tableau de 4 bits en tableau de tableau de 7 bits pour l'affichage
// Le fait en utilisant les formules de Karnaugh
// IN: binArr
// OUT: dispArr
var
	a, b, c, d: boolean;
	i: integer;
begin
	SetLength(dispArr, 0);
	for i := 0 to Length(binArr) - 1 do
	begin
		a := binArr[i][1];
		b := binArr[i][2];
		c := binArr[i][3];
		d := binArr[i][4];

		SetLength(dispArr, Length(dispArr) + 1);

		dispArr[i][1] := a or c or (d = b);
		dispArr[i][2] := (not b) or (c = d);
		dispArr[i][3] := b or (not c) or d;
		dispArr[i][4] := a or (not b) and (c or (not d)) or (b and (not c) and d) or (c and (not d));
		dispArr[i][5] := (not d) and ((not b) or c);
		dispArr[i][6] := a or b or ((not c) and (not d));
		dispArr[i][7] := a or b xor c or (c and (not d));
	end;
end;

procedure DrawSquare(xStart, yStart, xSize, ySize: integer);
// DRAW_SQUARE
// AL 2021-11-12
// Dessine un carré dans la console
// IN: xStart, yStart, xSize, ySize
// OUT: -
var
	i, j: integer;
begin
	for i := 0 to ySize - 1 do
	begin
		for j := 0 to xSize - 1 do
		begin
			GotoXY(xStart + j, yStart + i);
			write('*');
		end;
	end;
end;

procedure DrawVLine(xStart, yStart, ySize: integer);
// DRAW_V_LINE
// AL 2021-11-12
// Dessine une ligne verticale
// IN: xStart, yStart, ySize
// OUT: -
begin
	DrawSquare(xStart, yStart, 1, ySize);
end;

procedure DrawHLine(xStart, yStart, xSize: integer);
// DRAW_H_LINE
// AL 2021-11-12
// Dessine une ligne horizontale
// IN: xStart, yStart, xSize
// OUT: -
begin
	DrawSquare(xStart, yStart, xSize, 1);
end;

procedure DrawNumbers(x, y, zoom: integer; var dispArr: dispArrayArray);
// DISPLAY_NUMBERS
// AL 2021-11-12
// Affiche les nombres dans la console
// IN: x, y, zoom, dispArr
// OUT: -
var
	i, t: integer;
begin
	t := Length(dispArr);
	for i := 0 to t - 1 do
	begin
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
		
		x := x + zoom + 3;
	end;
end;


var
	inputInt: integer;
	zoom: integer;
	x, y: integer;
	digitArr: intArray;
	binArr: nibbleArray;
	dispArr: dispArrayArray;
begin
	// Data-in
	TakeInput(inputInt, zoom, x, y);

	// Data-process
	IntToDigitArr(inputInt, digitArr);
	DigitArrToBinArr(digitArr, binArr);
	ConvDispArr(binArr, dispArr);

	// Data-out
	ClrScr;
	DrawNumbers(x, y, zoom, dispArr);

	// Pour empêcher l'arrêt immédiat du programme
	read(inputInt);
end.