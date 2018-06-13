import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Cart.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:flutterstarter/tabs/cart/presenter.dart';

class CartScreen extends StatefulWidget{
  @override
  State createState() => new CartScreenState();
}

class CartScreenState extends State<CartScreen> implements CartScreenView {
  @override
  Widget build(BuildContext context) => new Container(
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Text("cart length: ${_cart.length}"),
        new Icon(
          Icons.settings,
          size: 150.0,
          color: Colors.black12
        ),
        new Text('Cart tab content')
      ],
    ),
  );

  CartScreenPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = new CartScreenPresenter(this);
    _presenter.loadDbNetworkData();
  }

  List<Cart> _cart = new List();
  DbHelper _dbHelper;
  NetworkData _networkData;


  void loadCart() {
    _dbHelper.loadCart().then((list){
      if(list != null)
        setState(() {
          _cart = list;
        });
    });
  }

  @override
  void onFirebaseDocumentLoaded(Map<String, dynamic> document) {
    // TODO: implement onDocumentLoaded
  }

  @override
  void onError(var msg) {
    // TODO: implement onError
  }

  @override
  void onLoggedOut() {
    // TODO: implement onLoggedOut
  }

  @override
  void onUserLoaded(FirebaseUser user) {
    // TODO: implement onUserLoaded
  }

  @override
  void onDbNetworkDataLoaded(DbHelper dbHelper, NetworkData networkData, UserHelper userHelper, FirestoreHelper firestoreHelper) {
    _dbHelper = dbHelper;
    _networkData = networkData;
    loadCart();
  }
}