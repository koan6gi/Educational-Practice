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

// Просмотреть список песен.
Procedure WatchSongList(SongList: TAdrOfSongList);
begin
  Writeln('|-----------|----------------------|-------------|--------------------|');
  Writeln('| Код песни |    Название песни    | Код альбома | Длительность песни |');
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

// Прочитать код альбома, предусмотрев его отсутствие.
Procedure ReadID_Album(var ID: Integer; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  AlbL: TAdrOfAlbumList;
  Menu: Integer;
begin
  repeat
    Write('Введите код альбома: ');
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
      Writeln('Альбома с таким кодом не существует.');
      Writeln('Желаете создать новый альбом?');
      Writeln('1. Да. / 0. Нет (Ввести код заново).');
      ReadNum(Menu);
      if Menu = 1 then
      begin
        ID := AlbumList^.Max_Id + 1;
        InsertAlbum(AlbumList, ArtistList);
      end;
    end;
  until Flag;
end;

// Вставить альбом в список.
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
  Write('Введите название песни: ');
  readln(SongList^.Song.Name);
  Write('Введите длину песни в секундах: ');
  ReadNum(SongList^.Song.Length);
  Writeln;
end;

// Удалить песню из списка.
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
    Write('Введите код песни для удаления: ');
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
    Writeln('Песни с таким кодом нет в списке.');
end;

// Найти песню по коду.
Procedure SearchSong(SongList: TAdrOfSongList);
var
  Flag: Boolean;
  SearchID: Integer;
begin
  Write('Введите код песни: ');
  ReadNum(SearchID);
  Flag := False;
  while (SongList^.next <> nil) and not(Flag) do
  begin
    SongList := SongList^.next;
    if SongList^.Song.ID = SearchID then
    begin
      Flag := True;
      Writeln('|-----------|----------------------|-------------|--------------------|');
      Writeln('| Код песни |    Название песни    | Код альбома | Длительность песни |');
      Writeln('|-----------|----------------------|-------------|--------------------|');
      Writeln('|', SongList^.Song.ID:10, ' |', SongList^.Song.Name:21, ' |',
        SongList^.Song.ID_Album:12, ' |', SongList^.Song.Length:19, ' |');
      Writeln('|-----------|----------------------|-------------|--------------------|');
    end;
  end;
  if not(Flag) then
    Writeln('Песни с таким кодом нет в списке.');
  Writeln;
end;

// Выбор поля для редактирования песни
Procedure EditSongMenu(SongList: TAdrOfSongList);
var
  Menu: Integer;
begin
  repeat
    Writeln('Меню редактирования:');
    Writeln('1. Редактировать название песни.');
    Writeln('2. Редактировать длительность песни.');
    Writeln('0. Выход из подменю редактирования исполнителя.');
    ReadNum(Menu);
    case Menu of
      1:
        begin
          Write('Введите название песни: ');
          readln(SongList^.Song.Name);
        end;

      2:
        begin
          Write('Введите длительность: ');
          ReadNum(SongList^.Song.Length);
        end;
    end;
  until Menu = 0;
end;

// Редактировать информацию о песне.
Procedure EditSong(SongList: TAdrOfSongList);
var
  Flag: Boolean;
  ID: Integer;
begin
  WatchSongList(SongList);
  Write('Введите код песни для редакирования: ');
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
    Writeln('Песни с таким кодом не существует.');
  Writeln;
end;

end.
