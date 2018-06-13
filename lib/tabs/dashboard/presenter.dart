import 'package:flutterstarter/base/screen_presenter.dart';
import 'package:flutterstarter/base/screen_view.dart';

abstract class DashboardScreenView extends ScreenView {}

class DashboardScreenPresenter extends ScreenPresenter<DashboardScreenView> {
  DashboardScreenPresenter(DashboardScreenView view) : super(view);

  @override
  void loadDbNetworkData() {
    // TODO: implement loadDbNetworkData
    super.loadDbNetworkData();
  }
}
