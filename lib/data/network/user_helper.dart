import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class UserHelper{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  GoogleSignInAccount _googleSignInAccount;
  FirebaseUser _user;
  bool _isLoggedIn = false;

  static final UserHelper loginHelper = new UserHelper._helper();

  factory UserHelper(){
    return loginHelper;
  }

  UserHelper._helper(){

  }

  GoogleSignIn retGoogleSignIn() {
    return _googleSignIn;
  }

  GoogleSignInAccount retSignInAccount(){
    return _googleSignInAccount;
  }

  bool isLoggedIn(){
    return _isLoggedIn;
  }

  Future logout() async{
    _googleSignIn.signOut();
    _auth.signOut();
    _isLoggedIn = false;
    _user = null;
    return;
  }

  FirebaseUser getUser() {
    return _user;
  }

  Future signInSilently() async=>
    await _googleSignIn.signInSilently().then((account){
      if(account != null) {
        _isLoggedIn = true;
        _googleSignInAccount = account;
        return account;
      }
      return false;
    });


  Future<FirebaseUser> setOnChangeListener() async{
    _auth.onAuthStateChanged.listen((user){
      if(user != null) {
        _isLoggedIn = true;
        print("AUTH STATE CHANGED");
        _user = user;
        return user;
      }else return null;
    });
    return null;
  }

  Future<FirebaseUser> loginGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    _googleSignInAccount = googleUser;
    return await finishSilentLogin(googleUser);
  }

  Future<FirebaseUser> finishSilentLogin(GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    _user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ).catchError((theError){
      throw new Exception(theError);
    });
    assert(_user.email != null);
    assert(_user.displayName != null);
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    _isLoggedIn = true;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(_user.uid == currentUser.uid);
    return _user;
  }

}