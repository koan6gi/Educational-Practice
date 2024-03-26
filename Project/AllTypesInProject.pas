unit AllTypesInProject;

interface

Type
  TAdrOfArtistList = ^TArtistList;
  TAdrOfAlbumList = ^TAlbumList;
  TAdrOfSongList = ^TSongList;

  NameString = String[20];
  DirectionString = String[15];

  TArtist = record
    ID: Integer;
    Name: NameString;
    Country: NameString;
    Direction: DirectionString;
  end;

  TArtistFile = File of TArtist;

  TAlbum = record
    ID: Integer;
    ID_Artist: Integer;
    Name: NameString;
    Year: Integer;
  end;

  TAlbumFile = File of TAlbum;

  TSong = record
    ID: Integer;
    Name: NameString;
    ID_Album: Integer;
    Length: Integer;
  end;

  TSongFile = File of TSong;

  TArtistList = record
    next: TAdrOfArtistList;
    Max_Id: Integer;
    Artist: TArtist;
  end;

  TAlbumList = record
    next: TAdrOfAlbumList;
    Max_Id: Integer;
    ALbum: TAlbum;
  end;

  TSongList = record
    next: TAdrOfSongList;
    Max_Id: Integer;
    Song: TSong;
  end;

implementation

end.
