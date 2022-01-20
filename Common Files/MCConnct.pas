unit MCConnct;

interface

Function EncodeText(AText:String):String;
Function DecodeText(AText:String):String;

implementation
Function EncodeText(AText:String):String;
Var
   LngTxt:              Byte;
   IndTxt:              Byte;
   Delta:               Byte;
   Extra:               Byte;
   Ghost:               Byte;
   Range:               Byte;
   Value:               String;
Begin
     Randomize;
     LngTxt := Length(AText);
     Delta  := 2;
     Value  := Chr(LngTxt+64);
     Extra  := Random(10) + 1;
     Range  := Ord('z')-Ord('0');
     For IndTxt := 1 To LngTxt Do Begin
         Repeat
               Ghost := Random(Range) + 48;
         Until Chr(Ghost) in ['0'..'9','A'..'Z','a'..'z'];
         Value := Chr(Ghost) + Chr(Ord(AText[IndTxt])-Delta) + Value;
         Dec(Delta);
     End;
     For IndTxt := 1 To Extra Do Begin
         Repeat
               Ghost := Random(Range) + 48;
         Until Chr(Ghost) in ['0'..'9','A'..'Z','a'..'z'];
         Value := Chr(Ghost) + Value;
     End;
     EncodeText := Value;
End;
Function DecodeText(AText:String):String;
Var
   LngTxt:              Byte;
   IndTxt:              Byte;
   Delta:               Byte;
   NumChr:              Byte;
   Value:               String;
Begin
     LngTxt := Length(AText);
     IndTxt := LngTxt -1;
     LngTxt := Ord(AText[LngTxt])-64;
     Value  := '';
     Delta  := 2;
     For NumChr := 1 To LngTxt Do Begin
         Value := Value + Chr(Ord(AText[IndTxt])+Delta);
         Dec(IndTxt,2);
         Dec(Delta);
     End;
     DecodeText := Value;
End;
end.
