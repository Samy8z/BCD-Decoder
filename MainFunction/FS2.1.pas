program RevArr;
Type
ArrayInt = array of integer;
var
tmp, i, j :integer;
procedure RevArr(var arr:ArrayInt)
begin
    i:=1
    j:=Taille(arr)
    while (i < j) do
    begin
        tmp := arr[i];
        arr[i] := arr[j];
        arr[j] := tmp;
        i := i  +1;
        j := j - 1;
    end;
    
end;