unit Playlist;

interface

uses
  WorkWithLists, AllTypesInProject;
Procedure SortAllLists(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);

Procedure MakePlayListMenu(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  var Arr: TArrOfPlaylists);

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
  while Flag and (i <= High(ArrIn)) do
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
      Write('Неверный формат ввода, введите снова: ');

  until Flag = true;

end;

Procedure FillArrOfArtistInd(ArtistList: TAdrOfArtistList; Dir: TDataString;
  var ArrIn: TArrayOfIndexes);
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
    if i > High(ArrIn) then
    begin
      Add10(ArrIn);
    end;
    ArrIn[i] := ArtistList^.Artist.ID;
    Inc(i);
  end;
end;

Procedure FillArrOfAlbumInd(AlbumList: TAdrOfAlbumList; Year: Integer;
  var ArrIndArt, ArrIndAlb: TArrayOfIndexes);
var
  i: Integer;
begin
  i := 0;
  if Length(ArrIndArt) <> 0 then
  begin
    while (AlbumList^.next <> nil) and
      (AlbumList^.next.Album.ID_Artist <> ArrIndArt[Low(ArrIndArt)]) do
    begin
      AlbumList := AlbumList^.next;
    end;
    while (AlbumList^.next <> nil) and
      (SearchInArr(ArrIndArt, AlbumList^.next.Album.ID_Artist) <> -1) do
    begin
      AlbumList := AlbumList^.next;
      if AlbumList^.Album.Year >= Year then
      begin
        if i > High(ArrIndAlb) then
        begin
          Add10(ArrIndAlb);
        end;
        ArrIndAlb[i] := AlbumList^.Album.ID;
        Inc(i);
      end;
    end;
  end;
end;

Procedure MakeListOfAllSong(SongList, ListOfAllSong: TAdrOfSongList;
  var ArrIndAlb: TArrayOfIndexes);
var
  MaxID: ^Integer;
begin
  MaxID := @ListOfAllSong^.Max_Id;
  if Length(ArrIndAlb) <> 0 then
  begin

    while (SongList^.next <> nil) and
      (SongList^.next.Song.ID_Album <> ArrIndAlb[Low(ArrIndAlb)]) do
    begin
      SongList := SongList^.next;
    end;
    while (SongList^.next <> nil) do
    begin
      SongList := SongList^.next;
      if (SearchInArr(ArrIndAlb, SongList^.Song.ID_Album) <> -1) then
      begin
        Inc(MaxID^);
        New(ListOfAllSong^.next);
        ListOfAllSong := ListOfAllSong^.next;
        ListOfAllSong^.Song := SongList^.Song;
        ListOfAllSong^.next := nil;
      end;
    end;
  end;
end;

Procedure MakePlaylist(ListOfAllSong: TAdrOfSongList; const PLength: Integer;
  var Arr: TArrOfArrOfIndexes);
var
  ArrInd: TArrayOfIndexes;
  i, Sum: Integer;
  Procedure MPlaylist(LSong: TAdrOfSongList; i: Integer);
  var
    Flag: Boolean;
    k: Integer;
  begin
    while LSong^.next <> nil do
    begin
      Flag := false;
      LSong := LSong^.next;
      Sum := Sum + LSong^.Song.Length;
      if Sum > PLength then
      begin
        Sum := Sum - LSong^.Song.Length;
      end
      else if Sum < PLength then
      begin
        if i > High(ArrInd) then
          Add10(ArrInd);
        ArrInd[i] := LSong^.Song.ID;
        Inc(i);
        Flag := true;
        MPlaylist(LSong, i);
      end
      else
      begin
        if i > High(ArrInd) then
          Add10(ArrInd);
        ArrInd[i] := LSong^.Song.ID;
        SetLength(Arr, Length(Arr) + 1);
        Arr[High(Arr)] := Copy(ArrInd);
        Inc(i);
        Flag := true;
      end;

      if Flag then
      begin
        Sum := Sum - LSong^.Song.Length;
        Dec(i);
        ArrInd[i] := 0;
      end;
    end;

  end;

begin
  SetLength(ArrInd, 0);
  SetLength(Arr, 0);
  i := 0;
  Sum := 0;
  MPlaylist(ListOfAllSong, i);
end;

Function FindSong(SongList: TAdrOfSongList; ID: Integer): TSong;
var
  Flag: Boolean;
begin
  Flag := true;
  while (SongList^.next <> nil) and Flag do
  begin
    SongList := SongList^.next;
    if SongList^.Song.ID = ID then
      Flag := false;
  end;
  result := SongList^.Song;

end;

Procedure MakeArrOfPlaylists(ListOfAllSong: TAdrOfSongList; ArrOfPlaylists: TArrOfPlaylists;
  PlaylistsArr: TArrOfArrOfIndexes);
  Procedure FillArrOfPlaylists(ArrOfPlaylists: TArrOfPlaylists;
    PArr: TArrOfArrOfIndexes);
  var
    i, j: Integer;
  begin
    for i := Low(ArrOfPlaylists) to High(ArrOfPlaylists) do
    begin
      J := 0;
      while PArr[i, J] <> 0 do
      begin
        New(ArrOfPlaylists[i]^.next);
        ArrOfPlaylists[i] := ArrOfPlaylists[i]^.next;
        ArrOfPlaylists[i]^.Song := FindSong(ListOfAllSong, PArr[i, J]);
        ArrOfPlaylists[i]^.next := nil;
        Inc(J);
      end;
    end;
  end;

var
  i: Integer;
begin
  SetLength(ArrOfPlaylists, Length(PlaylistsArr));
  for i := Low(ArrOfPlaylists) to High(ArrOfPlaylists) do
  begin
    New(ArrOfPlaylists[i]);
    ArrOfPlaylists[i]^.next := nil;
  end;

  FillArrOfPlaylists(ArrOfPlaylists, PlaylistsArr);
end;

Procedure MakePlayListMenu(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  var Arr: TArrOfPlaylists);
var
  ArrIndArtist, ArrIndAlbum: TArrayOfIndexes;
  Dir: TDirString;
  PLength, Year: Integer;
  ListOfAllSong: TAdrOfSongList;
  PlaylistsArr: TArrOfArrOfIndexes;

begin
  SortAllLists(ArtistList, AlbumList, SongList);
  Write('Введите направление исполнителя: ');
  Readln(Dir);

  Writeln('Введите длину Playlist-а в формате: чч:мм:сс.');
  Writeln('(Если часы и/или минуты равны 0-ю, 0-и необходимо записать, пример:');
  Writeln('00:00:45 / 00:45:00).');
  Write('Длина: ');
  ReadTime(PLength);
  Write('Введите год, с которого выбирать песни: ');
  ReadNum(Year);

  FillArrOfArtistInd(ArtistList, Dir, ArrIndArtist);
  FillArrOfAlbumInd(AlbumList, Year, ArrIndArtist, ArrIndAlbum);

  New(ListOfAllSong);
  ListOfAllSong^.next := nil;
  ListOfAllSong^.Max_Id := 0;

  MakeListOfAllSong(SongList, ListOfAllSong, ArrIndAlbum);

  WatchSongList(ListOfAllSong);
  MakePlaylist(ListOfAllSong, PLength, PlaylistsArr);
end;

end.
