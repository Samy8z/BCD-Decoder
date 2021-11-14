program DigitArrToBinArr;
Type
ArrayInt = array of integer;
tableau = array [1..4] of boolean;
ArrayTableau= = array of tableau;
var i, t : integer;

procedure DigitArrToBinArr(var digitArr:ArrayInt;var binArr:ArrayTableau);
begin
    t := taille(digitArr);
    FixeTaille(binArr,t)
    for i:=0 to taille(digitArr) - 1 do
    begin
        ConvBin(digitArr[i],binArr[i])
    end;
end;