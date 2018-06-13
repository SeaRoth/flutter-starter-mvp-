import 'dart:async';

import 'package:flutterstarter/base/screen_presenter.dart';
import 'package:flutterstarter/base/screen_view.dart';

abstract class MainView extends ScreenView{
}

class MainScreenPresenter extends ScreenPresenter<MainView> {
  MainScreenPresenter(ScreenView view) : super(view);

  @override
  void loadUser() {
    super.loadUser();
  }

  @override
  bool isLoggedIn() {
    return super.isLoggedIn();
  }

  @override
  void signInSilently() {
    super.signInSilently();
  }

  @override
  void logout() {
    super.logout();
  }

}