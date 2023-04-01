import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FavouritesStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/favourites.txt');
  }

  Future<String> readFavouritesData() async {
    try {
      final file = await _localFile;
      // file.delete();

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<void> deleteFavouritesData() async {
    final file = await _localFile;
    file.delete();
  }

  Future<File> writeFavouritesData(String value) async {
    final file = await _localFile;

    return file.writeAsString(value);
  }
}
