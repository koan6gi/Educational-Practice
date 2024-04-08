unit WorkWithFiles;

interface

uses AllTypesInProject;

// Read All Lists from files
Procedure ReadAllListsFromFiles(var State: Integer;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);

// ReWrite All Lists in files
Procedure ReWriteAllListsInFiles(ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList; SongList: TAdrOfSongList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile);

implementation

{ \\\\\\\\\\ Work with ArtistFile ////////// }

// Read ArtistList from file
Procedure ReadArtistListFromFile(ArtistList: TAdrOfArtistList;
  var ArtistFile: TArtistFile);
var
  MaxID: ^Integer;
begin
  Assign(ArtistFile, 'ArtistFile');
  Reset(ArtistFile);
  MaxID := @ArtistList^.Max_Id;

  if Not(Eof(ArtistFile)) then
  begin
    New(ArtistList^.next);
    ArtistList := ArtistList^.next;
    Read(ArtistFile, ArtistList^.Artist);

    MaxID^ := ArtistList^.Artist.ID;
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

  while ArtistList^.next <> nil do
  begin
    ArtistList := ArtistList^.next;
    Write(ArtistFile, ArtistList^.Artist);
  end;

  Close(ArtistFile);
end;

{ \\\\\\\\\\ Work with AlbumFile ////////// }

// Read AlbumList from file
Procedure ReadAlbumListFromFile(AlbumList: TAdrOfAlbumList;
  var AlbumFile: TAlbumFile);
var
  MaxID: ^Integer;
begin
  Assign(AlbumFile, 'AlbumFile');
  Reset(AlbumFile);
  MaxID := @AlbumList^.Max_Id;

  while Not(Eof(AlbumFile)) do
  begin
    New(AlbumList^.next);
    AlbumList := AlbumList^.next;
    Read(AlbumFile, AlbumList^.Album);
  end;

  MaxID^ := AlbumList^.Album.ID;

  Close(AlbumFile);
end;

// ReWrite AlbumList in file
Procedure ReWriteAlbumListInFile(AlbumList: TAdrOfAlbumList;
  var AlbumFile: TAlbumFile);
begin
  Assign(AlbumFile, 'AlbumFile');
  ReWrite(AlbumFile);

  while AlbumList^.next <> nil do
  begin
    AlbumList := AlbumList^.next;
    Write(AlbumFile, AlbumList^.Album);
  end;

  Close(AlbumFile);
end;

{ \\\\\\\\\\ Work with SongFile ////////// }

// Read SongList from file
Procedure ReadSongListFromFile(SongList: TAdrOfSongList;
  var SongFile: TSongFile);
var
  MaxID: ^Integer;
begin
  Assign(SongFile, 'SongFile');
  Reset(SongFile);
  MaxID := @SongList^.Max_Id;

  if Not(Eof(SongFile)) then
  begin
    New(SongList^.next);
    SongList := SongList^.next;
    Read(SongFile, SongList^.Song);

    MaxID^ := SongList^.Song.ID;
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

  while SongList^.next <> nil do
  begin
    SongList := SongList^.next;
    Write(SongFile, SongList^.Song);
  end;

  Close(SongFile);
end;

Procedure CheckAllFiles(var State: Integer; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);
var
  Art: TArtist;
  Alb: TAlbum;
  Song: Tsong;
begin
  Assign(ArtistFile, 'ArtistFile');
  Reset(ArtistFile);
  Assign(AlbumFile, 'AlbumFile');
  Reset(AlbumFile);
  Assign(SongFile, 'SongFile');
  Reset(SongFile);
  try
    Read(ArtistFile, Art);
    Read(AlbumFile, Alb);
    Read(SongFile, Song);
    State := 1;
  except
    State := 3;
  end;
  Close(ArtistFile);
  Close(AlbumFile);
  Close(SongFile);
end;

// Read All Lists from files
Procedure ReadAllListsFromFiles(var State: Integer;
  ArtistList: TAdrOfArtistList; AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList; var ArtistFile: TArtistFile;
  var AlbumFile: TAlbumFile; var SongFile: TSongFile);
begin
  CheckAllFiles(State, ArtistFile, AlbumFile, SongFile);
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

end.
