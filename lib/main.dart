import 'package:custom_nav/page.dart';
import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await navigatorKeys[_currentIndex].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentIndex != 0) {
            // select 'main' tab
            setState(() {
              _currentIndex = 0;
            });
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: _items,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
          ),
          body: Stack(
            children: <Widget>[
              _buildPageOffstage(navigatorKeys[0], 0),
              _buildPageOffstage(navigatorKeys[1], 1),
              _buildPageOffstage(navigatorKeys[2], 2),
            ],
          )),
    );
  }

  Widget _buildPageOffstage(GlobalKey<NavigatorState> key, int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: CustomNavigator(
        navigatorKey: key,
        home: Page(title: 'Page $index'),
        pageRoute: PageRoutes.materialPageRoute,
      ),
    );
  }


  final navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  final _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
    BottomNavigationBarItem(icon: Icon(Icons.event), title: Text('events')),
    BottomNavigationBarItem(
        icon: Icon(Icons.save_alt), title: Text('downloads')),
  ];
}
