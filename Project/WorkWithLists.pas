unit WorkWithLists;

interface

uses
  AllTypesInProject;
Procedure WatchArtistList(ArtistList: TAdrOfList);
Procedure WatchALbumList(AlbumList: TAdrOfList);
Procedure WatchSongList(SongList: TAdrOfList);

Procedure InsertArtist(ArtistList: TAdrOfList);
Procedure InsertAlbum(AlbumList, ArtistList: TAdrOfList);
Procedure InsertSong(SongList, AlbumList, ArtistList: TAdrOfList);

Procedure DeleteArtist(ArtistList, AlbumList, SongList: TAdrOfList);
Procedure DeleteAlbum(AlbumList, SongList: TAdrOfList; CheckID: Integer);
Procedure DeleteSong(SongList: TAdrOfList; CheckID: Integer);

implementation

{ \\\\\\\\\\ Work with ArtistList ////////// }
Procedure WatchArtistList(ArtistList: TAdrOfList);
begin
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  Writeln('| ��� ����������� |  ��� �����������  | ������ ����������� | ����������� ����������� |');
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
  while ArtistList^.next <> nil do
  begin
    ArtistList := ArtistList^.next;
    Writeln('|', ArtistList^.Artist.ID:16, ' |', ArtistList^.Artist.Name:18,
      ' |', ArtistList^.Artist.Country:19, ' |', ArtistList^.Artist.Direction
      :24, ' |');
  end;
  Writeln('|-----------------|-------------------|--------------------|-------------------------|');
end;

Procedure InsertArtist(ArtistList: TAdrOfList);
var
  MaxId: Integer;
  Tmp: TAdrOfList;
begin
  Inc(ArtistList^.Max_Id);
  MaxId := ArtistList^.Max_Id;
  Tmp := ArtistList^.next;
  New(ArtistList^.next);
  ArtistList := ArtistList^.next;
  ArtistList^.Artist.ID := MaxId;
  ArtistList^.next := Tmp;

  Write('������� ��� �����������: ');
  ReadLn(ArtistList^.Artist.Name);
  Write('������� ������ �����������: ');
  ReadLn(ArtistList^.Artist.Country);
  Write('������� ����������� ����� �����������: ');
  ReadLn(ArtistList^.Artist.Direction);
end;

Procedure DeleteArtist(ArtistList, AlbumList, SongList: TAdrOfList);
var
  IDForDelete: Integer;
  Tmp, TmpAlbumList: TAdrOfList;
  Flag: Boolean;
begin
  Write('������� ��� ����������� ��� ��������: ');
  ReadLn(IDForDelete);
  Flag := false;

  While Not(Flag) and (ArtistList^.next <> nil) do
  begin
    if ArtistList^.next^.Artist.ID = IDForDelete then
    begin
      Flag := True;

      Tmp := ArtistList^.next;
      ArtistList^.next := ArtistList^.next^.next;
      Dispose(Tmp);
    end;
    ArtistList := ArtistList^.next;
  end;

  if Not(Flag) then
    Writeln('����������� � ����� ����� �� ����������.')
  else
  begin
    New(TmpAlbumList);
    TmpAlbumList^.next := AlbumList;
    while AlbumList <> nil do
    begin
      if (AlbumList^.next <> nil) and
        (AlbumList^.next^.Album.ID_Artist = IDForDelete) then
      begin
        DeleteAlbum(TmpAlbumList^.next, SongList, AlbumList^.next^.Album.ID);
        AlbumList := TmpAlbumList;
      end;
      AlbumList := AlbumList^.next;
    end;
  end;
end;

{ \\\\\\\\\\ Work with AlbumList ////////// }
Procedure WatchALbumList(AlbumList: TAdrOfList);
begin
  Writeln('|-------------|-----------------|--------------------|------------|');
  Writeln('| ��� ������� | ��� ����������� |  �������� �������  | ��� ������ |');
  Writeln('|-------------|-----------------|--------------------|------------|');
  while AlbumList^.next <> nil do
  begin
    AlbumList := AlbumList^.next;
    Writeln('|', AlbumList^.Album.ID:12, ' |', AlbumList^.Album.ID_Artist:16,
      ' |', AlbumList^.Album.Name:19, ' |', AlbumList^.Album.Year:11, ' |');
  end;
  Writeln('|-------------|-----------------|--------------------|------------|');
end;

Procedure ReadID_Artist(var ID: Integer; ArtistList: TAdrOfList);
var
  Flag: Boolean;
  ArtL: TAdrOfList;
  Menu: Integer;
begin
  repeat
    Write('������� ��� �����������: ');
    ReadLn(ID);
    Flag := false;
    ArtL := ArtistList^.next;
    while (ArtL <> nil) and not(Flag) do
    begin
      if ArtL^.Artist.ID = ID then
        Flag := True;
      ArtL := ArtL^.next;
    end;

    if Flag = false then
    begin
      Writeln('����������� � ����� ����� �� ����������.');
      Writeln('������� ������� ������ �����������?');
      Writeln('1. ��. / 0. ��� (������ ��� ������).');
      ReadLn(Menu);
      if Menu = 1 then
      begin
        ID := ArtistList^.Max_Id + 1;
        InsertArtist(ArtistList);
      end;
    end;
  until Flag;
end;

Procedure InsertAlbum(AlbumList, ArtistList: TAdrOfList);
var
  MaxId: Integer;
begin
  Inc(AlbumList^.Max_Id);
  MaxId := AlbumList^.Max_Id;
  while AlbumList^.next <> nil do
    AlbumList := AlbumList^.next;
  New(AlbumList^.next);
  AlbumList := AlbumList^.next;
  AlbumList^.Album.ID := MaxId;

  ReadID_Artist(AlbumList^.Album.ID_Artist, ArtistList);
  Write('������� �������� �������: ');
  ReadLn(AlbumList^.Album.Name);
  Write('������� ��� ������� �������: ');
  ReadLn(AlbumList^.Album.Year);
end;

Procedure DeleteAlbum(AlbumList, SongList: TAdrOfList; CheckID: Integer);
var
  IDForDelete: Integer;
  Tmp, TmpSongList: TAdrOfList;
  Flag: Boolean;
begin
  IDForDelete := CheckID;
  if CheckID = 0 then
  begin
    Write('������� ��� ������� ��� ��������: ');
    ReadLn(IDForDelete);
  end;
  Flag := false;

  While Not(Flag) and (AlbumList^.next <> nil) do
  begin
    if AlbumList^.next^.Album.ID = IDForDelete then
    begin
      Flag := True;

      Tmp := AlbumList^.next;
      AlbumList^.next := AlbumList^.next^.next;
      Dispose(Tmp);
    end;
    AlbumList := AlbumList^.next;
  end;

  if Not(Flag) then
    Writeln('������� � ����� ����� �� ����������.')
  else
  begin
    New(TmpSongList);
    TmpSongList^.next := SongList;
    while SongList <> nil do
    begin
      if (SongList^.next <> nil) and
        (SongList^.next^.Song.ID_Album = IDForDelete) then
      begin
        DeleteSong(TmpSongList^.next, SongList^.next^.Song.ID);
        SongList := TmpSongList;
      end;
      SongList := SongList^.next;
    end;
  end;
end;

{ \\\\\\\\\\ Work with SongList ////////// }
Procedure WatchSongList(SongList: TAdrOfList);
begin
  Writeln('|-----------|----------------|-------------|--------------------|');
  Writeln('| ��� ����� | �������� ����� | ��� ������� | ������������ ����� |');
  Writeln('|-----------|----------------|-------------|--------------------|');
  while SongList^.next <> nil do
  begin
    SongList := SongList^.next;
    Writeln('|', SongList^.Song.ID:10, ' |', SongList^.Song.Name:15, ' |',
      SongList^.Song.ID_Album:12, ' |', SongList^.Song.Length:19, ' |');
  end;
  Writeln('|-----------|----------------|-------------|--------------------|');
end;

Procedure ReadID_Album(var ID: Integer; AlbumList, ArtistList: TAdrOfList);
var
  Flag: Boolean;
  AlbL: TAdrOfList;
  Menu: Integer;
begin
  repeat
    Write('������� ��� �������: ');
    ReadLn(ID);
    Flag := false;
    AlbL := AlbumList^.next;
    while (AlbL <> nil) and not(Flag) do
    begin
      if AlbL^.Artist.ID = ID then
        Flag := True;
      AlbL := AlbL^.next;
    end;

    if Flag = false then
    begin
      Writeln('������� � ����� ����� �� ����������.');
      Writeln('������� ������� ����� ������?');
      Writeln('1. ��. / 0. ��� (������ ��� ������).');
      ReadLn(Menu);
      if Menu = 1 then
      begin
        ID := AlbumList^.Max_Id + 1;
        InsertAlbum(AlbumList, ArtistList);
      end;
    end;
  until Flag;
end;

Procedure InsertSong(SongList, AlbumList, ArtistList: TAdrOfList);
var
  MaxId: Integer;
  Tmp: TAdrOfList;
begin
  Inc(SongList^.Max_Id);
  MaxId := SongList^.Max_Id;
  Tmp := SongList^.next;
  New(SongList^.next);
  SongList := SongList^.next;
  SongList^.Song.ID := MaxId;
  SongList^.next := Tmp;

  ReadID_Album(SongList^.Song.ID_Album, AlbumList, ArtistList);
  Write('������� �������� �����: ');
  ReadLn(SongList^.Song.Name);
  Write('������� ����� ����� � ��������: ');
  ReadLn(SongList^.Song.Length);
end;

Procedure DeleteSong(SongList: TAdrOfList; CheckID: Integer);
var
  IDForDelete: Integer;
  Tmp: TAdrOfList;
  Flag: Boolean;
begin
  IDForDelete := CheckID;
  if CheckID = 0 then
  begin
    Write('������� ��� ����� ��� ��������: ');
    ReadLn(IDForDelete);
  end;
  Flag := false;

  While Not(Flag) and (SongList^.next <> nil) do
  begin
    if SongList^.next^.Song.ID = IDForDelete then
    begin
      Flag := True;

      Tmp := SongList^.next;
      SongList^.next := SongList^.next^.next;
      Dispose(Tmp);
    end;
    SongList := SongList^.next;
  end;

  if Not(Flag) then
    Writeln('����� � ����� ����� �� ����������.');
end;

end.
