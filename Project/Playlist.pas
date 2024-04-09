unit Playlist;

interface

uses
  AllTypesInProject;
Procedure SortAllLists(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);

Procedure MakePlayList(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var Arr: TArrOfLists);

implementation

Function SearchInArr(const ArrIn: TArrayOfIndexes; const item: Integer)
  : Integer;
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
    P := SearchInArr(ArrIn, Self^.Album.ID_Artist) >
      SearchInArr(ArrIn, o^.Album.ID_Artist);
    result := (P) or ((Self^.Album.ID_Artist = o^.Album.ID_Artist) and
      (Self^.Album.Year > o^.Album.Year));
  end;
end;

Function SongCompareTo(Self, o: TAdrOfList;
  const ArrIn: TArrayOfIndexes): Boolean;
var
  P: Boolean;
begin
  if o = nil then
    result := false
  else
  begin
    P := SearchInArr(ArrIn, Self^.Song.ID_Album) >
      SearchInArr(ArrIn, o^.Song.ID_Album);
    result := (P) or ((Self^.Song.ID_Album = o^.Song.ID_Album) and
      (Self^.Song.Length > o^.Song.Length));
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

Procedure SortAllLists(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);
var
  ArrInArtist, ArrInAlbum: TArrayOfIndexes;
begin
  SelectionSort(ArtistList, [], ArtistCompareTo);
  FillArrOfIndexes(ArtistList, ArrInArtist);
  SelectionSort(AlbumList, ArrInArtist, AlbumCompareTo);
  FillArrOfIndexes(AlbumList, ArrInAlbum);
  SelectionSort(SongList, ArrInAlbum, SongCompareTo);
end;

Procedure ReadTime(var Time: Integer);
var
  Ind, ErrH, ErrM, ErrS, Hours, Minutes, Seconds: Integer;
  TimeStr, SHours, SMinutes, SSeconds: TDataString;
  Flag, Err, Format: Boolean;
begin
  repeat
    ErrH := 0;
    ErrM := 0;
    ErrS := 0;

    Flag := false;
    Readln(TimeStr);

    Ind := Pos(':', String(TimeStr));
    SHours := TDataString(Copy(TimeStr, 0, Ind - 1));
    Delete(TimeStr, 1, Ind);

    Ind := Pos(':', String(TimeStr));
    SMinutes := TDataString(Copy(TimeStr, 0, Ind - 1));
    Delete(TimeStr, 1, Ind);

    SSeconds := TimeStr;

    Val(String(SHours), Hours, ErrH);
    Val(String(SMinutes), Minutes, ErrM);
    Val(String(SSeconds), Seconds, ErrS);

    Time := Hours * 3600 + Minutes * 60 + Seconds;

    Err := (ErrH = 0) and (ErrM = 0) and (ErrM = 0);
    Format := (Minutes < 60) and (Minutes >= 0) and (Seconds < 60) and
      (Seconds >= 0);
    if Err and Format then
      Flag := true
    else
      Writeln('Неверный формат ввода, введите снова: ');

  until Flag = true;

end;

Procedure FillArrOfArtistInd(ArtistList: TAdrOfArtistList; Dir: TDataString;
  ArrIn: TArrayOfIndexes);
var
  i: Integer;
begin
  i := 0;

  while (ArtistList^.next <> nil) and
    (ArtistList^.next.Artist.Direction <> Dir) do
  begin
    ArtistList := ArtistList^.next;
  end;
  while (ArtistList^.next <> nil) and
    (ArtistList^.next.Artist.Direction = Dir) do
  begin
    ArtistList := ArtistList^.next;
    if ArtistList^.Artist.Direction = Dir then
      if i > High(ArrIn) then
      begin
        Add10(ArrIn);
        ArrIn[i] := ArtistList^.Artist.ID;
      end;
    Inc(i);
  end;
end;

Procedure MakePlayList(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var Arr: TArrOfLists);
var
  ArrIndArtist, ArrIndAlbum: TArrayOfIndexes;
  Dir: TDirString;
  Time, Year: Integer;

begin
  Write('Введите направление исполнителя: ');
  Readln(Dir);
  Writeln('Введите длину Playlist-а в формате: чч:мм:сс.');
  Writeln('(Если часы и/или минуты равны 0-ю, 0-и необходимо записать, пример:');
  Writeln('00:00:45 / 00:45:00).');
  Write('Длина: ');
  ReadTime(Time);
  Writeln('Введите год, с которого выбирать песни: ');
  ReadNum(Year);

end;

end.
