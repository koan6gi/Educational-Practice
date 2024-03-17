unit WorkWithLists;

interface

uses
  AllTypesInProject;
Procedure WatchArtistList(ArtistList: TAdrOfList);
Procedure WatchALbumList(AlbumList: TAdrOfList);
Procedure WatchSongList(SongList: TAdrOfList);

Procedure InsertArtist(ArtistList: TAdrOfList);
Procedure InsertAlbum(AlbumList: TAdrOfList);
Procedure InsertSong(SongList: TAdrOfList);

implementation

{ Work with ArtistList }
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

{ Work with AlbumList }
Procedure WatchALbumList(AlbumList: TAdrOfList);
begin
  Writeln('|-------------|-----------------|--------------------|------------|');
  Writeln('| ��� ������� | ��� ����������� |  �������� �������  | ��� ������ |');
  Writeln('|-------------|-----------------|--------------------|------------|');
  while AlbumList^.next <> nil do
  begin
    AlbumList := AlbumList^.next;
    Writeln('|', AlbumList^.Album.ID:13, ' |', AlbumList^.Album.ID_Artist:16,
      ' |', AlbumList^.Album.Name:19, ' |', AlbumList^.Album.Year:11, ' |');
  end;
  Writeln('|-------------|-----------------|--------------------|------------|');
end;

Procedure InsertAlbum(AlbumList: TAdrOfList);
begin

end;

{ Work with SongList }
Procedure WatchSongList(SongList: TAdrOfList);
begin
  Writeln('|----------------|-------------|--------------------|');
  Writeln('| �������� ����� | ��� ������� | ������������ ����� |');
  Writeln('|----------------|-------------|--------------------|');
  while SongList^.next <> nil do
  begin
    SongList := SongList^.next;
    Writeln('|', SongList^.Song.Name:15, ' |', SongList^.Song.ID_Album:12, ' |',
      SongList^.Song.Length:19, ' |');
  end;
  Writeln('|----------------|-------------|--------------------|');
end;

Procedure InsertSong(SongList: TAdrOfList);
begin

end;

end.
