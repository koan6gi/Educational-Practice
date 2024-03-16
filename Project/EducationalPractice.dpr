program EducationalPractice;

uses
  System.SysUtils;

Type
  TypeOfList = (Artist, Album, Song);

  TAdrOfList = ^TList;

  TArtist = record
    ID: Integer;
    Name: String[20];
    Country: String[20];
    Direction: String[20];
  end;

  TArtistFile = File of TArtist;

  TAlbum = record
    ID: Integer;
    ID_Artist: Integer;
    Name: String[20];
    Year: Integer;
  end;

  TAlbumFile = File of TAlbum;

  TSong = record
    Name: String[20];
    ID_Album: Integer;
    Length: Integer;
  end;

  TSongFile = File of TSong;

  TList = record
    next: TAdrOfList;
    Max_Id: Integer;
    case ListType: TypeOfList of
      Artist:
        (Artist: TArtist);
      Album:
        (Album: TAlbum);
      Song:
        (Song: TSong);
  end;

Procedure ReadArtistListFromFile(ArtistList: TAdrOfList;
  var ArtistFile: TArtistFile);
var
  MaxID: ^Integer;
begin
  Assign(ArtistFile, GetCurrentDir() + '\ArtistFile');
  Reset(ArtistFile);
  MaxID := @ArtistList^.Max_Id;
  repeat
    New(ArtistList^.next);
    ArtistList := ArtistList^.next;
    Inc(MaxID^);
    Read(ArtistFile, ArtistList^.Artist);
  until Eof(ArtistFile);
  Close(ArtistFile);
end;

Procedure ReadAlbumListFromFile(AlbumList: TAdrOfList;
  var AlbumFile: TAlbumFile);
var
  MaxID: ^Integer;
begin
  Assign(AlbumFile, GetCurrentDir() + '\AlbumFile');
  Reset(AlbumFile);
  MaxID := @AlbumList^.Max_Id;
  repeat
    New(AlbumList^.next);
    AlbumList := AlbumList^.next;
    Inc(MaxID^);
    Read(AlbumFile, AlbumList^.Album);
  until Eof(AlbumFile);
  Close(AlbumFile);
end;

Procedure ReadSongListFromFile(SongList: TAdrOfList; var SongFile: TSongFile);
var
  MaxID: ^Integer;
begin
  Assign(SongFile, GetCurrentDir() + '\SongFile');
  Reset(SongFile);
  MaxID := @SongList^.Max_Id;
  repeat
    New(SongList^.next);
    SongList := SongList^.next;
    Inc(MaxID^);
    Read(SongFile, SongList^.Song);
  until Eof(SongFile);
  Close(SongFile);
end;

var
  ArtistList, AlbumList, SongList: TAdrOfList;
  ArtistFile: TArtistFile;
  AlbumFile: TAlbumFile;
  SongFile: TSongFile;
  Menu: Integer;

begin
  New(ArtistList);
  ArtistList^.ListType := Artist;
  ArtistList^.Max_Id := 0;

  New(AlbumList);
  AlbumList^.ListType := Album;
  AlbumList^.Max_Id := 0;

  New(SongList);
  SongList^.ListType := Song;
  SongList^.Max_Id := 0;
  Repeat
    case Menu of
      1:
        begin
          ReadArtistListFromFile(ArtistList, ArtistFile);
          ReadAlbumListFromFile(AlbumList, AlbumFile);
          ReadSongListFromFile(SongList, SongFile);
        end;

      2:
        begin

        end;

      3:
        begin

        end;

      4:
        begin

        end;

      5:
        begin

        end;

      6:
        begin

        end;

      7:
        begin

        end;

      8:
        begin

        end;

      10:
        begin

        end;
    end;
  Until (Menu = 9);

  readln;

end.
