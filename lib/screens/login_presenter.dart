import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterstarter/base/screen_presenter.dart';
import 'package:flutterstarter/base/screen_view.dart';

abstract class LoginScreenView extends ScreenView{

}

class LoginScreenPresenter extends ScreenPresenter<LoginScreenView> {

  LoginScreenPresenter(ScreenView view) : super(view);

  @override
  void loadDbNetworkData() {
    // TODO: implement loadDbNetworkData
    super.loadDbNetworkData();
  }

  @override
  void loginGoogle() {
    super.loginGoogle();
  }

  @override
  void logout() {
    super.logout();
  }

  @override
  void loadUser() {
    super.loadUser();
  }
}