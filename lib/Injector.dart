import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:path_provider/path_provider.dart';

class Injector{
  static final Injector injector = new Injector._injector();
  NetworkData _networkData;
  DbHelper _dbHelper;
  UserHelper _userHelper;
  FirestoreHelper _firestoreHelper;

  Injector._injector(){
    _networkData = new NetworkData();
    _dbHelper = new DbHelper(getApplicationDocumentsDirectory);
    _userHelper = new UserHelper();
    _firestoreHelper = new FirestoreHelper();
  }

  factory Injector(){
    return injector;
  }

  NetworkData get networkData => _networkData;

  DbHelper get dbHelper => _dbHelper;

  UserHelper get userHelper => _userHelper;

  FirestoreHelper get firestoreHelper => _firestoreHelper;
}