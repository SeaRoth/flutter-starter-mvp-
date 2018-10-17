import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:flutterstarter/data/models/Cart.dart';
import 'package:flutterstarter/data/models/Statistic.dart';

class DbHelper {

  final String statsString = "stats";
  final String cartString = "cart";

  final Future<Directory> Function() getDirectory;
  const DbHelper(this.getDirectory);

  Future<File> _getLocalFile(String tag) async {
    final dir = await getDirectory();
    try {
      var theFile = new File('${dir.path}/$tag.json');
      return theFile;
    }catch(e){
      return null;
    }
  }

  Future<FileSystemEntity> clean(String fileName) async {
    final file = await _getLocalFile(fileName);
    return file.delete();
  }

  //CART
  Future<File> saveCart(List<Cart> list) async {
    if(list == null)
      return null;
    final file = await _getLocalFile(cartString);

    return file.writeAsString(new JsonEncoder().convert({
      'cart': list.map((item) => item).toList(),
    }));
  }

  Future<List<Cart>> loadCart() async {
    final file = await _getLocalFile(cartString);
    if(file == null)
      return null;
    try{
      final string = await file.readAsString();
      final json = new JsonDecoder().convert(string);
      final cart = (json['cart'] as List<dynamic>)
          .map((stat) => new Cart.fromJson(stat))
          .toList();
      return cart;
    }catch(e){
      return null;
    }
  }

  //STATS
  Future saveStats(List<Statistic> list) async {
    if(list == null)
      return null;
    final file = await _getLocalFile(statsString);
    return file.writeAsString(new JsonEncoder().convert({
      'stats': list.map((stat) => stat).toList(),
    }));
  }

  Future<List<Statistic>> loadStats() async {
    final file = await _getLocalFile(statsString);
    if(file == null)
      return null;
    try{
      final string = await file.readAsString();
      final json = new JsonDecoder().convert(string);
      final stats = (json['stats'] as List<dynamic>)
          .map((stat) => new Statistic.fromJson(stat))
          .toList();
      return stats;
    }catch(e){
      return null;
    }
  }


}