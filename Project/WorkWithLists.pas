unit WorkWithLists;

interface

uses
  AllTypesInProject;

Procedure WatchArtistList(ArtistList: TAdrOfArtistList);
Procedure InsertArtist(ArtistList: TAdrOfArtistList);
Procedure DeleteArtist(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);
Procedure EditArtist(ArtistList: TAdrOfArtistList);

Procedure WatchALbumList(AlbumList: TAdrOfAlbumList);
Procedure InsertAlbum(AlbumList: TAdrOfAlbumList; ArtistList: TAdrOfArtistList);
Procedure DeleteAlbum(AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  CheckID: Integer);
Procedure EditAlbum(AlbumList: TAdrOfAlbumList);

Procedure WatchSongList(SongList: TAdrOfSongList);
Procedure InsertSong(SongList: TAdrOfSongList; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
Procedure DeleteSong(SongList: TAdrOfSongList; CheckID: Integer);
Procedure EditSong(SongList: TAdrOfSongList);

Procedure MenuSearchArtist(ArtistList: TAdrOfArtistList);
Procedure MenuSearchAlbum(AlbumList: TAdrOfAlbumList);
Procedure MenuSearchSong(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

implementation

{ \\\\\\\\\\ Work with ArtistList ////////// }

// ����������� ������ ������������.
Procedure WatchArtistList(ArtistList: TAdrOfArtistList);
begin
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  Writeln('| ��� ����������� |  ��� �����������  | ������ ����������� | ����������� ����������� |');
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  while ArtistList^.next <> nil do
  begin
    ArtistList := ArtistList^.next;
    Writeln('|', ArtistList^.Artist.ID:16, ' |', ArtistList^.Artist.Name:18,
      ' |', ArtistList^.Artist.Country:19, ' |', ArtistList^.Artist.Direction
      :24, ' |');
  end;
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  Writeln;
end;

// �������� �� ������������� �����������.
Function IsArtistAlreadyExist(ArtistList: TAdrOfArtistList;
  TmpArtist: TArtist): Boolean;
begin
  Result := False;
  while ArtistList^.next <> nil do
  begin
    ArtistList := ArtistList^.next;
    if (ArtistList^.Artist.Name = TmpArtist.Name) and
      (ArtistList^.Artist.Country = TmpArtist.Country) and
      (ArtistList^.Artist.Direction = TmpArtist.Direction) then
      Result := True;
  end;
end;

// �������� ����������� � ������.
Procedure InsertArtist(ArtistList: TAdrOfArtistList);
var
  MaxId: Integer;
  Tmp: TAdrOfArtistList;
  TmpArtist: TArtist;
begin
  Write('������� ��� �����������: ');
  readln(TmpArtist.Name);
  Write('������� ������ �����������: ');
  readln(TmpArtist.Country);
  Write('������� ����������� ����� �����������: ');
  readln(TmpArtist.Direction);

  if not(IsArtistAlreadyExist(ArtistList, TmpArtist)) then
  begin
    Inc(ArtistList^.Max_Id);
    MaxId := ArtistList^.Max_Id;
    Tmp := ArtistList^.next;
    New(ArtistList^.next);
    ArtistList := ArtistList^.next;
    TmpArtist.ID := MaxId;
    ArtistList^.Artist := TmpArtist;
    ArtistList^.next := Tmp;
  end
  else
    Writeln('����� ����������� ��� ����������.');
  Writeln;
end;

// ������� ����������� �� ������.
Procedure DeleteArtist(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);
var
  IDForDelete: Integer;
  Tmp: TAdrOfArtistList;
  TmpAlbumList: TAdrOfAlbumList;
  Flag: Boolean;
begin
  WatchArtistList(ArtistList);
  Write('������� ��� ����������� ��� ��������: ');
  ReadNum(IDForDelete);
  Flag := False;

  While Not(Flag) and (ArtistList^.next <> nil) do
  begin
    if ArtistList^.next^.Artist.ID = IDForDelete then
    begin
      Flag := True;

      Tmp := ArtistList^.next;
      ArtistList^.next := ArtistList^.next^.next;
      Dispose(Tmp);
    end;
    ArtistList := ArtistList^.next;
  end;

  if Not(Flag) then
    Writeln('����������� � ����� ����� ��� � ������.')
  else
  begin
    New(TmpAlbumList);
    TmpAlbumList^.next := AlbumList;
    while AlbumList <> nil do
    begin
      if (AlbumList^.next <> nil) and
        (AlbumList^.next^.Album.ID_Artist = IDForDelete) then
      begin
        DeleteAlbum(TmpAlbumList^.next, SongList, AlbumList^.next^.Album.ID);
        AlbumList := TmpAlbumList;
      end;
      AlbumList := AlbumList^.next;
    end;
  end;
  Writeln;
end;

Procedure InputArtistID(var ID: Integer; var S: TDataString);
begin
  Write('������� ��� �����������: ');
  ReadNum(ID);
end;

Function ConditionArtistID(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TArtist(Element).ID = ID;
end;

Procedure InputArtistName(var ID: Integer; var S: TDataString);
begin
  Write('������� ��� �����������: ');
  readln(S);
end;

Function ConditionArtistName(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TArtist(Element).Name = S;
end;

Procedure InputArtistCountry(var ID: Integer; var S: TDataString);
begin
  Write('������� ������ �����������: ');
  readln(S);
end;

Function ConditionArtistCountry(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TArtist(Element).Country = S;
end;

Procedure InputArtistDirection(var ID: Integer; var S: TDataString);
begin
  Write('������� ����������� �����������: ');
  readln(S);
end;

Function ConditionArtistDirection(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TArtist(Element).Direction = S;
end;

// ����� ����������� � ������.
Procedure SearchArtist(ArtistList: TAdrOfArtistList; Input: PInput_Search;
  Cond: FCondEq_Search);
var
  SearchID: Integer;
  SearchString: TDataString;
begin
  Input(SearchID, SearchString);
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  Writeln('| ��� ����������� |  ��� �����������  | ������ ����������� | ����������� ����������� |');
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  while (ArtistList^.next <> nil) do
  begin
    ArtistList := ArtistList^.next;
    if Cond(ArtistList^.Artist, SearchID, SearchString) then
    begin
      Writeln('|', ArtistList^.Artist.ID:16, ' |', ArtistList^.Artist.Name:18,
        ' |', ArtistList^.Artist.Country:19, ' |', ArtistList^.Artist.Direction
        :24, ' |');
    end;
  end;
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  Writeln;
end;

// ����� ���� ������������ �� ����� � ������.
Procedure SearchArtistByName(ArtistList: TAdrOfArtistList;
  var ArtistIndexes: TArrayOfIndexes);
var
  SearchID, Index: Integer;
  SearchString: TDataString;
begin
  Index := 0;
  InputArtistName(SearchID, SearchString);
  while (ArtistList^.next <> nil) do
  begin
    ArtistList := ArtistList^.next;
    if ConditionArtistName(ArtistList^.Artist, SearchID, SearchString) then
    begin
      if High(ArtistIndexes) < Index then
        Add10(ArtistIndexes);
      ArtistIndexes[Index] := ArtistList^.Artist.ID;
      Inc(Index);
    end;
  end;
end;

// ���� ������ � ������ ������������.
Procedure MenuSearchArtist(ArtistList: TAdrOfArtistList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ������ � ������ ������������:');
    Writeln('1. ����� �� ���� �����������.');
    Writeln('2. ����� �� ����� �����������.');
    Writeln('3. ����� �� ������ �����������.');
    Writeln('4. ����� �� ����������� �����������.');
    Writeln('0. ����� �� ��������� ����.');
    ReadNum(Menu);
    case Menu of
      1:
        SearchArtist(ArtistList, InputArtistID, ConditionArtistID);
      2:
        SearchArtist(ArtistList, InputArtistName, ConditionArtistName);
      3:
        SearchArtist(ArtistList, InputArtistCountry, ConditionArtistCountry);
      4:
        SearchArtist(ArtistList, InputArtistDirection,
          ConditionArtistDirection);
    end;
  until Menu = 0;
end;

// ����� ���� ��� �������������� �����������
Procedure EditArtistMenu(ArtistList: TAdrOfArtistList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������������:');
    Writeln('1. ������������� ��� �����������.');
    Writeln('2. ������������� ������ �����������.');
    Writeln('3. ������������� ����������� �����������.');
    Writeln('0. ����� �� ������� �������������� �����������.');
    ReadNum(Menu);
    case Menu of
      1:
        begin
          Write('������� ����� ��� �����������: ');
          readln(ArtistList^.Artist.Name);
        end;

      2:
        begin
          Write('������� ������ �����������: ');
          readln(ArtistList^.Artist.Country);
        end;

      3:
        begin
          Write('������� ����������� �����������: ');
          readln(ArtistList^.Artist.Direction);
        end;
    end;
  until Menu = 0;
end;

// ������������� ���������� � �����������.
Procedure EditArtist(ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  ID: Integer;
begin
  WatchArtistList(ArtistList);
  Write('������� ��� ����������� ��� ��������������: ');
  readln(ID);
  Flag := False;
  while (ArtistList^.next <> nil) and not(Flag) do
  begin
    ArtistList := ArtistList^.next;
    if ArtistList^.Artist.ID = ID then
    begin
      Flag := True;
      EditArtistMenu(ArtistList);
    end;
  end;

  if not(Flag) then
    Writeln('����������� � ����� ����� �� ����������.');
  Writeln;
end;

{ \\\\\\\\\\ Work with AlbumList ////////// }

// ����������� ������ ��������.
Procedure WatchALbumList(AlbumList: TAdrOfAlbumList);
begin
  Writeln('|-------------|-----------------|----------------------|------------|');
  Writeln('| ��� ������� | ��� ����������� |   �������� �������   | ��� ������ |');
  Writeln('|-------------|-----------------|----------------------|------------|');
  while AlbumList^.next <> nil do
  begin
    AlbumList := AlbumList^.next;
    Writeln('|', AlbumList^.Album.ID:12, ' |', AlbumList^.Album.ID_Artist:16,
      ' |', AlbumList^.Album.Name:21, ' |', AlbumList^.Album.Year:11, ' |');
  end;
  Writeln('|-------------|-----------------|----------------------|------------|');
  Writeln;
end;

// ��������� ��� �������, ������������ ��� ����������.
Procedure ReadID_Artist(var ID: Integer; ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  ArtL: TAdrOfArtistList;
  Menu: Integer;
begin
  repeat
    Write('������� ��� �����������: ');
    ReadNum(ID);
    Flag := False;
    ArtL := ArtistList^.next;
    while (ArtL <> nil) and not(Flag) do
    begin
      if ArtL^.Artist.ID = ID then
        Flag := True;
      ArtL := ArtL^.next;
    end;

    if Flag = False then
    begin
      Writeln('����������� � ����� ����� �� ����������.');
      Writeln('������� ������� ������ �����������?');
      Writeln('1. ��. / 0. ��� (������ ��� ������).');
      ReadNum(Menu);
      if Menu = 1 then
      begin
        ID := ArtistList^.Max_Id + 1;
        InsertArtist(ArtistList);
        Flag := True;
      end;
    end;
  until Flag;
end;

// �������� �� ������������� �������.
Function IsAlbumAlreadyExist(AlbumList: TAdrOfAlbumList;
  TmpAlbum: TAlbum): Boolean;
begin
  Result := False;
  while AlbumList^.next <> nil do
  begin
    AlbumList := AlbumList^.next;
    if (AlbumList^.Album.Name = TmpAlbum.Name) and
      (AlbumList^.Album.ID_Artist = TmpAlbum.ID_Artist) and
      (AlbumList^.Album.Year = TmpAlbum.Year) then
      Result := True;
  end;
end;

// �������� ������ � ������.
Procedure InsertAlbum(AlbumList: TAdrOfAlbumList; ArtistList: TAdrOfArtistList);
var
  MaxId: Integer;
  TmpAlbum: TAlbum;
begin
  WatchArtistList(ArtistList);
  ReadID_Artist(TmpAlbum.ID_Artist, ArtistList);
  Write('������� �������� �������: ');
  readln(TmpAlbum.Name);
  Write('������� ��� ������� �������: ');
  ReadNum(TmpAlbum.Year);

  if not(IsAlbumAlreadyExist(AlbumList, TmpAlbum)) then
  begin
    Inc(AlbumList^.Max_Id);
    MaxId := AlbumList^.Max_Id;
    while AlbumList^.next <> nil do
      AlbumList := AlbumList^.next;
    New(AlbumList^.next);
    AlbumList := AlbumList^.next;
    TmpAlbum.ID := MaxId;
    AlbumList^.Album := TmpAlbum;
    AlbumList^.next := nil;
  end
  else
    Writeln('����� ������ ��� ����������.');

  Writeln;
end;

// ������� ������ �� ������.
Procedure DeleteAlbum(AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  CheckID: Integer);
var
  IDForDelete: Integer;
  Tmp: TAdrOfAlbumList;
  TmpSongList: TAdrOfSongList;
  Flag: Boolean;
begin
  IDForDelete := CheckID;
  if CheckID = 0 then
  begin
    WatchALbumList(AlbumList);
    Write('������� ��� ������� ��� ��������: ');
    ReadNum(IDForDelete);
  end;
  Flag := False;

  While Not(Flag) and (AlbumList^.next <> nil) do
  begin
    if AlbumList^.next^.Album.ID = IDForDelete then
    begin
      Flag := True;

      Tmp := AlbumList^.next;
      AlbumList^.next := AlbumList^.next^.next;
      Dispose(Tmp);
    end;
    AlbumList := AlbumList^.next;
  end;

  if Not(Flag) then
    Writeln('������� � ����� ����� ��� � ������.')
  else
  begin
    New(TmpSongList);
    TmpSongList^.next := SongList;
    while SongList <> nil do
    begin
      if (SongList^.next <> nil) and
        (SongList^.next^.Song.ID_Album = IDForDelete) then
      begin
        DeleteSong(TmpSongList^.next, SongList^.next^.Song.ID);
        SongList := TmpSongList;
      end;
      SongList := SongList^.next;
    end;
  end;
end;

Procedure InputALbumID(var ID: Integer; var S: TDataString);
begin
  Write('������� ��� �������: ');
  ReadNum(ID);
end;

Function ConditionAlbumID(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TAlbum(Element).ID = ID;
end;

Function ConditionAlbumID_Artist(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TAlbum(Element).ID_Artist = ID;
end;

Procedure InputALbumName(var ID: Integer; var S: TDataString);
begin
  Write('������� �������� �������: ');
  readln(S);
end;

Function ConditionAlbumName(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TAlbum(Element).Name = S;
end;

// ����� ������ � ������.
Procedure SearchAlbum(AlbumList: TAdrOfAlbumList; Input: PInput_Search;
  Cond: FCondEq_Search);
var
  SearchID: Integer;
  SearchString: TDataString;
begin
  Input(SearchID, SearchString);
  Writeln('|-------------|-----------------|----------------------|------------|');
  Writeln('| ��� ������� | ��� ����������� |   �������� �������   | ��� ������ |');
  Writeln('|-------------|-----------------|----------------------|------------|');
  while (AlbumList^.next <> nil) do
  begin
    AlbumList := AlbumList^.next;
    if Cond(AlbumList^.Album, SearchID, SearchString) then
    begin
      Writeln('|', AlbumList^.Album.ID:12, ' |', AlbumList^.Album.ID_Artist:16,
        ' |', AlbumList^.Album.Name:21, ' |', AlbumList^.Album.Year:11, ' |');
    end;
  end;
  Writeln('|-------------|-----------------|----------------------|------------|');
  Writeln;
end;

// ����� ��� ������� �� ���� ����������� � ������.
Procedure SearchAlbumByID_Artist(AlbumList: TAdrOfAlbumList;
  var ArtistIndexes, AlbumIndexes: TArrayOfIndexes);
var
  IndexArtist, IndexAlbum: Integer;
  SearchString: TDataString;
  Tmp: TAdrOfAlbumList;
begin
  IndexAlbum := 0;
  IndexArtist := 0;
  Tmp := AlbumList;
  while (Length(ArtistIndexes) <> 0) and (ArtistIndexes[IndexArtist] <> 0) do
  begin
    AlbumList := Tmp;
    while (AlbumList^.next <> nil) do
    begin
      AlbumList := AlbumList^.next;
      if ConditionAlbumID_Artist(AlbumList^.Album, ArtistIndexes[IndexArtist],
        SearchString) then
      begin
        if High(AlbumIndexes) < IndexAlbum then
          Add10(AlbumIndexes);
        AlbumIndexes[IndexAlbum] := AlbumList^.Album.ID;
        Inc(IndexAlbum);
      end;
    end;
    Inc(IndexArtist);
  end;
end;

// ���� ������ � ������ ��������.
Procedure MenuSearchAlbum(AlbumList: TAdrOfAlbumList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ������ � ������ ��������:');
    Writeln('1. ����� �� ���� �������.');
    Writeln('2. ����� �� ���� ����������� �������.');
    Writeln('3. ����� �� �������� �������.');
    Writeln('0. ����� �� ��������� ����.');
    ReadNum(Menu);
    case Menu of
      1:
        SearchAlbum(AlbumList, InputALbumID, ConditionAlbumID);
      2:
        SearchAlbum(AlbumList, InputArtistID, ConditionAlbumID_Artist);
      3:
        SearchAlbum(AlbumList, InputALbumName, ConditionAlbumName);
    end;
  until Menu = 0;
end;

// ����� ���� ��� �������������� �������
Procedure EditAlbumMenu(AlbumList: TAdrOfAlbumList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������������:');
    Writeln('1. ������������� �������� �������.');
    Writeln('2. ������������� ��� ������� �������.');
    Writeln('0. ����� �� ������� �������������� �����������.');
    ReadNum(Menu);
    case Menu of
      1:
        begin
          Write('������� ����� �������� �������: ');
          readln(AlbumList^.Album.Name);
        end;

      2:
        begin
          Write('������� ��� ������: ');
          ReadNum(AlbumList^.Album.Year);
        end;
    end;
  until Menu = 0;
end;

// ������������� ���������� � �������.
Procedure EditAlbum(AlbumList: TAdrOfAlbumList);
var
  Flag: Boolean;
  ID: Integer;
begin
  WatchALbumList(AlbumList);
  Write('������� ��� ������� ��� ��������������: ');
  ReadNum(ID);
  Flag := False;
  while (AlbumList^.next <> nil) and not(Flag) do
  begin
    AlbumList := AlbumList^.next;
    if AlbumList^.Album.ID = ID then
    begin
      Flag := True;
      EditAlbumMenu(AlbumList);
    end;
  end;

  if not(Flag) then
    Writeln('������� � ����� ����� �� ����������.');
  Writeln;
end;

{ \\\\\\\\\\ Work with SongList ////////// }

// ����������� ������ �����.
Procedure WatchSongList(SongList: TAdrOfSongList);
begin
  Writeln('|-----------|----------------------|-------------|--------------------|');
  Writeln('| ��� ����� |    �������� �����    | ��� ������� | ������������ ����� |');
  Writeln('|-----------|----------------------|-------------|--------------------|');
  while SongList^.next <> nil do
  begin
    SongList := SongList^.next;
    Writeln('|', SongList^.Song.ID:10, ' |', SongList^.Song.Name:21, ' |',
      SongList^.Song.ID_Album:12, ' |', SongList^.Song.Length:19, ' |');
  end;
  Writeln('|-----------|----------------------|-------------|--------------------|');
  Writeln;
end;

// ��������� ��� �������, ������������ ��� ����������.
Procedure ReadID_Album(var ID: Integer; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  AlbL: TAdrOfAlbumList;
  Menu: Integer;
begin
  Menu := 0;
  repeat
    Write('������� ��� �������: ');
    ReadNum(ID);
    Flag := False;
    AlbL := AlbumList^.next;
    while (AlbL <> nil) and not(Flag) do
    begin
      if AlbL^.Album.ID = ID then
        Flag := True;
      AlbL := AlbL^.next;
    end;

    if Flag = False then
    begin
      Writeln('������� � ����� ����� �� ����������.');
      Writeln('������� ������� ����� ������?');
      Writeln('1. ��. / 0. ��� (������ ��� ������).');
      ReadNum(Menu);
      if Menu = 1 then
      begin
        ID := AlbumList^.Max_Id + 1;
        InsertAlbum(AlbumList, ArtistList);
        Flag := True;
      end;
    end;
  until Flag;
end;

// �������� �� ������������� �����.
Function IsSongAlreadyExist(SongList: TAdrOfSongList; TmpSong: TSong): Boolean;
begin
  Result := False;
  while SongList^.next <> nil do
  begin
    SongList := SongList^.next;
    if (SongList^.Song.Name = TmpSong.Name) and
      (SongList^.Song.ID_Album = TmpSong.ID_Album) and
      (SongList^.Song.Length = TmpSong.Length) then
      Result := True;
  end;
end;

// �������� ����� � ������.
Procedure InsertSong(SongList: TAdrOfSongList; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
var
  MaxId: Integer;
  Tmp: TAdrOfSongList;
  TmpSong: TSong;
begin
  WatchALbumList(AlbumList);
  ReadID_Album(TmpSong.ID_Album, AlbumList, ArtistList);
  Write('������� �������� �����: ');
  readln(TmpSong.Name);
  Write('������� ����� ����� � ��������: ');
  ReadNum(TmpSong.Length);

  if not(IsSongAlreadyExist(SongList, TmpSong)) then
  begin
    Inc(SongList^.Max_Id);
    MaxId := SongList^.Max_Id;
    Tmp := SongList^.next;
    New(SongList^.next);
    SongList := SongList^.next;
    TmpSong.ID := MaxId;
    SongList^.Song := TmpSong;
    SongList^.next := Tmp;
  end
  else
    Writeln('����� ����� ��� ����������.');
  Writeln;
end;

// ������� ����� �� ������.
Procedure DeleteSong(SongList: TAdrOfSongList; CheckID: Integer);
var
  IDForDelete: Integer;
  Tmp: TAdrOfSongList;
  Flag: Boolean;
begin
  IDForDelete := CheckID;
  if CheckID = 0 then
  begin
    WatchSongList(SongList);
    Write('������� ��� ����� ��� ��������: ');
    ReadNum(IDForDelete);
  end;
  Flag := False;

  While Not(Flag) and (SongList^.next <> nil) do
  begin
    if SongList^.next^.Song.ID = IDForDelete then
    begin
      Flag := True;

      Tmp := SongList^.next;
      SongList^.next := SongList^.next^.next;
      Dispose(Tmp);
    end;
    SongList := SongList^.next;
  end;

  if Not(Flag) then
    Writeln('����� � ����� ����� ��� � ������.');
end;

Procedure InputSongID(var ID: Integer; var S: TDataString);
begin
  Write('������� ��� �����: ');
  ReadNum(ID);
end;

Function ConditionSongID(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TSong(Element).ID = ID;
end;

Function ConditionSongID_Album(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TSong(Element).ID_Album = ID;
end;

Procedure InputSongName(var ID: Integer; var S: TDataString);
begin
  Write('������� �������� �����: ');
  readln(S);
end;

Function ConditionSongName(var Element; var ID: Integer;
  var S: TDataString): Boolean;
begin
  Result := TSong(Element).Name = S;
end;

// ����� ����� � ������.
Procedure SearchSong(SongList: TAdrOfSongList; Input: PInput_Search;
  Cond: FCondEq_Search);
var
  SearchID: Integer;
  SearchString: TDataString;
begin
  Input(SearchID, SearchString);
  Writeln('|-----------|----------------------|-------------|--------------------|');
  Writeln('| ��� ����� |    �������� �����    | ��� ������� | ������������ ����� |');
  Writeln('|-----------|----------------------|-------------|--------------------|');
  while (SongList^.next <> nil) do
  begin
    SongList := SongList^.next;
    if (Cond(SongList^.Song, SearchID, SearchString)) then
    begin
      Writeln('|', SongList^.Song.ID:10, ' |', SongList^.Song.Name:21, ' |',
        SongList^.Song.ID_Album:12, ' |', SongList^.Song.Length:19, ' |');
    end;
  end;
  Writeln('|-----------|----------------------|-------------|--------------------|');
  Writeln;
end;

// ����� ����� � ������(����������� ������� 2).
Procedure SearchSongByArtist(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  IndexAlbum: Integer;
  SearchString: TDataString;
  ArtistIndexes, AlbumIndexes: TArrayOfIndexes;
  Tmp: TAdrOfSongList;
begin
  SearchArtistByName(ArtistList, ArtistIndexes);
  SearchAlbumByID_Artist(AlbumList, ArtistIndexes, AlbumIndexes);
  IndexAlbum := 0;
  Writeln('|-----------|----------------------|-------------|--------------------|');
  Writeln('| ��� ����� |    �������� �����    | ��� ������� | ������������ ����� |');
  Writeln('|-----------|----------------------|-------------|--------------------|');
  Tmp := SongList;
  while (Length(AlbumIndexes) <> 0) and (AlbumIndexes[IndexAlbum] <> 0) do
  begin
    SongList := Tmp;
    while (SongList^.next <> nil) do
    begin
      SongList := SongList^.next;
      if (ConditionSongID_Album(SongList^.Song, AlbumIndexes[IndexAlbum],
        SearchString)) then
      begin
        Writeln('|', SongList^.Song.ID:10, ' |', SongList^.Song.Name:21, ' |',
          SongList^.Song.ID_Album:12, ' |', SongList^.Song.Length:19, ' |');
      end;
    end;
    Inc(IndexAlbum);
  end;
  Writeln('|-----------|----------------------|-------------|--------------------|');
  Writeln;
end;

// ���� ������ � ������ ��������.
Procedure MenuSearchSong(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ������ � ������ �����:');
    Writeln('1. ����� �� ���� �����.');
    Writeln('2. ����� �� ���� ������� �����.');
    Writeln('3. ����� �� �������� �����.');
    Writeln('4. ����� �� ����� �����������.');
    Writeln('0. ����� �� ��������� ����.');
    ReadNum(Menu);
    case Menu of
      1:
        SearchSong(SongList, InputSongID, ConditionSongID);
      2:
        SearchSong(SongList, InputALbumID, ConditionSongID_Album);
      3:
        SearchSong(SongList, InputSongName, ConditionSongName);
      4:
        SearchSongByArtist(ArtistList, AlbumList, SongList);
    end;
  until Menu = 0;
end;

// ����� ���� ��� �������������� �����
Procedure EditSongMenu(SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������������:');
    Writeln('1. ������������� �������� �����.');
    Writeln('2. ������������� ������������ �����.');
    Writeln('0. ����� �� ������� �������������� �����������.');
    ReadNum(Menu);
    case Menu of
      1:
        begin
          Write('������� �������� �����: ');
          readln(SongList^.Song.Name);
        end;

      2:
        begin
          Write('������� ������������: ');
          ReadNum(SongList^.Song.Length);
        end;
    end;
  until Menu = 0;
end;

// ������������� ���������� � �����.
Procedure EditSong(SongList: TAdrOfSongList);
var
  Flag: Boolean;
  ID: Integer;
begin
  WatchSongList(SongList);
  Write('������� ��� ����� ��� ��������������: ');
  ReadNum(ID);
  Flag := False;
  while (SongList^.next <> nil) and not(Flag) do
  begin
    SongList := SongList^.next;
    if SongList^.Song.ID = ID then
    begin
      Flag := True;
      EditSongMenu(SongList);
    end;
  end;

  if not(Flag) then
    Writeln('����� � ����� ����� �� ����������.');
  Writeln;
end;

end.
