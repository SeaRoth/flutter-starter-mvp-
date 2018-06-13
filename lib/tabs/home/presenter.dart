


import 'package:flutterstarter/base/screen_presenter.dart';
import 'package:flutterstarter/base/screen_view.dart';

abstract class HomeScreenView extends ScreenView{
}

class HomeScreenPresenter extends ScreenPresenter<HomeScreenView>{
  HomeScreenPresenter(ScreenView view) : super(view);

  @override
  void loadDbNetworkData() {
    // TODO: implement loadDbNetworkData
    super.loadDbNetworkData();
  }

  @override
  void signInSilently() {
    // TODO: implement signInSilently
    super.signInSilently();
  }
}