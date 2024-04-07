unit AllTypesInProject;

interface

Type
  TAdrOfArtistList = ^TArtistList;
  TAdrOfAlbumList = ^TAlbumList;
  TAdrOfSongList = ^TSongList;

  TDataString = String[20];
  TDirString = String[15];

  TArtist = record
    ID: Integer;
    Name: TDataString;
    Country: TDataString;
    Direction: TDirString;
  end;

  TArtistFile = File of TArtist;

  TAlbum = record
    ID: Integer;
    ID_Artist: Integer;
    Name: TDataString;
    Year: Integer;
  end;

  TAlbumFile = File of TAlbum;

  TSong = record
    ID: Integer;
    Name: TDataString;
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

  PInput_Search = Procedure(var ID: Integer; var S: TDataString);
  FCondEq_Search = Function(var Element; var ID: Integer;
    var S: TDataString): Boolean;

implementation

end.
