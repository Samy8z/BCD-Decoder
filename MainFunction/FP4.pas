program ConvDispArr;
Type

tableau = array [1..4] of boolean;
ArrayTableau= = array of tableau;
tab = array [1..7] of boolean:
ArrayTab = array of tab;

var
    a,b,c,d: boolean;
    i,t: integer;

procedure ConvDispArr (var binArr: ArrayTableau; var dispArr:tab);

begin
    t := Taille(binArr);
    for i := 1 to t do
    begin
        
    
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
end;