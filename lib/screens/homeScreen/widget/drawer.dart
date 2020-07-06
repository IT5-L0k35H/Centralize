import 'package:Centralize/service/auth.dart';
import 'package:Centralize/widgets/platform_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drawar extends StatelessWidget {
 
  Future<void> _signOut(BuildContext context) async {
    try {
       final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.0),
        //bottomRight: Radius.circular(10.0),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
              icon: Icons.contacts,
              text: 'Posts',
              onTap: () {
                //   Navigator.push(
                //     context,
                //      new MaterialPageRoute(builder: (context) => new SettingNav("Setting")),
                // );
              },
//              onTap: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => HomePage()),
//                );
//              },
            ),
            _createDrawerItem(
              icon: Icons.event,
              text: 'Events',
            ),
            _createDrawerItem(
              icon: Icons.note,
              text: 'Notes',
            ),
            Divider(height: 1.2, color: Colors.black45),
            _createDrawerItem(
                icon: Icons.collections_bookmark, text: 'Settings'),
            _createDrawerItem(icon: Icons.face, text: 'Profile'),
            _createDrawerItem(icon: Icons.account_box, text: 'Help'),
            _createDrawerItem(icon: Icons.stars, text: 'Contact us'),
            Divider(height: 1.2, color: Colors.black45),
            _createDrawerItem(icon: Icons.bug_report, text: 'Log Out', onTap: () => _confirmSignOut(context),),
            ListTile(
              title: Text('0.0.1'),
              onTap:(){},
            ),
          ],
        ),
      ),
    );
  }
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment(0.4, 0.0), // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xFFcdccff),
            const Color(0xFF6712e6)
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
        /* image: DecorationImage(
              fit: BoxFit.fill, 
              image: AssetImage('images/back.jpg'))*/
      ),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Lokesh Verma",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
        Positioned(
            bottom: 35.0,
            left: 16.0,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/auth/google.png'),
            ))
      ]));
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
