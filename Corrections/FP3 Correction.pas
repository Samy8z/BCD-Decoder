program DigitArrToBinArr;

// Trois types d'erreurs possibles :
// F -> Forme : Pas nécessaire à la machine, mais meilleur à la lecture
// S -> Syntaxe : Erreur pour la machine
// L -> Logique : Ca marche, mais pas comme voulu

// Les corrections sont indiquées sous la forme :
// C: Original -> Corigée
// C: Description de l'ajout



// F: Case soit minuscule, soit majuscule pour les identifiants
type // C: Type -> type
// F: On indente pour bien séparer les types
// C: Identation des lignes
    arrayInt = array of integer;

    // F: Ces deux noms ne décrivent pas bien ce que représente chaque type
    // C: tableau, ArrayTableau -> nibble, arrayNibble (Un nibble est 4 bits)
    nibble = array [1..4] of boolean;
    arrayNibble = array of nibble;

// F: Un retour à la ligne + indentation et meilleur, surtout avec un grand nombre de variables
// C: Ajout d'une indentation
var
    i, t : integer;

procedure DigitArrToBinArr(var digitArr: arrayInt; var binArr: arrayNibble);
begin
    t := taille(digitArr);
    FixeTaille(binArr,t)
    // S: La variable n'est pas initialisée
    // F: La taille du tableau est calculée à nouveau, alors qu'elle est déjà dans t
    // C: i := -> i := 0 - taille(digitArr) -> t
    for i := 0 to t - 1 do
    begin
        ConvBin(digitArr[i], binArr[i])
    end;
// S: Un programme Pascal se finit comme une phrase, par un point.
// C: end; -> end.
end.