import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class RecentSearchStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/recent_search.txt');
  }

  Future<String> readRecentSearchData() async {
    try {
      final file = await _localFile;
      // file.delete();

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<void> deleteRecentSearchData() async {
    final file = await _localFile;
    file.delete();
  }

  Future<File> writeRecentSearchData(String value) async {
    final file = await _localFile;

    return file.writeAsString(value);
  }
}
