unit AllTypesInProject;

interface

Type
  TAdrOfArtistList = ^TArtistList;
  TAdrOfAlbumList = ^TAlbumList;
  TAdrOfSongList = ^TSongList;

  TArrayOfIndexes = array of Integer;

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
    Album: TAlbum;
  end;

  TSongList = record
    next: TAdrOfSongList;
    Max_Id: Integer;
    Song: TSong;
  end;

  TAdrOfList = ^TList;
  TTypeList = (Artist, Album, Song);

  TList = record
    next: TAdrOfList;
    Max_Id: Integer;
    case TTypeList of
      Artist:
        (Artist: TArtist);
      Album:
        (Album: TAlbum);
      Song:
        (Song: TSong);
  end;

  PInput_Search = Procedure(var ID: Integer; var S: TDataString);
  FCondEq_Search = Function(var Element; var ID: Integer;
    var S: TDataString): Boolean;

  FCompareTo = Function(Self, o: TAdrOfList;
    const ArrIn: TArrayOfIndexes): Boolean;

    TArrOfArrOfIndexes = array of TArrayOfIndexes;

  TArrOfLists = array of TAdrOfSongList;

Procedure Add10(var Arr: TArrayOfIndexes);
Procedure ReadNum(var n: Integer);

implementation

Procedure Add10(var Arr: TArrayOfIndexes);
var
  OldLast, I: Integer;
begin
  OldLast := Length(Arr);
  SetLength(Arr, Length(Arr) + 10);
  for I := OldLast to High(Arr) do
    Arr[I] := 0;
end;

Procedure ReadNum(var n: Integer);
var
  S: String;
  Err: Integer;
begin
  Err := 0;
  repeat
    readln(S);
    Val(S, n, Err);
    if (Err <> 0) or (n < 0) then
      Write('Некорректный ввод. Введите снова: ');
  until (Err = 0) and (n >= 0);
end;

end.
