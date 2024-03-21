unit MenuItems;

interface

uses AllTypesInProject, WorkWithLists, WorkWithFiles;

Procedure MenuItem1_ReadLists(ArtistList, AlbumList, SongList: TAdrOfList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile; var Flag: Integer);
Procedure MenuItem2_WatchLists(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem4_Search(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem5_Insert(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem6_Delete(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem7_Edit(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure DeleteAllLists(var ArtistList, AlbumList, SongList: TAdrOfList);

implementation

Procedure MenuItem1_ReadLists(ArtistList, AlbumList, SongList: TAdrOfList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile; var Flag: Integer);
begin
  if Flag = 0 then
  begin
    ReadAllListsFromFiles(ArtistList, AlbumList, SongList, ArtistFile,
      AlbumFile, SongFile);
    Writeln('������ ������� ���������.');
    Flag := 1;
  end
  else if Flag = 1 then
    Writeln('������ ��� ���� ���������.')
  else
    Writeln('���� ������� ���������, ��� ��������� ������ ������������� ���������.');
end;

Procedure MenuItem2_WatchLists(ArtistList, AlbumList, SongList: TAdrOfList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ��������� �������:');
    Writeln('1. ����������� ������ ������������.');
    Writeln('2. ����������� ������ ��������.');
    Writeln('3. ����������� ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readln(Menu);
    case Menu of
      1:
        WatchArtistList(ArtistList);
      2:
        WatchAlbumList(AlbumList);
      3:
        WatchSongList(SongList);
    end;
  until Menu = 0;
end;

Procedure MenuItem4_Search(ArtistList, AlbumList, SongList: TAdrOfList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ������ �� ����:');
    Writeln('1. ������ � ������ ������������.');
    Writeln('2. ������ � ������ ��������.');
    Writeln('3. ������ � ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readln(Menu);
    case Menu of
      1:
        SearchArtist(ArtistList);
      2:
        SearchAlbum(AlbumList);
      3:
        SearchSong(SongList);
    end;
  until Menu = 0;
end;

Procedure MenuItem5_Insert(ArtistList, AlbumList, SongList: TAdrOfList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ������� ��������:');
    Writeln('1. �������� �������� � ������ ������������.');
    Writeln('2. �������� �������� � ������ ��������.');
    Writeln('3. �������� �������� � ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readln(Menu);
    case Menu of
      1:
        InsertArtist(ArtistList);
      2:
        InsertAlbum(AlbumList, ArtistList);
      3:
        InsertSong(SongList, AlbumList, ArtistList);
    end;
  until Menu = 0;
end;

Procedure MenuItem6_Delete(ArtistList, AlbumList, SongList: TAdrOfList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� �������� ��������:');
    Writeln('1. ������� ������� �� ������ ������������.');
    Writeln('2. ������� ������� �� ������ ��������.');
    Writeln('3. ������� ������� �� ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readln(Menu);
    case Menu of
      1:
        DeleteArtist(ArtistList, AlbumList, SongList);
      2:
        DeleteAlbum(AlbumList, SongList, 0);
      3:
        DeleteSong(SongList, 0);
    end;
  until Menu = 0;
end;

Procedure MenuItem7_Edit(ArtistList, AlbumList, SongList: TAdrOfList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� �������������� ��������:');
    Writeln('1. ������������� ������� �� ������ ������������.');
    Writeln('2. ������������� ������� �� ������ ��������.');
    Writeln('3. ������������� ������� �� ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readln(Menu);
    case Menu of
      1:
        EditArtist(ArtistList);
      2:
        EditAlbum(AlbumList);
      3:
        EditSong(SongList);
    end;
  until Menu = 0;
end;

Procedure DeleteAllLists(var ArtistList, AlbumList, SongList: TAdrOfList);
var
  Tmp: TAdrOfList;
begin
  while ArtistList <> nil do
  begin
    Tmp := ArtistList;
    ArtistList := ArtistList^.next;
    Dispose(Tmp);
  end;

  while AlbumList <> nil do
  begin
    Tmp := AlbumList;
    AlbumList := AlbumList^.next;
    Dispose(Tmp);
  end;

  while SongList <> nil do
  begin
    Tmp := SongList;
    SongList := SongList^.next;
    Dispose(Tmp);
  end;

end;

end.
