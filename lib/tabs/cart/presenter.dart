import 'package:flutterstarter/base/screen_presenter.dart';
import 'package:flutterstarter/base/screen_view.dart';

abstract class CartScreenView extends ScreenView{
}

class CartScreenPresenter extends ScreenPresenter<CartScreenView>{
  CartScreenPresenter(ScreenView view) : super(view);

  @override
  void loadDbNetworkData() {
    // TODO: implement loadDbNetworkData
    super.loadDbNetworkData();
  }
}