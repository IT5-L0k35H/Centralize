import 'package:Centralize/screens/homeScreen/widget/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
//   Home({@required this.auth});
//   final AuthBase auth;

//   Future<void> _signOut() async {
//     try {
// //FirebaseUser user = (await FirebaseAuth.instance.signInAnonymously()) as FirebaseUser;
//       await auth.signOut();
//     } catch (e) {
//       print(e.toString());
//     }
//   }

  @override
  _HomeState createState() => _HomeState();
}

final GlobalKey _scaffoldKey = new GlobalKey();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                iconSize: 30.0,
                icon: const Icon(
                  //CustomIcons.menu,
                  Icons.short_text,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text(
            "Centralize",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.black87),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              iconSize: 24.0,
              icon: Icon(
                Icons.search,
              ),
              onPressed: () => {},
            ), //Navigator.push(context,
            //MaterialPageRoute(builder: (context) => UserProfile()))),
            IconButton(
              iconSize: 35.0,
              icon: Icon(
                Icons.account_circle,
              ),
              onPressed: () => {},
            ) //Navigator.push(context,
            //  MaterialPageRoute(builder: (context) => UserProfile()))),
          ],
        ),
     
      drawer: Drawar(),
      
     
      ),
    );
  }
}
