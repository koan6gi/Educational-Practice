unit Playlist;

interface

uses
  AllTypesInProject;
Procedure SelectionSort(var L; const ArrIn: TArrayOfIndexes; CompareTo: FCompareTo);
Function ArtistCompareTo(Self, o: TAdrOfList; const ArrIn: TArrayOfIndexes): Boolean;

implementation

Procedure Swap(var I, J);
var
  Tmp: TAdrOfList;
  A: TAdrOfList absolute I;
  B: TAdrOfList absolute J;
begin
  Tmp := A^.next;
  A^.next := B^.next;
  B^.next := Tmp;

  Tmp := A^.next.next;
  A^.next.next := B^.next.next;
  B^.next.next := Tmp;
end;

Function ArtistCompareTo(Self, o: TAdrOfList; const ArrIn: TArrayOfIndexes): Boolean;
begin
  if o = nil then
    Result := False
  else
    Result := Self^.Artist.Direction > o^.Artist.Direction;
end;

Procedure FillArrOfIndexes(var L; var ArrIn:TArrayOfIndexes);
var
  List: TAdrOfList absolute L;
begin

end;

Function AlbumCompareTo(Self, o: TAdrOfList; const ArrIn: TArrayOfIndexes): Boolean;
begin
  if o = nil then
    Result := False
  else
    Result := Self^.Artist.Direction > o^.Artist.Direction;
end;

Procedure SelectionSort(var L; const ArrIn: TArrayOfIndexes; CompareTo: FCompareTo);
var
List: TAdrOfList absolute L;
  Tmp, ArtL: TAdrOfList;
begin
  while List^.next <> nil do
  begin
    Tmp := List;
    ArtL := List^.next;
    while ArtL^.next <> nil do
    begin
      if CompareTo(Tmp^.next, ArtL^.next, ArrIn) then
        Tmp := ArtL;

      ArtL := ArtL^.next;
    end;
    Swap(Tmp, List);
    List := List^.next;
  end;
end;

end.
