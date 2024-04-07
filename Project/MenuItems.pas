unit MenuItems;

interface

uses AllTypesInProject, WorkWithLists, WorkWithFiles;

Procedure MenuItem1_ReadLists(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile; var Flag: Integer);

Procedure MenuItem2_WatchLists(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

Procedure MenuItem3_Sort(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

Procedure MenuItem4_Search(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

Procedure MenuItem5_Insert(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

Procedure MenuItem6_Delete(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

Procedure MenuItem7_Edit(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

Procedure DeleteAllLists(var ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

implementation

Procedure MenuItem1_ReadLists(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
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

Procedure MenuItem2_WatchLists(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ��������� �������:');
    Writeln('1. ����������� ������ ������������.');
    Writeln('2. ����������� ������ ��������.');
    Writeln('3. ����������� ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readNum(Menu);
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

Procedure MenuItem3_Sort(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
begin

end;

Procedure MenuItem4_Search(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ������:');
    Writeln('1. ������ � ������ ������������.');
    Writeln('2. ������ � ������ ��������.');
    Writeln('3. ������ � ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readNum(Menu);
    case Menu of
      1:
        MenuSearchArtist(ArtistList);
      2:
        MenuSearchAlbum(AlbumList);
      3:
        MenuSearchSong(ArtistList, AlbumList, SongList);
    end;
  until Menu = 0;
end;

Procedure MenuItem5_Insert(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� ������� ��������:');
    Writeln('1. �������� ������� � ������ ������������.');
    Writeln('2. �������� ������� � ������ ��������.');
    Writeln('3. �������� ������� � ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readNum(Menu);
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

Procedure MenuItem6_Delete(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� �������� ��������:');
    Writeln('1. ������� ������� �� ������ ������������.');
    Writeln('2. ������� ������� �� ������ ��������.');
    Writeln('3. ������� ������� �� ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readNum(Menu);
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

Procedure MenuItem7_Edit(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('���� ��������� �������������� ��������:');
    Writeln('1. ������������� ������� �� ������ ������������.');
    Writeln('2. ������������� ������� �� ������ ��������.');
    Writeln('3. ������������� ������� �� ������ �����.');
    Writeln('0. ����� �� ��������� ����.');
    readNum(Menu);
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

Procedure DeleteAllLists(var ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  TmpArt: TAdrOfArtistList;
  TmpAlb: TAdrOfAlbumList;
  TmpSng: TAdrOfSongList;
begin
  while ArtistList <> nil do
  begin
    TmpArt := ArtistList;
    ArtistList := ArtistList^.next;
    Dispose(TmpArt);
  end;

  while AlbumList <> nil do
  begin
    TmpAlb := AlbumList;
    AlbumList := AlbumList^.next;
    Dispose(TmpAlb);
  end;

  while SongList <> nil do
  begin
    TmpSng := SongList;
    SongList := SongList^.next;
    Dispose(TmpSng);
  end;

end;

end.
