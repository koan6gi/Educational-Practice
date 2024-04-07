unit Playlist;

interface

uses
  AllTypesInProject;
Procedure RunTest(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);

implementation

Function Search(const ArrIn: TArrayOfIndexes; const item: Integer): Integer;
var
  Flag: Boolean;
  i: Integer;
begin
  i := Low(ArrIn);
  Flag := true;
  result := -1;
  while Flag and (i < High(ArrIn)) do
  begin
    if item = ArrIn[i] then
    begin
      result := i;
      Flag := false;
    end;
    Inc(i);
  end;

end;

Procedure Swap(var i, J);
var
  Tmp: TAdrOfList;
  A: TAdrOfList absolute i;
  B: TAdrOfList absolute J;
begin
  Tmp := A^.next;
  A^.next := B^.next;
  B^.next := Tmp;

  Tmp := A^.next.next;
  A^.next.next := B^.next.next;
  B^.next.next := Tmp;
end;

Function ArtistCompareTo(Self, o: TAdrOfList;
  const ArrIn: TArrayOfIndexes): Boolean;
begin
  if o = nil then
    result := false
  else
    result := Self^.Artist.Direction > o^.Artist.Direction;
end;

Procedure FillArrOfIndexes(var L; var ArrIn: TArrayOfIndexes);
var
  List: TAdrOfList;
  i: Integer;
begin
  List := TAdrOfList(L);
  i := 0;
  while List^.next <> nil do
  begin
    List := List^.next;
    if i > High(ArrIn) then
      Add10(ArrIn);
    ArrIn[i] := List^.Artist.ID;
    Inc(i);
  end;
end;

Function AlbumCompareTo(Self, o: TAdrOfList;
  const ArrIn: TArrayOfIndexes): Boolean;
var
  P: Boolean;
begin
  if o = nil then
    result := false
  else
  begin
    P := Search(ArrIn, Self^.Album.ID_Artist) >
      Search(ArrIn, o^.Album.ID_Artist);
    result := (P) or ((Self^.Album.ID_Artist = o^.Album.ID_Artist) and
      (Self^.Album.Year > o^.Album.Year));
  end;
end;

Procedure SelectionSort(var L; const ArrIn: TArrayOfIndexes;
  CompareTo: FCompareTo);
var
  List: TAdrOfList;
  TmpEl, TmpList: TAdrOfList;
begin
  List := TAdrOfList(L);
  while List^.next <> nil do
  begin
    TmpEl := List;
    TmpList := List^.next;
    while TmpList^.next <> nil do
    begin
      if CompareTo(TmpEl^.next, TmpList^.next, ArrIn) then
        TmpEl := TmpList;
      TmpList := TmpList^.next;
    end;
    Swap(TmpEl, List);
    List := List^.next;
  end;
end;

Procedure RunTest(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);
var
  ArrInArtist: TArrayOfIndexes;
begin
  SelectionSort(ArtistList, [], ArtistCompareTo);
  FillArrOfIndexes(ArtistList, ArrInArtist);
  SelectionSort(AlbumList, ArrInArtist, AlbumCompareTo);
end;

end.
