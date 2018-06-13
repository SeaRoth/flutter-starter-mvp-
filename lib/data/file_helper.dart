import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class FileHelper{
  Future<String> readJsonFile(String loc) =>
      rootBundle.loadString(loc).then((jsonString){
        return jsonString;
      }).catchError((e){
        return null;
      });

  static Future<File> getLocalFile(Directory directory, String path) async {
    final dir = directory;
    try {
      var theFile = new File('${dir.path}/$path');
      return theFile;
    }catch(e){
      return null;
    }
  }
}