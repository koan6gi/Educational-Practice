unit MenuItems;

interface

uses AllTypesInProject, WorkWithLists;
Procedure MenuItem2_WatchLists(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure MenuItem5_Insert(ArtistList, AlbumList, SongList: TAdrOfList);

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

end.
