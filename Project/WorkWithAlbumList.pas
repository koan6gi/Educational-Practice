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

// Просмотреть список альбомов.
Procedure WatchALbumList(AlbumList: TAdrOfAlbumList);
begin
  Writeln('|-------------|-----------------|----------------------|------------|');
  Writeln('| Код альбома | Код исполнителя |   Название альбома   | Год записи |');
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

// Прочитать код артиста, предусмотрев его отсутствие.
Procedure ReadID_Artist(var ID: Integer; ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  ArtL: TAdrOfArtistList;
  Menu: Integer;
begin
  repeat
    Write('Введите код исполнителя: ');
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
      Writeln('Исполнителя с таким кодом не существует.');
      Writeln('Желаете создать нового исполнителя?');
      Writeln('1. Да. / 0. Нет (Ввести код заново).');
      ReadNum(Menu);
      if Menu = 1 then
      begin
        ID := ArtistList^.Max_Id + 1;
        InsertArtist(ArtistList);
      end;
    end;
  until Flag;
end;

// Вставить альбом в список.
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
  Write('Введите название альбома: ');
  readln(AlbumList^.Album.Name);
  Write('Введите год выпуска альбома: ');
  ReadNum(AlbumList^.Album.Year);
  Writeln;
end;

// Удалить альбом из списка.
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
    Write('Введите код альбома для удаления: ');
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
    Writeln('Альбома с таким кодом нет в списке.')
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

// Найти альбом по коду.
Procedure SearchALbum(AlbumList: TAdrOfAlbumList);
var
  Flag: Boolean;
  SearchID: Integer;
begin
  Write('Введите код альбома: ');
  ReadNum(SearchID);
  Flag := False;
  while (AlbumList^.next <> nil) and not(Flag) do
  begin
    AlbumList := AlbumList^.next;
    if AlbumList^.Album.ID = SearchID then
    begin
      Flag := True;
      Writeln('|-------------|-----------------|----------------------|------------|');
      Writeln('| Код альбома | Код исполнителя |   Название альбома   | Год записи |');
      Writeln('|-------------|-----------------|----------------------|------------|');
      Writeln('|', AlbumList^.Album.ID:12, ' |', AlbumList^.Album.ID_Artist:16,
        ' |', AlbumList^.Album.Name:21, ' |', AlbumList^.Album.Year:11, ' |');
      Writeln('|-------------|-----------------|----------------------|------------|');
    end;
  end;
  if not(Flag) then
    Writeln('Альбома с таким кодом нет в списке.');
  Writeln;
end;

// Выбор поля для редактирования альбома
Procedure EditAlbumMenu(AlbumList: TAdrOfAlbumList);
var
  Menu: Integer;
begin
  repeat
    Writeln('Меню редактирования:');
    Writeln('1. Редактировать название альбома.');
    Writeln('2. Редактировать год издания альбома.');
    Writeln('0. Выход из подменю редактирования исполнителя.');
    ReadNum(Menu);
    case Menu of
      1:
        begin
          Write('Введите новое название альбома: ');
          readln(AlbumList^.Album.Name);
        end;

      2:
        begin
          Write('Введите год записи: ');
          ReadNum(AlbumList^.Album.Year);
        end;
    end;
  until Menu = 0;
end;

// Редактировать информацию о альбоме.
Procedure EditAlbum(AlbumList: TAdrOfAlbumList);
var
  Flag: Boolean;
  ID: Integer;
begin
  WatchALbumList(AlbumList);
  Write('Введите код альбома для редакирования: ');
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
    Writeln('Альбома с таким кодом не существует.');
  Writeln;
end;

end.
