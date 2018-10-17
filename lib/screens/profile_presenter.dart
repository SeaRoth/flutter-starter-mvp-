
import 'package:flutterstarter/base/screen_presenter.dart';
import 'package:flutterstarter/base/screen_view.dart';

abstract class ProfileScreenView extends ScreenView {

}



class ProfileScreenPresenter extends ScreenPresenter<ProfileScreenView>{
  ProfileScreenPresenter(ProfileScreenView view) : super(view);

  @override
  void loadDbNetworkData() {
    // TODO: implement loadDbNetworkData
    super.loadDbNetworkData();
  }





}




