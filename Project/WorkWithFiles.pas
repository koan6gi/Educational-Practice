unit WorkWithFiles;

interface

uses AllTypesInProject;

// Read All Lists from files
Procedure ReadAllListsFromFiles(ArtistList, AlbumList, SongList: TAdrOfList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile);

// ReWrite All Lists in files
Procedure ReWriteAllListsInFiles(ArtistList, AlbumList, SongList: TAdrOfList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile);

implementation

{ Work with ArtistFile }

// Read ArtistList from file
Procedure ReadArtistListFromFile(ArtistList: TAdrOfList;
  var ArtistFile: TArtistFile);
var
  MaxID: ^Integer;
begin
  Assign(ArtistFile, 'ArtistFile');
  Reset(ArtistFile);
  MaxID := @ArtistList^.Max_Id;

  while Not(Eof(ArtistFile)) do
  begin
    New(ArtistList^.next);
    ArtistList := ArtistList^.next;
    Inc(MaxID^);
    Read(ArtistFile, ArtistList^.Artist);
  end;

  Close(ArtistFile);
end;

// ReWrite ArtistList in file
Procedure ReWriteArtistListInFile(ArtistList: TAdrOfList;
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

{ Work with AlbumFile }

// Read AlbumList from file
Procedure ReadAlbumListFromFile(AlbumList: TAdrOfList;
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
    Inc(MaxID^);
    Read(AlbumFile, AlbumList^.Album);
  end;

  Close(AlbumFile);
end;

// ReWrite AlbumList in file
Procedure ReWriteAlbumListInFile(AlbumList: TAdrOfList;
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

{ Work with SongFile }
// Read SongList from file
Procedure ReadSongListFromFile(SongList: TAdrOfList; var SongFile: TSongFile);
var
  MaxID: ^Integer;
begin
  Assign(SongFile, 'SongFile');
  Reset(SongFile);
  MaxID := @SongList^.Max_Id;

  while Not(Eof(SongFile)) do
  begin
    New(SongList^.next);
    SongList := SongList^.next;
    Inc(MaxID^);
    Read(SongFile, SongList^.Song);
  end;

  Close(SongFile);
end;

// ReWrite SongList in file
Procedure ReWriteSongListInFile(SongList: TAdrOfList; var SongFile: TSongFile);
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

// Read All Lists from files
Procedure ReadAllListsFromFiles(ArtistList, AlbumList, SongList: TAdrOfList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile);
begin
  ReadArtistListFromFile(ArtistList, ArtistFile);
  ReadAlbumListFromFile(AlbumList, AlbumFile);
  ReadSongListFromFile(SongList, SongFile);
end;

// ReWrite All Lists in files
Procedure ReWriteAllListsInFiles(ArtistList, AlbumList, SongList: TAdrOfList;
  var ArtistFile: TArtistFile; var AlbumFile: TAlbumFile;
  var SongFile: TSongFile);
begin
  ReWriteArtistListInFile(ArtistList, ArtistFile);
  ReWriteAlbumListInFile(AlbumList, AlbumFile);
  ReWriteSongListInFile(SongList, SongFile);
end;

end.
