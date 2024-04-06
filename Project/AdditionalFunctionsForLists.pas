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

// ��������� ��� �������, ������������ ��� ����������.
Procedure ReadID_Artist(var ID: Integer; ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  ArtL: TAdrOfArtistList;
  Menu: Integer;
begin
  repeat
    Write('������� ��� �����������: ');
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
      Writeln('����������� � ����� ����� �� ����������.');
      Writeln('������� ������� ������ �����������?');
      Writeln('1. ��. / 0. ��� (������ ��� ������).');
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

// ��������� ��� �������, ������������ ��� ����������.
Procedure ReadID_Album(var ID: Integer; AlbumList: TAdrOfAlbumList;
  ArtistList: TAdrOfArtistList);
var
  Flag: Boolean;
  AlbL: TAdrOfAlbumList;
  Menu: Integer;
begin
  repeat
    Write('������� ��� �������: ');
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
      Writeln('������� � ����� ����� �� ����������.');
      Writeln('������� ������� ����� ������?');
      Writeln('1. ��. / 0. ��� (������ ��� ������).');
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
