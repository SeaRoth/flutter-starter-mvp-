import 'package:flutterstarter/base/screen_presenter.dart';
import 'package:flutterstarter/base/screen_view.dart';
import 'package:flutterstarter/data/models/Statistic.dart';

abstract class DashboardScreenView extends ScreenView {}

class DashboardScreenPresenter extends ScreenPresenter<DashboardScreenView> {
  DashboardScreenPresenter(DashboardScreenView view) : super(view);

  @override
  void loadDbNetworkData() {
    // TODO: implement loadDbNetworkData
    super.loadDbNetworkData();
  }

  @override
  void getStats() {
    // TODO: implement getStats
    super.getStats();
  }

  @override
  bool isLoggedIn() {
    // TODO: implement isLoggedIn
    return super.isLoggedIn();
  }

  @override
  void setStats(List<Statistic> stats) {
    // TODO: implement setStats
    super.setStats(stats);
  }
}
