unit WorkWithSongList;

interface

uses
  AllTypesInProject;

Procedure WatchSongList(SongList: TAdrOfSongList);
Procedure InsertSong(SongList: TAdrOfSongList; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
Procedure DeleteSong(SongList: TAdrOfSongList; CheckID: Integer);
Procedure SearchSong(SongList: TAdrOfSongList);
Procedure EditSong(SongList: TAdrOfSongList);

implementation

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
      end;
    end;
  until Flag;
end;

// �������� ������ � ������.
Procedure InsertSong(SongList: TAdrOfSongList; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
var
  MaxId: Integer;
  Tmp: TAdrOfSongList;
begin
  Inc(SongList^.Max_Id);
  MaxId := SongList^.Max_Id;
  Tmp := SongList^.next;
  New(SongList^.next);
  SongList := SongList^.next;
  SongList^.Song.ID := MaxId;
  SongList^.next := Tmp;

  ReadID_Album(SongList^.Song.ID_Album, AlbumList, ArtistList);
  Write('������� �������� �����: ');
  readln(SongList^.Song.Name);
  Write('������� ����� ����� � ��������: ');
  ReadNum(SongList^.Song.Length);
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

// ����� ����� �� ����.
Procedure SearchSong(SongList: TAdrOfSongList);
var
  Flag: Boolean;
  SearchID: Integer;
begin
  Write('������� ��� �����: ');
  ReadNum(SearchID);
  Flag := False;
  while (SongList^.next <> nil) and not(Flag) do
  begin
    SongList := SongList^.next;
    if SongList^.Song.ID = SearchID then
    begin
      Flag := True;
      Writeln('|-----------|----------------------|-------------|--------------------|');
      Writeln('| ��� ����� |    �������� �����    | ��� ������� | ������������ ����� |');
      Writeln('|-----------|----------------------|-------------|--------------------|');
      Writeln('|', SongList^.Song.ID:10, ' |', SongList^.Song.Name:21, ' |',
        SongList^.Song.ID_Album:12, ' |', SongList^.Song.Length:19, ' |');
      Writeln('|-----------|----------------------|-------------|--------------------|');
    end;
  end;
  if not(Flag) then
    Writeln('����� � ����� ����� ��� � ������.');
  Writeln;
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
  Write('������� ��� ����� ��� �������������: ');
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
