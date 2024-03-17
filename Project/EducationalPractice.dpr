program EducationalPractice;

uses
  WorkWithFiles in 'WorkWithFiles.pas',
  AllTypesInProject in 'AllTypesInProject.pas';

var
  ArtistList, AlbumList, SongList: TAdrOfList;
  ArtistFile: TArtistFile;
  AlbumFile: TAlbumFile;
  SongFile: TSongFile;
  Menu: Integer = 0;

begin
  New(ArtistList);
  ArtistList^.ListType := Artist;
  ArtistList^.Max_Id := 0;

  New(AlbumList);
  AlbumList^.ListType := Album;
  AlbumList^.Max_Id := 0;

  New(SongList);
  SongList^.ListType := Song;
  SongList^.Max_Id := 0;
  Repeat
    case Menu of
      1:
        begin
          ReadAllListsFromFiles(ArtistList, AlbumList, SongList, ArtistFile,
            AlbumFile, SongFile);
        end;

      2:
        begin

        end;

      3:
        begin

        end;

      4:
        begin

        end;

      5:
        begin

        end;

      6:
        begin

        end;

      7:
        begin

        end;

      8:
        begin

        end;

      9:
        begin
          ReWriteAllListsInFiles(ArtistList, AlbumList, SongList, ArtistFile,
            AlbumFile, SongFile);
        end;
    end;
  Until (Menu = 0) or (Menu = 9);;

  readln;

end.
