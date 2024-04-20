unit WorkWithFiles;

interface

uses AllTypesInProject;

// ReWrite All Lists in files
Procedure ReWriteAllListsInFiles(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile);

Procedure MenuReadFiles(var State: Integer; var CurrSession: String;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);

implementation

uses SysUtils, IOUtils;

{ \\\\\\\\\\ Work with ArtistFile ////////// }

// Read ArtistList from file
Procedure ReadArtistListFromFile(ArtistList: TAdrOfArtistList;
  var ArtistFile: TArtistFile);

begin
  Assign(ArtistFile, 'ArtistFile');
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
    end;
  end;

  Close(ArtistFile);
end;

// ReWrite ArtistList in file
Procedure ReWriteArtistListInFile(ArtistList: TAdrOfArtistList;
  var ArtistFile: TArtistFile);
begin
  Assign(ArtistFile, 'ArtistFile');
  ReWrite(ArtistFile);

  ArtistList^.Artist.ID := ArtistList^.Max_Id;

  while ArtistList <> nil do
  begin

    Write(ArtistFile, ArtistList^.Artist);
    ArtistList := ArtistList^.next;
  end;

  Close(ArtistFile);
end;

{ \\\\\\\\\\ Work with AlbumFile ////////// }

// Read AlbumList from file
Procedure ReadAlbumListFromFile(AlbumList: TAdrOfAlbumList;
  var AlbumFile: TAlbumFile);
begin
  Assign(AlbumFile, 'AlbumFile');
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
    end;
  end;

  Close(AlbumFile);
end;

// ReWrite AlbumList in file
Procedure ReWriteAlbumListInFile(AlbumList: TAdrOfAlbumList;
  var AlbumFile: TAlbumFile);
begin
  Assign(AlbumFile, 'AlbumFile');
  ReWrite(AlbumFile);

  AlbumList^.Album.ID := AlbumList^.Max_Id;

  while AlbumList <> nil do
  begin

    Write(AlbumFile, AlbumList^.Album);
    AlbumList := AlbumList^.next;
  end;

  Close(AlbumFile);
end;

{ \\\\\\\\\\ Work with SongFile ////////// }

// Read SongList from file
Procedure ReadSongListFromFile(SongList: TAdrOfSongList;
  var SongFile: TSongFile);
begin
  Assign(SongFile, 'SongFile');
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
    end;
  end;

  Close(SongFile);
end;

// ReWrite SongList in file
Procedure ReWriteSongListInFile(SongList: TAdrOfSongList;
  var SongFile: TSongFile);
begin
  Assign(SongFile, 'SongFile');
  ReWrite(SongFile);

  SongList^.Song.ID := SongList^.Max_Id;

  while SongList <> nil do
  begin

    Write(SongFile, SongList^.Song);
    SongList := SongList^.next;
  end;

  Close(SongFile);
end;

Procedure CheckAllFiles(var State: Integer);
begin
  if FileExists('ArtistFile') and FileExists('AlbumFile') and
    FileExists('SongFile') then
    State := 1
  Else
    State := 3;

end;

// Read All Lists from files
Procedure ReadAllListsFromFiles(var State: Integer;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);
begin
  CheckAllFiles(State);
  if State = 1 then
  begin
    ReadArtistListFromFile(ArtistList, ArtistFile);
    ReadAlbumListFromFile(AlbumList, AlbumFile);
    ReadSongListFromFile(SongList, SongFile);
  end;
end;

// ReWrite All Lists in files
Procedure ReWriteAllListsInFiles(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile);
begin
  ReWriteArtistListInFile(ArtistList, ArtistFile);
  ReWriteAlbumListInFile(AlbumList, AlbumFile);
  ReWriteSongListInFile(SongList, SongFile);
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

Function SearchInArr(const Arr: TArrOfDir; const item: Integer): Integer;
var
  Flag: Boolean;
  i: Integer;
begin
  i := Low(Arr);
  Flag := true;
  result := -1;
  while Flag and (i <= High(Arr)) do
  begin
    if item = Arr[i].ID then
    begin
      result := i;
      Flag := false;
    end;
    Inc(i);
  end;

end;

Type
  TReqForInput = Set of Char;

Procedure CreateNewSession(var CurrSession: String);
var
  NameSession: String;
  ReqForInput: TReqForInput;
  Flag: Boolean;
  i: Integer;
begin
  Flag := true;
  ReqForInput := [' ', 'A' .. 'Z', 'a' .. 'z', 'А' .. 'Я', 'а' .. 'я',
    '0' .. '9'];
  Writeln('Введите имя новой сессии.');
  Writeln('Правила для ввода имени.');
  Writeln('Длина должна быть от 1 до 50 символов.');
  Writeln('В состав названия могут входить буквы английского');
  Writeln('и русского алфавитов, числа и пробелы.');
  Write('Имя сессии: ');
  repeat
    if Not(Flag) then
      Write('Неверный формат ввода. Введите снова: ');

    Readln(NameSession);
    if (Length(NameSession) = 0) or DirectoryExists('.\files\' + NameSession)
    then
    begin
      Flag := false;
    end
    else
      for i := Low(NameSession) to High(NameSession) do
        if Not(NameSession[i] in ReqForInput) then
        begin
          Flag := false;
          break;
        end;

  until Flag;

end;

//
Procedure MenuReadFiles(var State: Integer; var CurrSession: String;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);
var
  i: Integer;
  ArrOfDirectories: TArrOfDir;
begin
  GetAllDirectories(ArrOfDirectories);
  Writeln('Меню чтения из файла.');
  for i := Low(ArrOfDirectories) to High(ArrOfDirectories) do
    Writeln(ArrOfDirectories[i].ID, ' ', ArrOfDirectories[i].Dir);

  if Length(ArrOfDirectories) = 0 then
  begin
    CreateNewSession(CurrSession);
  end
  else
  begin

  end;
end;

end.
