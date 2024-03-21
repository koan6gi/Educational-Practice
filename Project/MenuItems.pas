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
    Writeln('Данные успешно прочитаны.');
    Flag := 1;
  end
  else if Flag = 1 then
    Writeln('Данные уже были прочитаны.')
  else
    Writeln('Были внесены изменения, для прочтения данных перезапустите программу.');
end;

Procedure MenuItem2_WatchLists(ArtistList, AlbumList, SongList: TAdrOfList);
var
  Menu: Integer;
begin
  repeat
    Writeln('Меню подпункта просмотра списков:');
    Writeln('1. Просмотреть список исполнителей.');
    Writeln('2. Просмотреть список альбомов.');
    Writeln('3. Просмотреть список песен.');
    Writeln('0. Выйти из подпункта меню.');
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
    Writeln('Меню подпункта поиска по коду:');
    Writeln('1. Искать в списке исполнителей.');
    Writeln('2. Искать в списке альбомов.');
    Writeln('3. Искать в списке песен.');
    Writeln('0. Выйти из подпункта меню.');
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
    Writeln('Меню подпункта вставки элемента:');
    Writeln('1. Вставить элемента в список исполнителей.');
    Writeln('2. Вставить элемента в список альбомов.');
    Writeln('3. Вставить элемента в список песен.');
    Writeln('0. Выйти из подпункта меню.');
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
    Writeln('Меню подпункта удаления элемента:');
    Writeln('1. Удалить элемент из списка исполнителей.');
    Writeln('2. Удалить элемент из списка альбомов.');
    Writeln('3. Удалить элемент из списка песен.');
    Writeln('0. Выйти из подпункта меню.');
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
    Writeln('Меню подпункта редактирования элемента:');
    Writeln('1. Редактировать элемент из списка исполнителей.');
    Writeln('2. Редактировать элемент из списка альбомов.');
    Writeln('3. Редактировать элемент из списка песен.');
    Writeln('0. Выйти из подпункта меню.');
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
