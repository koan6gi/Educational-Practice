unit AdditionalFunctionsForLists;

interface

uses
  AllTypesInProject;

Procedure ReadID_Artist(var ID: Integer; ArtistList: TAdrOfArtistList);

Procedure ReadID_Album(var ID: Integer; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);

implementation

{ \\\\\\\\\\ Work with ArtistList ////////// }

{ \\\\\\\\\\ Work with AlbumList ////////// }

// Прочитать код артиста, предусмотрев его отсутствие.
Procedure ReadID_Artist(var ID: Integer; ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  ArtL: TAdrOfArtistList;
  Menu: Integer;
begin
  repeat
    Write('Введите код исполнителя: ');
    ReadNum(ID);
    Flag := False;
    ArtL := ArtistList^.next;
    while (ArtL <> nil) and not(Flag) do
    begin
      if ArtL^.Artist.ID = ID then
        Flag := True;
      ArtL := ArtL^.next;
    end;

    if Flag = False then
    begin
      Writeln('Исполнителя с таким кодом не существует.');
      Writeln('Желаете создать нового исполнителя?');
      Writeln('1. Да. / 0. Нет (Ввести код заново).');
      ReadNum(Menu);
      if Menu = 1 then
      begin
        ID := ArtistList^.Max_Id + 1;
        InsertArtist(ArtistList);
      end;
    end;
  until Flag;
end;

{ \\\\\\\\\\ Work with SongList ////////// }

// Прочитать код альбома, предусмотрев его отсутствие.
Procedure ReadID_Album(var ID: Integer; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  AlbL: TAdrOfAlbumList;
  Menu: Integer;
begin
  repeat
    Write('Введите код альбома: ');
    ReadNum(ID);
    Flag := False;
    AlbL := AlbumList^.next;
    while (AlbL <> nil) and not(Flag) do
    begin
      if AlbL^.Album.ID = ID then
        Flag := True;
      AlbL := AlbL^.next;
    end;

    if Flag = False then
    begin
      Writeln('Альбома с таким кодом не существует.');
      Writeln('Желаете создать новый альбом?');
      Writeln('1. Да. / 0. Нет (Ввести код заново).');
      ReadNum(Menu);
      if Menu = 1 then
      begin
        ID := AlbumList^.Max_Id + 1;
        InsertAlbum(AlbumList, ArtistList);
      end;
    end;
  until Flag;
end;

end.
