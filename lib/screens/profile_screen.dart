import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/models/User.dart';
import 'package:flutterstarter/data/network/firestore/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:flutterstarter/screens/profile_presenter.dart';
import 'package:flutterstarter/widgets/page_user.dart';

final ThemeData _kTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  accentColor: Colors.redAccent,
);

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key key, this.userId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new ProfileScreenState();
}

class SeaRothStyle extends TextStyle {
  const SeaRothStyle({
    double fontSize: 12.0,
    FontWeight fontWeight,
    Color color: Colors.black87,
    double letterSpacing,
    double height,
  }) : super(
          inherit: false,
          color: color,
          fontFamily: 'Raleway',
          fontSize: fontSize,
          fontWeight: fontWeight,
          textBaseline: TextBaseline.alphabetic,
          letterSpacing: letterSpacing,
          height: height,
        );
}

class ProfileScreenState extends State<ProfileScreen> implements ProfileScreenView {

  DbHelper _dbHelper;
  NetworkData _networkData;
  FirestoreHelper _firestoreHelper;
  UserHelper _userHelper;
  DocumentReference userDocRef;

  @override
  void onDbNetworkDataLoaded(DbHelper dbHelper, NetworkData networkData,
      UserHelper userHelper, FirestoreHelper firestoreHelper) {
    _userHelper = userHelper;
    _dbHelper = dbHelper;
    _networkData = networkData;
    _firestoreHelper = firestoreHelper;
    setDocumentSnapshot(widget.userId);
  }

  DocumentSnapshot _profileUserDocument;
  DocumentSnapshot _profileMeDocument;
  void setDocumentSnapshot(String uid) async{
    await _firestoreHelper.firestore.collection('users').document(uid).get().then((d){
      _profileUserDocument = d;
      print("We are viewing: ${_profileUserDocument.data['firebaseId']}");
      setState(() {
      });
    });

    await _firestoreHelper.firestore.collection('users').document(_userHelper.getUser().uid).get().then((d){
      _profileMeDocument = d;
      print("viewing as:  ${_profileUserDocument.data['firebaseId']}");
      setState(() {
      });
    });
  }

  ProfileScreenPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = new ProfileScreenPresenter(this);
    _presenter.loadDbNetworkData();
  }

  final TextStyle titleStyle = const SeaRothStyle(fontSize: 34.0);
  final TextStyle descriptionStyle = const SeaRothStyle(fontSize: 15.0, color: Colors.black54, height: 24.0 / 15.0);
  final TextStyle itemStyle = const SeaRothStyle(fontSize: 15.0, height: 24.0 / 15.0);
  final TextStyle itemAmountStyle = new SeaRothStyle(fontSize: 15.0, color: _kTheme.primaryColor, height: 24.0 / 15.0);
  final TextStyle headingStyle = const SeaRothStyle(fontSize: 16.0, fontWeight: FontWeight.bold, height: 24.0 / 15.0);
  final TextStyle rowActionsStyle = const SeaRothStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    print("we should look up ${widget.userId}");

    if(_profileUserDocument == null || _profileUserDocument.data == null || _profileUserDocument.data['name'] == null
    ||
        _profileMeDocument == null || _profileMeDocument.data == null || _profileMeDocument.data['name'] == null
    )
      return new Scaffold(
        body: new Center(child: new Text("loading..."),),
      );

    final double appBarHeight = _getAppBarHeight(context);
    final Size screenSize = MediaQuery.of(context).size;
    const double _kRecipePageMaxWidth = 500.0;
    final bool fullWidth = screenSize.width < _kRecipePageMaxWidth;
    const double _kFabHalfSize = 50.0;
    Map<String, dynamic> mUser =  _profileUserDocument.data;



    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: appBarHeight + _kFabHalfSize,
              child: new Hero(
                tag: 'cover photo/',
                child: new Image(
                  fit: BoxFit.fill,
                  image: new NetworkImageWithRetry(mUser['coverPhoto']),
                ),
              ),
            ),
            new CustomScrollView(
              slivers: <Widget>[
                new SliverAppBar(
                  expandedHeight: appBarHeight - _kFabHalfSize,
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    new PopupMenuButton<String>(
                      onSelected: (String item) {},
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<String>>[
                            _buildMenuItem(Icons.share, 'Tweet recipe'),
                            _buildMenuItem(Icons.email, 'Email recipe'),
                            _buildMenuItem(Icons.message, 'Message recipe'),
                            _buildMenuItem(Icons.people, 'Share on Facebook'),
                          ],
                    ),
                  ],
                  flexibleSpace: const FlexibleSpaceBar(
                    background: const DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: const LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(0.0, -0.2),
                          colors: const <Color>[
                            const Color(0x60000000),
                            const Color(0x00000000)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                new SliverToBoxAdapter(
                    child: new Stack(
                  children: <Widget>[
                    new Positioned(
                      right: (screenSize.width / 2 - 50.0),
                      child: new Container(
                        decoration: new BoxDecoration(
                          border:
                              new Border.all(color: Colors.white, width: 2.0),
                        ),
                        child: new SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: new Image(
                            fit: BoxFit.fill,

                            image: new NetworkImageWithRetry(mUser['imageUrl']),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: _kFabHalfSize+54.0),
                      width: _kRecipePageMaxWidth,
                      child: new Material(
                        child: new SafeArea(
                          top: false,
                          bottom: false,
                          child: new Column(
                            children: <Widget>[
                              new Text(mUser['name'],
                              overflow: TextOverflow.ellipsis,
                              style: titleStyle,
                              ),


                              new Padding(
                                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    _buildRowActionItem(Icons.person_add, "Friends", Colors.blue),
                                    _buildRowActionItem(Icons.check, "Following", Colors.blue),
                                    _buildRowActionItem(Icons.highlight, "Message", Colors.grey),
                                    _buildRowActionItem(Icons.more, "More", Colors.grey),
                                  ],

                                ),
                              ),

                              _buildPersonalItem(Icons.school, "Went to Lake Washington High"),
                              _buildPersonalItem(Icons.home, "Lives near Kirkland, WA"),
                              _buildPersonalItem(Icons.school, "In a relationship with some hot chick"),
                              _buildPersonalItem(Icons.school, "From Narnia, World"),
                              _buildPersonalItem(Icons.access_time, "Joined March 2018"),

                              new Container(
                                height: 40.0,
                                color: Colors.grey,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Text("ABOUT",
                                      style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    new Text("PHOTOS",
                                      style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                    new Text("FRIENDS",
                                      style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),


                              new Container(
                                child: new Column(
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[

                                        new CircleAvatar(
                                          radius: 22.0,
                                          backgroundImage: new Image(
                                              image: new NetworkImageWithRetry(_profileMeDocument['imageUrl']),
                                          ).image,
                                        ),
                                        new Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: new TextFormField(
                                              decoration: new InputDecoration(
                                                hintText: "Write something to ${mUser['name']}...",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),



                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              new Icon(Icons.home,
                                                size: 22.0,
                                                color: Colors.grey[12],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4.0),
                                                child: new Text("Write Post", style: descriptionStyle,),
                                              ),
                                            ],
                                          ),
                                          new Row(
                                            children: <Widget>[
                                              new Icon(Icons.person_add,
                                                size: 22.0,
                                                color: Colors.green,),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4.0),
                                                child: new Text("Share Photo",
                                                  style: descriptionStyle,),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),




                                  ],
                                ),

                              ),







                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                              new Text("sdfsdfsdfds"),
                            ],
                          ),
                        ),
                      ), //child: new RecipeSheet(recipe: widget.recipe),
                    ),
                  ],
                )),
              ],
            ),
          ],
        ));
  }

  @override
  void onError(msg) {
    // TODO: implement onError
  }

  @override
  void onFirebaseDocumentLoaded(Map<String, dynamic> document) {
    // TODO: implement onFirebaseDocumentLoaded
  }

  @override
  void onLoggedOut() {
    // TODO: implement onLoggedOut
  }

  @override
  void onStatsLoaded(List<Statistic> stats) {
    // TODO: implement onStatsLoaded
  }

  @override
  void onUserLoaded(FirebaseUser user) {
    // TODO: implement onUserLoaded
  }

  double _getAppBarHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.3;
  double _kFabHalfSize =
  28.0; // TODO(mpcomplete): needs to adapt to screen size

  final TextStyle menuItemStyle = const SeaRothStyle(
      fontSize: 15.0, color: Colors.black54, height: 24.0 / 15.0);

  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return new PopupMenuItem<String>(
      child: new Row(
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: new Icon(icon, color: Colors.black54)),
          new Text(label, style: menuItemStyle),
        ],
      ),
    );
  }

  Column _buildRowActionItem(IconData icon, String s, Color color){
    return new Column(
      children: <Widget>[
        new Icon(icon,
          color: color,
          semanticLabel: s,
          size: 30.0,
        ),
        new Text(s,
          style: new TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }

  Padding _buildPersonalItem(IconData icon, String s){
    return new Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: new Row(
        children: <Widget>[
          new Icon(icon,
            color: Colors.grey,
            semanticLabel: s,
            size: 15.0,
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: new Text(s,
              style: rowActionsStyle,
            ),
          ),
        ],
      ),
    );
  }
}
