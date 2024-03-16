program EducationalPractice;

Type
  TypeOfList = (Artist, Album, Song);

  TAdr = ^TList;

  TArtist = record
    ID: Integer;
    Name: String[20];
    Country: String[20];
    Direction: String[20];
  end;

  TAlbum = record
    ID: Integer;
    ID_Artist: Integer;
    Name: String[20];
    Year: Integer;
  end;

  TSong = record
    Name: String[20];
    ID_Album: Integer;
    Length: Integer;
  end;

  TList = record
    next: TAdr;
    case TypeOfList of
      Artist:
        (Artist: TArtist);
      Album:
        (Album: TAlbum);
      Song:
        (Song: TSong);
  end;


begin

end.
