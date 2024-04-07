program EducationalPractice;

uses
  WorkWithFiles in 'WorkWithFiles.pas',
  WorkWithLists in 'WorkWithLists.pas',
  AllTypesInProject in 'AllTypesInProject.pas',
  MenuItems in 'MenuItems.pas';

var
  ArtistList: TAdrOfArtistList;
  AlbumList: TAdrOfAlbumList;
  SongList: TAdrOfSongList;
  ArtistFile: TArtistFile;
  AlbumFile: TAlbumFile;
  SongFile: TSongFile;
  Menu: Integer;
  Flag_IsFileAlreadyOpen: Integer;

begin
  Flag_IsFileAlreadyOpen := 0;

  New(ArtistList);
  ArtistList^.Max_Id := 0;

  New(AlbumList);
  AlbumList^.Max_Id := 0;

  New(SongList);
  SongList^.Max_Id := 0;

  WriteLn('Программа для работы со списками, связанными с музыкой');
  Repeat
    WriteLn('Меню приложения:');
    WriteLn('1. Прочитать данные из файла.');
    WriteLn('2. Просмотреть списки.');
    WriteLn('3. Сортировать данные.');
    WriteLn('4. Найти данные в списках.');
    WriteLn('5. Добавить данные в списки.');
    WriteLn('6. Удалить данные из списков.');
    WriteLn('7. Редактировать списки.');
    WriteLn('8. Создать PlayList.');
    WriteLn('9. Выйти из программы без сохранения.');
    WriteLn('10. Выйти из программы с сохранением.');
    ReadNum(Menu);
    case Menu of
      1:
        begin
          MenuItem1_ReadLists(ArtistList, AlbumList, SongList, ArtistFile,
            AlbumFile, SongFile, Flag_IsFileAlreadyOpen);
        end;

      2:
        begin
          MenuItem2_WatchLists(ArtistList, AlbumList, SongList);
        end;

      3:
        begin
          MenuItem3_Sort(ArtistList, AlbumList, SongList);
        end;

      4:
        begin
          MenuItem4_Search(ArtistList, AlbumList, SongList);
        end;

      5:
        begin
          Flag_IsFileAlreadyOpen := 2;
          MenuItem5_Insert(ArtistList, AlbumList, SongList);
        end;

      6:
        begin
          MenuItem6_Delete(ArtistList, AlbumList, SongList);
        end;

      7:
        begin
          MenuItem7_Edit(ArtistList, AlbumList, SongList);
        end;

      8:
        begin

        end;

      10:
        begin
          ReWriteAllListsInFiles(ArtistList, AlbumList, SongList, ArtistFile,
            AlbumFile, SongFile);
        end;
    end;
  Until (Menu = 10) or (Menu = 9);

  DeleteAllLists(ArtistList, AlbumList, SongList);

end.
