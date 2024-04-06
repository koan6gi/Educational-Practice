unit WorkWithArtistLists;

interface

uses
  AllTypesInProject, AdditionalFunctionsForLists;

Procedure WatchArtistList(ArtistList: TAdrOfArtistList);
Procedure InsertArtist(ArtistList: TAdrOfArtistList);
Procedure DeleteArtist(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);
Procedure SearchArtist(ArtistList: TAdrOfArtistList);
Procedure EditArtist(ArtistList: TAdrOfArtistList);

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

// �������� �� ������������� ����������� ��� �������.
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

// ����� ����������� � ������.
Procedure SearchArtist(ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  SearchID: Integer;
begin
  Write('������� ��� �����������: ');
  ReadNum(SearchID);
  Flag := False;
  while (ArtistList^.next <> nil) and not(Flag) do
  begin
    ArtistList := ArtistList^.next;
    if ArtistList^.Artist.ID = SearchID then
    begin
      Flag := True;
      Writeln('|-----------------|-------------------|--------------------|-------------------------|');
      Writeln('| ��� ����������� |  ��� �����������  | ������ ����������� | ����������� ����������� |');
      Writeln('|-----------------|-------------------|--------------------|-------------------------|');
      Writeln('|', ArtistList^.Artist.ID:16, ' |', ArtistList^.Artist.Name:18,
        ' |', ArtistList^.Artist.Country:19, ' |', ArtistList^.Artist.Direction
        :24, ' |');
      Writeln('|-----------------|-------------------|--------------------|-------------------------|');
    end;
  end;
  if not(Flag) then
    Writeln('����������� � ����� ����� ��� � ������.');
  Writeln;
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
  Write('������� ��� ����������� ��� �������������: ');
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

end.
