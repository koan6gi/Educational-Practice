unit MenuItems;

interface

uses AllTypesInProject, WorkWithLists;
Procedure MenuItem2_WatchLists(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem4_Search(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem5_Insert(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem6_Delete(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem7_Edit(ArtistList, AlbumList, SongList: TAdrOfList);

implementation

Procedure MenuItem2_WatchLists(ArtistList, AlbumList, SongList: TAdrOfList);
var
  Menu: Integer;
begin
  repeat
    WriteLn('���� ��������� ��������� �������:');
    WriteLn('1. ����������� ������ ������������.');
    WriteLn('2. ����������� ������ ��������.');
    WriteLn('3. ����������� ������ �����.');
    WriteLn('0. ����� �� ��������� ����.');
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
    WriteLn('���� ��������� ������ �� ����:');
    WriteLn('1. ������ � ������ ������������.');
    WriteLn('2. ������ � ������ ��������.');
    WriteLn('3. ������ � ������ �����.');
    WriteLn('0. ����� �� ��������� ����.');
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
    WriteLn('���� ��������� ������� ��������:');
    WriteLn('1. �������� �������� � ������ ������������.');
    WriteLn('2. �������� �������� � ������ ��������.');
    WriteLn('3. �������� �������� � ������ �����.');
    WriteLn('0. ����� �� ��������� ����.');
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
    WriteLn('���� ��������� �������� ��������:');
    WriteLn('1. ������� ������� �� ������ ������������.');
    WriteLn('2. ������� ������� �� ������ ��������.');
    WriteLn('3. ������� ������� �� ������ �����.');
    WriteLn('0. ����� �� ��������� ����.');
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
    WriteLn('���� ��������� �������������� ��������:');
    WriteLn('1. ������������� ������� �� ������ ������������.');
    WriteLn('2. ������������� ������� �� ������ ��������.');
    WriteLn('3. ������������� ������� �� ������ �����.');
    WriteLn('0. ����� �� ��������� ����.');
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

end.
