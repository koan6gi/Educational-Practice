unit WorkWithFiles;

interface

uses AllTypesInProject;

// ReWrite All Lists in files
Procedure ReWriteAllListsInFiles(var CurrSession: String;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);

Procedure MenuReadFiles(var State: TStateOfFile; var CurrSession: String;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);

implementation

uses SysUtils, IOUtils;

{ \\\\\\\\\\ Work with ArtistFile ////////// }

// Read ArtistList from file
Procedure ReadArtistListFromFile(var CurrSession: String;
  ArtistList: TAdrOfArtistList; var ArtistFile: TArtistFile);

begin
  Assign(ArtistFile, CurrSession + '\ArtistFile');
  Reset(ArtistFile);

  if Not(Eof(ArtistFile)) then
  begin
    Read(ArtistFile, ArtistList^.Artist);
    ArtistList^.Max_Id := ArtistList^.Artist.ID;

    while Not(Eof(ArtistFile)) do
    begin
      New(ArtistList^.next);
      ArtistList := ArtistList^.next;
      Read(ArtistFile, ArtistList^.Artist);
      ArtistList^.next := nil;
    end;
  end;

  CloseFile(ArtistFile);
end;

// ReWrite ArtistList in file
Procedure ReWriteArtistListInFile(var CurrSession: String;
  ArtistList: TAdrOfArtistList; var ArtistFile: TArtistFile);
begin
  Assign(ArtistFile, CurrSession + '\ArtistFile');
  ReWrite(ArtistFile);

  ArtistList^.Artist.ID := ArtistList^.Max_Id;

  while ArtistList <> nil do
  begin

    Write(ArtistFile, ArtistList^.Artist);
    ArtistList := ArtistList^.next;
  end;

  CloseFile(ArtistFile);
end;

{ \\\\\\\\\\ Work with AlbumFile ////////// }

// Read AlbumList from file
Procedure ReadAlbumListFromFile(var CurrSession: String;
  AlbumList: TAdrOfAlbumList; var AlbumFile: TAlbumFile);
begin
  Assign(AlbumFile, CurrSession + '\AlbumFile');
  Reset(AlbumFile);
  if Not(Eof(AlbumFile)) then
  begin
    Read(AlbumFile, AlbumList^.Album);
    AlbumList^.Max_Id := AlbumList^.Album.ID;

    while Not(Eof(AlbumFile)) do
    begin
      New(AlbumList^.next);
      AlbumList := AlbumList^.next;
      Read(AlbumFile, AlbumList^.Album);
      AlbumList^.next := nil;
    end;
  end;

  CloseFile(AlbumFile);
end;

// ReWrite AlbumList in file
Procedure ReWriteAlbumListInFile(var CurrSession: String;
  AlbumList: TAdrOfAlbumList; var AlbumFile: TAlbumFile);
begin
  Assign(AlbumFile, CurrSession + '\AlbumFile');
  ReWrite(AlbumFile);

  AlbumList^.Album.ID := AlbumList^.Max_Id;

  while AlbumList <> nil do
  begin

    Write(AlbumFile, AlbumList^.Album);
    AlbumList := AlbumList^.next;
  end;

  CloseFile(AlbumFile);
end;

{ \\\\\\\\\\ Work with SongFile ////////// }

// Read SongList from file
Procedure ReadSongListFromFile(var CurrSession: String;
  SongList: TAdrOfSongList; var SongFile: TSongFile);
begin
  Assign(SongFile, CurrSession + '\SongFile');
  Reset(SongFile);

  if Not(Eof(SongFile)) then
  begin
    Read(SongFile, SongList^.Song);
    SongList^.Max_Id := SongList^.Song.ID;

    while Not(Eof(SongFile)) do
    begin
      New(SongList^.next);
      SongList := SongList^.next;
      Read(SongFile, SongList^.Song);
      SongList^.next := nil;
    end;
  end;

  CloseFile(SongFile);
end;

// ReWrite SongList in file
Procedure ReWriteSongListInFile(var CurrSession: String;
  SongList: TAdrOfSongList; var SongFile: TSongFile);
begin
  Assign(SongFile, CurrSession + '\SongFile');
  ReWrite(SongFile);

  SongList^.Song.ID := SongList^.Max_Id;

  while SongList <> nil do
  begin

    Write(SongFile, SongList^.Song);
    SongList := SongList^.next;
  end;

  CloseFile(SongFile);
end;

Procedure CheckAllFiles(const CurrSession: String; var State: TStateOfFile);
begin
  if FileExists(CurrSession + '\ArtistFile') and
    FileExists(CurrSession + '\AlbumFile') and
    FileExists(CurrSession + '\SongFile') then
    State := FileExist
  else
    State := FileNotExist;

end;

// Read All Lists from files
Procedure ReadAllListsFromFiles(var State: TStateOfFile;
  var CurrSession: String; ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile);
begin
  CheckAllFiles(CurrSession, State);
  if State = FileExist then
  begin
    ReadArtistListFromFile(CurrSession, ArtistList, ArtistFile);
    ReadAlbumListFromFile(CurrSession, AlbumList, AlbumFile);
    ReadSongListFromFile(CurrSession, SongList, SongFile);
  end;
end;

// ReWrite All Lists in files
Procedure ReWriteAllListsInFiles(var CurrSession: String;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);
begin
  ReWriteArtistListInFile(CurrSession, ArtistList, ArtistFile);
  ReWriteAlbumListInFile(CurrSession, AlbumList, AlbumFile);
  ReWriteSongListInFile(CurrSession, SongList, SongFile);
end;

//
Procedure GetAllDirectories(var ArrOfDirectories: TArrOfDir);
var
  i: Integer;
  S: String;
begin
  i := 0;
  for S in TDirectory.GetDirectories('.\files') do
  begin
    Inc(i);
    Setlength(ArrOfDirectories, i);
    ArrOfDirectories[i - 1].ID := i;
    ArrOfDirectories[i - 1].Dir := S;
  end;

end;

Function SearchInArr(const Arr: TArrOfDir; const item: Integer): TDir;
var
  Flag: Boolean;
  i: Integer;
begin
  i := Low(Arr);
  Flag := true;
  result.ID := -1;
  while Flag and (i <= High(Arr)) do
  begin
    if item = Arr[i].ID then
    begin
      result := Arr[i];
      Flag := false;
    end;
    Inc(i);
  end;

end;

Procedure CreateNewSession(var CurrSession: String);
var
  NameSession: String;
  Flag: Boolean;
  i: Integer;
begin
  Flag := true;
  Writeln('Введите имя новой сессии.');
  Writeln('Правила для ввода имени.');
  Writeln('Длина должна быть от 1 до 50 символов.');
  Writeln('В состав названия могут входить буквы английского');
  Writeln('алфавита, числа и пробелы.');
  Write('Имя сессии: ');
  repeat
    if Not(Flag) then
      Write('Неверный формат ввода. Введите снова: ');

    Readln(NameSession);
    Flag := true;
    if (Length(NameSession) = 0) or DirectoryExists('.\files\' + NameSession)
    then
    begin
      Flag := false;
    end
    else
      for i := Low(NameSession) to High(NameSession) do
        if Not(CharInSet(NameSession[i], [' ', 'A' .. 'Z', 'a' .. 'z',
          '0' .. '9'])) then
        begin
          Flag := false;
          break;
        end;
  until Flag;

  CurrSession := '.\files\' + NameSession;
  TDirectory.CreateDirectory(CurrSession);

end;

Procedure ChooseSession(const ArrOfDirectories: TArrOfDir;
  var CurrSession: String);
var
  Flag: Boolean;
  IDSession: Integer;
  Dir: TDir;
begin
  Flag := true;
  Write('Введите номер сессии: ');
  repeat
    if Not(Flag) then
      Write('Неверный формат ввода. Введите снова: ');

    ReadNum(IDSession);
    Flag := true;

    Dir := SearchInArr(ArrOfDirectories, IDSession);
    if Dir.ID = -1 then
      Flag := false;
  until Flag;
  CurrSession := Dir.Dir;
end;

//
Procedure MenuReadFiles(var State: TStateOfFile; var CurrSession: String;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);
var
  i, Menu: Integer;
  ArrOfDirectories: TArrOfDir;

begin
  if Not(TDirectory.Exists('.\files')) then
    TDirectory.CreateDirectory('.\files');

  GetAllDirectories(ArrOfDirectories);
  Writeln('Меню чтения из файла.');
  for i := Low(ArrOfDirectories) to High(ArrOfDirectories) do
    Writeln(ArrOfDirectories[i].ID, ' ', ArrOfDirectories[i].Dir);

  if (Length(ArrOfDirectories) = 0) or (State = ListChanged) then
  begin
    CreateNewSession(CurrSession);
  end
  else
  begin
    Writeln('Выберите действие:');
    Writeln('1. Выбрать существующую сессию.');
    Writeln('2. Создать новую сессию.');
    ReadNum(Menu);
    case Menu of
      1:
        begin
          ChooseSession(ArrOfDirectories, CurrSession);
          ReadAllListsFromFiles(State, CurrSession, ArtistList, AlbumList,
            SongList, ArtistFile, AlbumFile, SongFile);
        end;
      2:
        begin
          CreateNewSession(CurrSession);
        end;
    end;

  end;
end;

end.
