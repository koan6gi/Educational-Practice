unit AllTypesInProject;

interface
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
implementation

end.
