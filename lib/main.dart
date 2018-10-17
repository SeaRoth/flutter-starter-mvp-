import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image/network.dart';
import 'package:flutterstarter/data/db/db_helper.dart';
import 'package:flutterstarter/data/models/Statistic.dart';
import 'package:flutterstarter/data/network/firestore/firestore_helper.dart';
import 'package:flutterstarter/data/network/network_data.dart';
import 'package:flutterstarter/data/network/user_helper.dart';
import 'package:flutterstarter/localizations/themes.dart';
import 'package:flutterstarter/main_presenter.dart';
import 'package:flutterstarter/tabs/home/home_screen.dart' as _firstTab;
import 'package:flutterstarter/tabs/dashboard/dashboard_screen.dart' as _secondTab;
import 'package:flutterstarter/tabs/cart/cart_screen.dart' as _thirdTab;
import './screens/about.dart' as _aboutPage;
import './screens/support.dart' as _supportPage;
import './screens/settings.dart' as _settingsPage;
import './screens/login_screen.dart' as _loginPage;
import './screens/profile_screen.dart' as _profilePage;

void main() => runApp(new MaterialApp(
  title: 'Flutter MVP Starter',
  theme: StarterTheme.theme,
  debugShowCheckedModeBanner: false,
  color: Colors.grey,
  home: new Tabs(),
  onGenerateRoute: (RouteSettings settings) {
    switch (settings.name) {
      case '/about': return new FromRightToLeft(
        builder: (_) => new _aboutPage.About(),
        settings: settings,
      );

      case '/login': return new FromRightToLeft(
        builder: (_) => new _loginPage.LoginScreen(),
        settings: settings,
      );

      case '/profile': return new FromRightToLeft (
        builder: (_) => new _profilePage.ProfileScreen(),
        settings: settings,
      );

      case '/support': return new FromRightToLeft(
        builder: (_) => new _supportPage.Support(),
        settings: settings,
      );
      case '/settings': return new FromRightToLeft(
        builder: (_) => new _settingsPage.Settings(),
        settings: settings,
      );
    }
  },
  // routes: <String, WidgetBuilder> {
  //   '/about': (BuildContext context) => new _aboutPage.About(),
  // }
));

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {

    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0,
            )
          ]
        ),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      )
      .animate(
        new CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )
      ),
    );
  }
  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> implements MainView{
  
  PageController _tabController;
  MainScreenPresenter _presenter;
  var _title_app = null;
  int _tab = 0;
  dynamic _selection;

  @override
  void initState() {
    super.initState();
    _presenter = new MainScreenPresenter(this);
    _presenter.loadDbNetworkData();
    _presenter.signInSilently();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  void setMenuButtonItem(){
    switch(_selection){
      case MenuOptionsEnum.populate_users_posts:
        _firestoreHelper.populateUsers();
        _firestoreHelper.populatePosts();
        break;
      case MenuOptionsEnum.remove_users_posts:
        break;
      default:
        break;

    }
  }

  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    appBar: new AppBar(
        actions: <Widget>[
          new PopupMenuButton<MenuOptionsEnum>(
            onSelected: (MenuOptionsEnum result) {
              _selection = result;
              setMenuButtonItem();
              },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptionsEnum>>[
              const PopupMenuItem<MenuOptionsEnum>(
                value: MenuOptionsEnum.populate_users_posts,
                child: const Text('Populate users and posts'),
              ),
              const PopupMenuItem<MenuOptionsEnum>(
                value: MenuOptionsEnum.remove_users_posts,
                child: const Text('Remove stats'),
              ),
              const PopupMenuItem<MenuOptionsEnum>(
                value: MenuOptionsEnum.selfStarter,
                child: const Text('Being a self-starter'),
              ),
              const PopupMenuItem<MenuOptionsEnum>(
                value: MenuOptionsEnum.tradingCharter,
                child: const Text('Placed in charge of trading charter'),
              ),
            ],
          )

        ],
      title: new Text(
        _title_app,
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),

    //Content of tabs
    body:

    new PageView(
      controller: _tabController,
      onPageChanged: onTabChanged,
      children: <Widget>[
        new _firstTab.HomeScreen(),
        new _secondTab.DashboardScreen(),
        new _thirdTab.CartScreen()
      ],
    ),

    //Tabs
    bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS ?
      new CupertinoTabBar(
        activeColor: Colors.blueGrey,
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
      ):
      new Container(
        height: 46.0,
        child: new BottomNavigationBar(
          currentIndex: _tab,
          iconSize: 14.0,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          items: TabItems.map((TabItem) {
            return new BottomNavigationBarItem(
              title: new Text(TabItem.title,),
              icon: new Icon(TabItem.icon,),
            );
          }).toList(),
    ),
      ),

    //Drawer
    drawer: new Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            height: 120.0,
            child:

            _user == null ?

            new DrawerHeader(
              padding: new EdgeInsets.all(0.0),
              decoration: new BoxDecoration(
                color: new Color(0xFFECEFF1),
              ),
              child: new Center(
                child: new FlutterLogo(
                  colors: Colors.grey,
                  size: 54.0,
                ),
              ),
            )
                :
            new DrawerHeader(
              padding: new EdgeInsets.all(0.0),
              decoration: new BoxDecoration(
                color: Colors.redAccent,
              ),
              child: new Center(
                child: new Text("Logged in as ${_user.displayName}"),
              ),
            ),







          ),
          new ListTile(
            leading: new Icon(Icons.chat),
            title: new Text('Support'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/support');
            }
          ),
          new ListTile(
              leading:

              _user == null ?
              new Icon(Icons.verified_user)
              :
              new CircleAvatar(
                backgroundImage: new Image(
                  image: new NetworkImageWithRetry(_user.photoUrl),
                ).image,
                radius: 12.0,
              ),
              title: new Text(_user == null ? 'Login' : 'Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/login');
              }
          ),


          new ListTile(
            leading: new Icon(Icons.info),
            title: new Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/about');
            }
          ),

          new ListTile(
              leading: new Icon(Icons.settings),
              title: new Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/settings');
              }
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
            }
          ),
        ],
      )
    )
  );

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
      break;

      case 1:
        this._title_app = TabItems[1].title;
      break;

      case 2:
        this._title_app = TabItems[2].title;
      break;
    }
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
    _user = null;
  }

  @override
  void onUserLoaded(FirebaseUser user) {
    setState(() {
      _user = user;
    });
  }

  FirebaseUser _user;
  DbHelper _dbHelper;
  NetworkData _networkData;
  UserHelper _userHelper;
  FirestoreHelper _firestoreHelper;
  @override
  void onDbNetworkDataLoaded(DbHelper dbHelper, NetworkData networkData, UserHelper userHelper, FirestoreHelper firestoreHelper) {
    _dbHelper = dbHelper;
    _networkData = networkData;
    _userHelper = userHelper;
    _firestoreHelper = firestoreHelper;

    if(_userHelper.isLoggedIn()){
      setState(() {
        _user = _userHelper.getUser();
      });
    }else
      _presenter.signInSilently();
  }

  @override
  void onStatsLoaded(List<Statistic> stats) {
    // TODO: implement onStatsLoaded
  }
}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Home', icon: Icons.home),
  const TabItem(title: 'Dashboard', icon: Icons.dashboard),
  const TabItem(title: 'Chat', icon: Icons.people)
];

enum MenuOptionsEnum { populate_users_posts, remove_users_posts, selfStarter, tradingCharter }