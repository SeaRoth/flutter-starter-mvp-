import 'package:flutterstarter/Injector.dart';
import 'package:flutterstarter/base/screen_view.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/network/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ScreenPresenter<T extends ScreenView> {
  T _view;
  Injector _injector;
  DbHelper _dbHelper;
  NetworkData _networkData;
  UserHelper _userHelper;
  FirestoreHelper _firestoreHelper;

  ScreenPresenter(this._view) {
    _injector = new Injector();
    _dbHelper = _injector.dbHelper;
    _networkData = _injector.networkData;
    _userHelper = _injector.userHelper;
    _firestoreHelper = _injector.firestoreHelper;
  }

  NetworkData get networkData => _networkData;

  DbHelper get dbHelper => _dbHelper;

  T get view => _view;

  UserHelper get userHelper => _userHelper;

  FirestoreHelper get firestoreHelper => _firestoreHelper;

  void loadDbNetworkData(){
    view.onDbNetworkDataLoaded(_dbHelper, _networkData, _userHelper, _firestoreHelper);
  }

  bool isLoggedIn(){
    return _userHelper.isLoggedIn();
  }

  void loadUser(){
    var user = _userHelper.getUser();
    if(user != null) {
      _view.onUserLoaded(user);
    }
  }

  void logout(){
    _userHelper.logout().then((user){
      _view.onLoggedOut();
    });
  }

  void loginGoogle(){
    _userHelper.loginGoogle().then((user){
      _view.onUserLoaded(user);
    }).catchError((theError){
      _view.onError(theError);
    });
  }

  void signInSilently() {
    if(_userHelper.isLoggedIn())
      return _view.onUserLoaded(_userHelper.getUser());
    GoogleSignIn googleSignIn = _userHelper.retGoogleSignIn();
    googleSignIn.onCurrentUserChanged.listen((user){
      _userHelper.finishSilentLogin(user).then((firebaseUser){
        _view.onUserLoaded(firebaseUser);
      });
    });
    _userHelper.signInSilently();
  }

}