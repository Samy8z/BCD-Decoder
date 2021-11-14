program IntToDigitArr;
type
ArrayInt = array of integer;
var
i:integer

procedure IntToDigitArr (n:integer;var digitArr:ArrayInt);
begin
    
 FixerTaille(digitArr,0);
 i := 0;
    repeat 
        i := i + 1;
        FixerTaille(digitArr,i)
        digitArr[i] := n mod 10
        n := n div 10
    until n = 0
    RevArr(digitArr)
end;
