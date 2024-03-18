unit AllTypesInProject;

interface

Type
  TypeOfList = (Artist, Album, Song);

  TAdrOfList = ^TList;

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
