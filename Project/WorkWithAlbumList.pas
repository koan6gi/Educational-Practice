unit WorkWithAlbumList;

interface

uses
  AllTypesInProject;

Procedure WatchALbumList(AlbumList: TAdrOfAlbumList);
Procedure InsertAlbum(AlbumList: TAdrOfAlbumList; ArtistList: TAdrOfArtistList);
Procedure DeleteAlbum(AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  CheckID: Integer);
Procedure SearchALbum(AlbumList: TAdrOfAlbumList);
Procedure EditAlbum(AlbumList: TAdrOfAlbumList);

implementation

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
      end;
    end;
  until Flag;
end;

// �������� ������ � ������.
Procedure InsertAlbum(AlbumList: TAdrOfAlbumList; ArtistList: TAdrOfArtistList);
var
  MaxId: Integer;
begin
  Inc(AlbumList^.Max_Id);
  MaxId := AlbumList^.Max_Id;
  while AlbumList^.next <> nil do
    AlbumList := AlbumList^.next;
  New(AlbumList^.next);
  AlbumList := AlbumList^.next;
  AlbumList^.Album.ID := MaxId;
  AlbumList^.next := nil;

  ReadID_Artist(AlbumList^.Album.ID_Artist, ArtistList);
  Write('������� �������� �������: ');
  readln(AlbumList^.Album.Name);
  Write('������� ��� ������� �������: ');
  ReadNum(AlbumList^.Album.Year);
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

// ����� ������ �� ����.
Procedure SearchALbum(AlbumList: TAdrOfAlbumList);
var
  Flag: Boolean;
  SearchID: Integer;
begin
  Write('������� ��� �������: ');
  ReadNum(SearchID);
  Flag := False;
  while (AlbumList^.next <> nil) and not(Flag) do
  begin
    AlbumList := AlbumList^.next;
    if AlbumList^.Album.ID = SearchID then
    begin
      Flag := True;
      Writeln('|-------------|-----------------|----------------------|------------|');
      Writeln('| ��� ������� | ��� ����������� |   �������� �������   | ��� ������ |');
      Writeln('|-------------|-----------------|----------------------|------------|');
      Writeln('|', AlbumList^.Album.ID:12, ' |', AlbumList^.Album.ID_Artist:16,
        ' |', AlbumList^.Album.Name:21, ' |', AlbumList^.Album.Year:11, ' |');
      Writeln('|-------------|-----------------|----------------------|------------|');
    end;
  end;
  if not(Flag) then
    Writeln('������� � ����� ����� ��� � ������.');
  Writeln;
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
  Write('������� ��� ������� ��� �������������: ');
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

end.
