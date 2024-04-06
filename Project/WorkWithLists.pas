unit WorkWithLists;

interface

uses
  AllTypesInProject;
Procedure ReadNum(var n: Integer);

Procedure WatchArtistList(ArtistList: TAdrOfArtistList);
Procedure InsertArtist(ArtistList: TAdrOfArtistList);
Procedure DeleteArtist(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);
Procedure SearchArtist(ArtistList: TAdrOfArtistList);
Procedure EditArtist(ArtistList: TAdrOfArtistList);

Procedure WatchALbumList(AlbumList: TAdrOfAlbumList);
Procedure InsertAlbum(AlbumList: TAdrOfAlbumList; ArtistList: TAdrOfArtistList);
Procedure DeleteAlbum(AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  CheckID: Integer);
Procedure SearchALbum(AlbumList: TAdrOfAlbumList);
Procedure EditAlbum(AlbumList: TAdrOfAlbumList);

Procedure WatchSongList(SongList: TAdrOfSongList);
Procedure InsertSong(SongList: TAdrOfSongList; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
Procedure DeleteSong(SongList: TAdrOfSongList; CheckID: Integer);
Procedure SearchSong(SongList: TAdrOfSongList);
Procedure EditSong(SongList: TAdrOfSongList);

implementation

Procedure ReadNum(var n: Integer);
var
  S: String;
  Err: Integer;
begin
  Err := 0;
  repeat
    readln(S);
    Val(S, n, Err);
    if (Err <> 0) or (n < 0) then
      Write('Некорректный ввод. Введите снова: ');
  until (Err = 0) and (n >= 0);
end;

{ \\\\\\\\\\ Work with ArtistList ////////// }

// Просмотреть список исполнителей.
Procedure WatchArtistList(ArtistList: TAdrOfArtistList);
begin
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  Writeln('| Код исполнителя |  Имя исполнителя  | Страна исполнителя | Направление исполнителя |');
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  while ArtistList^.next <> nil do
  begin
    ArtistList := ArtistList^.next;
    Writeln('|', ArtistList^.Artist.ID:16, ' |', ArtistList^.Artist.Name:18,
      ' |', ArtistList^.Artist.Country:19, ' |', ArtistList^.Artist.Direction
      :24, ' |');
  end;
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  Writeln;
end;

// Проверка на существование исполнителя.
Function IsArtistAlreadyExist(ArtistList: TAdrOfArtistList;
  TmpArtist: TArtist): Boolean;
begin
  Result := False;
  while ArtistList^.next <> nil do
  begin
    ArtistList := ArtistList^.next;
    if (ArtistList^.Artist.Name = TmpArtist.Name) and
      (ArtistList^.Artist.Country = TmpArtist.Country) and
      (ArtistList^.Artist.Direction = TmpArtist.Direction) then
      Result := True;
  end;
end;

// Вставить исполнителя в список.
Procedure InsertArtist(ArtistList: TAdrOfArtistList);
var
  MaxId: Integer;
  Tmp: TAdrOfArtistList;
  TmpArtist: TArtist;
begin
  Write('Введите имя исполнителя: ');
  readln(TmpArtist.Name);
  Write('Введите страну исполнителя: ');
  readln(TmpArtist.Country);
  Write('Введите направление песен исполнителя: ');
  readln(TmpArtist.Direction);

  if not(IsArtistAlreadyExist(ArtistList, TmpArtist)) then
  begin
    Inc(ArtistList^.Max_Id);
    MaxId := ArtistList^.Max_Id;
    Tmp := ArtistList^.next;
    New(ArtistList^.next);
    ArtistList := ArtistList^.next;
    TmpArtist.ID := MaxId;
    ArtistList^.Artist := TmpArtist;
    ArtistList^.next := Tmp;
  end
  else
    Writeln('Такой исполнитель уже существует.');
  Writeln;
end;

// Удалить исполнителя из списка.
Procedure DeleteArtist(ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList);
var
  IDForDelete: Integer;
  Tmp: TAdrOfArtistList;
  TmpAlbumList: TAdrOfAlbumList;
  Flag: Boolean;
begin
  WatchArtistList(ArtistList);
  Write('Введите код исполнителя для удаления: ');
  ReadNum(IDForDelete);
  Flag := False;

  While Not(Flag) and (ArtistList^.next <> nil) do
  begin
    if ArtistList^.next^.Artist.ID = IDForDelete then
    begin
      Flag := True;

      Tmp := ArtistList^.next;
      ArtistList^.next := ArtistList^.next^.next;
      Dispose(Tmp);
    end;
    ArtistList := ArtistList^.next;
  end;

  if Not(Flag) then
    Writeln('Исполнителя с таким кодом нет в списке.')
  else
  begin
    New(TmpAlbumList);
    TmpAlbumList^.next := AlbumList;
    while AlbumList <> nil do
    begin
      if (AlbumList^.next <> nil) and
        (AlbumList^.next^.Album.ID_Artist = IDForDelete) then
      begin
        DeleteAlbum(TmpAlbumList^.next, SongList, AlbumList^.next^.Album.ID);
        AlbumList := TmpAlbumList;
      end;
      AlbumList := AlbumList^.next;
    end;
  end;
  Writeln;
end;

// Найти исполнителя в списке.
Procedure SearchArtist(ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  SearchID: Integer;
begin
  Write('Введите код исполнителя: ');
  ReadNum(SearchID);
  Flag := False;
  while (ArtistList^.next <> nil) and not(Flag) do
  begin
    ArtistList := ArtistList^.next;
    if ArtistList^.Artist.ID = SearchID then
    begin
      Flag := True;
      Writeln('|-----------------|-------------------|--------------------|-------------------------|');
      Writeln('| Код исполнителя |  Имя исполнителя  | Страна исполнителя | Направление исполнителя |');
      Writeln('|-----------------|-------------------|--------------------|-------------------------|');
      Writeln('|', ArtistList^.Artist.ID:16, ' |', ArtistList^.Artist.Name:18,
        ' |', ArtistList^.Artist.Country:19, ' |', ArtistList^.Artist.Direction
        :24, ' |');
      Writeln('|-----------------|-------------------|--------------------|-------------------------|');
    end;
  end;
  if not(Flag) then
    Writeln('Исполнителя с таким кодом нет в списке.');
  Writeln;
end;

// Выбор поля для редактирования исполнителя
Procedure EditArtistMenu(ArtistList: TAdrOfArtistList);
var
  Menu: Integer;
begin
  repeat
    Writeln('Меню редактирования:');
    Writeln('1. Редактировать имя исполнителя.');
    Writeln('2. Редактировать страну исполнителя.');
    Writeln('3. Редактировать направление исполнителя.');
    Writeln('0. Выход из подменю редактирования исполнителя.');
    ReadNum(Menu);
    case Menu of
      1:
        begin
          Write('Введите новое имя исполнителя: ');
          readln(ArtistList^.Artist.Name);
        end;

      2:
        begin
          Write('Введите страну исполнителя: ');
          readln(ArtistList^.Artist.Country);
        end;

      3:
        begin
          Write('Введите направление исполнителя: ');
          readln(ArtistList^.Artist.Direction);
        end;
    end;
  until Menu = 0;
end;

// Редактировать информацию о исполнителе.
Procedure EditArtist(ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  ID: Integer;
begin
  WatchArtistList(ArtistList);
  Write('Введите код исполнителя для редакирования: ');
  readln(ID);
  Flag := False;
  while (ArtistList^.next <> nil) and not(Flag) do
  begin
    ArtistList := ArtistList^.next;
    if ArtistList^.Artist.ID = ID then
    begin
      Flag := True;
      EditArtistMenu(ArtistList);
    end;
  end;

  if not(Flag) then
    Writeln('Исполнителя с таким кодом не существует.');
  Writeln;
end;

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
        Flag := True;
      end;
    end;
  until Flag;
end;

// Проверка на существование альбома.
Function IsAlbumAlreadyExist(AlbumList: TAdrOfAlbumList;
  TmpAlbum: TAlbum): Boolean;
begin
  Result := False;
  while AlbumList^.next <> nil do
  begin
    AlbumList := AlbumList^.next;
    if (AlbumList^.Album.Name = TmpAlbum.Name) and
      (AlbumList^.Album.ID_Artist = TmpAlbum.ID_Artist) and
      (AlbumList^.Album.Year = TmpAlbum.Year) then
      Result := True;
  end;
end;

// Вставить альбом в список.
Procedure InsertAlbum(AlbumList: TAdrOfAlbumList; ArtistList: TAdrOfArtistList);
var
  MaxId: Integer;
  TmpAlbum: TAlbum;
begin
  ReadID_Artist(TmpAlbum.ID_Artist, ArtistList);
  Write('Введите название альбома: ');
  readln(TmpAlbum.Name);
  Write('Введите год выпуска альбома: ');
  ReadNum(TmpAlbum.Year);

  if not(IsAlbumAlreadyExist(AlbumList, TmpAlbum)) then
  begin
    Inc(AlbumList^.Max_Id);
    MaxId := AlbumList^.Max_Id;
    while AlbumList^.next <> nil do
      AlbumList := AlbumList^.next;
    New(AlbumList^.next);
    AlbumList := AlbumList^.next;
    TmpAlbum.ID := MaxId;
    AlbumList^.Album := TmpAlbum;
    AlbumList^.next := nil;
  end
  else
    Writeln('Такой альбом уже существует.');

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
  Menu := 0;
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
        Flag := True;
      end;
    end;
  until Flag;
end;

// Проверка на существование песни.
Function IsSongAlreadyExist(SongList: TAdrOfSongList; TmpSong: TSong): Boolean;
begin
  Result := False;
  while SongList^.next <> nil do
  begin
    SongList := SongList^.next;
    if (SongList^.Song.Name = TmpSong.Name) and
      (SongList^.Song.ID_Album = TmpSong.ID_Album) and
      (SongList^.Song.Length = TmpSong.Length) then
      Result := True;
  end;
end;

// Вставить песню в список.
Procedure InsertSong(SongList: TAdrOfSongList; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
var
  MaxId: Integer;
  Tmp: TAdrOfSongList;
  TmpSong: TSong;
begin
  ReadID_Album(TmpSong.ID_Album, AlbumList, ArtistList);
  Write('Введите название песни: ');
  readln(TmpSong.Name);
  Write('Введите длину песни в секундах: ');
  ReadNum(TmpSong.Length);

  if not(IsSongAlreadyExist(SongList, TmpSong)) then
  begin
    Inc(SongList^.Max_Id);
    MaxId := SongList^.Max_Id;
    Tmp := SongList^.next;
    New(SongList^.next);
    SongList := SongList^.next;
    TmpSong.ID := MaxId;
    SongList^.Song := TmpSong;
    SongList^.next := Tmp;
  end
  else
    Writeln('Такая песня уже существует.');
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
