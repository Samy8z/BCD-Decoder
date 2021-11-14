program ConvBin;
type
binReprArr = array [1..4] of boolean;
var
i:integer;

procedure ConvBin(n:integer;var bin:BinReprArr);
begin
    i:=4;
    repeat
        bin[i] := n mod 2 = 1;
        n := n div 2
        i := i - 1;
    until n = 0;
end;