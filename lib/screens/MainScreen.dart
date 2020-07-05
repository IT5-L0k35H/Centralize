import 'package:Centralize/screens/chats/chats.dart';
import 'package:Centralize/screens/exploreScreen/explore.dart';
import 'package:Centralize/screens/homeScreen/home.dart';
import 'package:Centralize/screens/notification/notifications.dart';
import 'package:Centralize/screens/userServices/myservices.dart';
import 'package:Centralize/service/auth.dart';
import 'package:Centralize/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(auth: Auth(),),
            Explore(),
            Chats(),
            NOtifications(),
            MyServices(),
          ],
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: new Theme(
                data: Theme.of(context).copyWith(
                  // sets the background color of the `BottomNavigationBar`
                  canvasColor: Theme.of(context).primaryColor,
                  // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                  primaryColor: Theme.of(context).accentColor,

                  textTheme: Theme.of(context).textTheme.copyWith(
                        caption: TextStyle(color: Colors.black),
                      ),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          color: Colors.black45,
                          size: 17,
                        ),
                        title: Text(
                          "Home",
                          style: TextStyle(fontSize: 10),
                        ),
                        activeIcon: Icon(
                          Icons.home,
                          color: Colors.blue,
                          size: 18,
                        )),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.explore,
                          size: 17,
                          color: Colors.black45,
                        ),
                        title: Text("Explore", style: TextStyle(fontSize: 10)),
                        activeIcon: Icon(
                          Icons.explore,
                          size: 17,
                          color: Colors.black45,
                        )),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.black45,
                          size: 17,
                        ),
                        title: Text("Message", style: TextStyle(fontSize: 10)),
                        activeIcon: Icon(
                          Icons.chat_bubble,
                          color: Colors.blue,
                          size: 18,
                        )),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.notifications_none,
                          color: Colors.black45,
                          size: 17,
                        ),
                        title: Text("Notification",
                            style: TextStyle(fontSize: 10)),
                        activeIcon: Icon(
                          Icons.notifications,
                          color: Colors.blue,
                          size: 18,
                        )),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.work,
                          color: Colors.black45,
                          size: 17,
                        ),
                        title: Text("Services", style: TextStyle(fontSize: 10)),
                        activeIcon: Icon(
                          Icons.work,
                          color: Colors.blue,
                          size: 18,
                        )),
                  ],
                  onTap: navigationTapped,
                  currentIndex: _page,
                ),
              ),
            )));
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
