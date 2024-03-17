program EducationalPractice;

uses
  WorkWithFiles in 'WorkWithFiles.pas',
  AllTypesInProject in 'AllTypesInProject.pas',
  MenuItems in 'MenuItems.pas';

var
  ArtistList, AlbumList, SongList: TAdrOfList;
  ArtistFile: TArtistFile;
  AlbumFile: TAlbumFile;
  SongFile: TSongFile;
  Menu: Integer;

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
  WriteLn('��������� ��� ������ �� ��������, ��������� � �������');
  Repeat
    WriteLn('���� ����������:');
    WriteLn('1. ��������� ������ �� �����.');
    WriteLn('2. ����������� ������.');
    WriteLn('3. ����������� ������.');
    WriteLn('4. ����� ������ �� ��������.');
    WriteLn('5. �������� ������ � ������.');
    WriteLn('6. ������� ������ �� �������.');
    WriteLn('7. ������������� ������.');
    WriteLn('8. ������� PlayList.');
    WriteLn('9. ����� �� ��������� � �����������.');
    WriteLn('0. ����� �� ��������� ��� ����������.');
    ReadLn(Menu);
    case Menu of
      1:
        begin
          ReadAllListsFromFiles(ArtistList, AlbumList, SongList, ArtistFile,
            AlbumFile, SongFile);
        end;

      2:
        begin
          MenuItem2_WatchLists(ArtistList, AlbumList, SongList);
        end;

      3:
        begin

        end;

      4:
        begin

        end;

      5:
        begin
          MenuItem5_Insert(ArtistList, AlbumList, SongList);
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

end.
