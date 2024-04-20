unit MenuItems;

interface

uses AllTypesInProject, WorkWithLists, WorkWithFiles, PlayList;

Procedure MenuItem1_ReadLists(var CurrSession: String;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile; var State: TStateOfFile);

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

Procedure MenuItem8_Playlist(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

Procedure DeleteAllLists(var ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);

implementation

Procedure MenuItem1_ReadLists(var CurrSession: String;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile; var State: TStateOfFile);
var
  Flag: Boolean;
begin
  Flag := False;
  if State = ListChanged then
  begin
    Flag := True;
    State := NoFileInformation;
  end;

  case State of
    NoFileInformation:
      begin
        if Flag then
          State := ListChanged;

        MenuReadFiles(State, CurrSession, ArtistList, AlbumList, SongList,
          ArtistFile, AlbumFile, SongFile);

        if State = FileExist then
          Writeln('Данные успешно прочитаны.')
        else
          Writeln('Файлы не найдены. Были созданы новые в данной сессии. Возможность сохранения доступна.');
        State := FileAlreadyRead;
      end;
    FileAlreadyRead:
      begin
        Writeln('Данные уже были прочитаны или недоступны.');
      end;
  end;
end;

Procedure MenuItem2_WatchLists(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('Меню подпункта просмотра списков:');
    Writeln('1. Просмотреть список исполнителей.');
    Writeln('2. Просмотреть список альбомов.');
    Writeln('3. Просмотреть список песен.');
    Writeln('0. Выйти из подпункта меню.');
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
  SortAllLists(ArtistList, AlbumList, SongList);
  Writeln('Данные успешно отсортированы.');
end;

Procedure MenuItem4_Search(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('Меню подпункта поиска:');
    Writeln('1. Искать в списке исполнителей.');
    Writeln('2. Искать в списке альбомов.');
    Writeln('3. Искать в списке песен.');
    Writeln('0. Выйти из подпункта меню.');
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
    Writeln('Меню подпункта вставки элемента:');
    Writeln('1. Вставить элемент в список исполнителей.');
    Writeln('2. Вставить элемент в список альбомов.');
    Writeln('3. Вставить элемент в список песен.');
    Writeln('0. Выйти из подпункта меню.');
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
    Writeln('Меню подпункта удаления элемента:');
    Writeln('1. Удалить элемент из списка исполнителей.');
    Writeln('2. Удалить элемент из списка альбомов.');
    Writeln('3. Удалить элемент из списка песен.');
    Writeln('0. Выйти из подпункта меню.');
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
    Writeln('Меню подпункта редактирования элемента:');
    Writeln('1. Редактировать элемент из списка исполнителей.');
    Writeln('2. Редактировать элемент из списка альбомов.');
    Writeln('3. Редактировать элемент из списка песен.');
    Writeln('0. Выйти из подпункта меню.');
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

Procedure MenuItem8_Playlist(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList);
var
  Arr: TArrOfPlaylists;
begin
  MakePlayListMenu(ArtistList, AlbumList, SongList, Arr);
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
