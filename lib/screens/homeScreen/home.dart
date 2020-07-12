import 'package:Centralize/screens/homeScreen/widget/drawer.dart';
import 'package:Centralize/screens/profile/userProfile.dart';
import 'package:Centralize/service/auth.dart';
import 'package:Centralize/service/createUserDatabase.dart';
import 'package:Centralize/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {

  // Home(this.users);
  // final CreateUserDatabase users;
  @override
  _HomeState createState() => _HomeState();
}

final GlobalKey _scaffoldKey = new GlobalKey();

class _HomeState extends State<Home> {
   CreateUserDatabase user;
   String myuserID;


   _getUser(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
      user = await auth.currentUser();
      print(user.uid);
      myuserID = user.uid;
     // return user.uid;
     }

   
//  final String userID = users;
//     String usName;
//     final userRef = Firestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
  _getUser(context);
    print(myuserID);
  //final user = Provider.of<CreateUserDatabase>(context);
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          iconSize: 30.0,
          icon: const Icon(
            //CustomIcons.menu,
            Icons.short_text,
            color: Colors.black87,
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
           color: Colors.black87,
        ),
        onPressed: () => {},
      ),
      IconButton(
        iconSize: 35.0,
        icon: Icon(
          Icons.account_circle,
          color: Colors.black87,
        ),
        onPressed: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserProfile(myuserID)))),
           ],
          ),
     
        drawer: Drawar(),
        
       body: ListView(
         children: <Widget>[
           _buildUserInfo(user)
         ]
       ),
        
     
        ),
    );
  }


   Widget _buildUserInfo(CreateUserDatabase user) {
    return Column(
      children: <Widget>[

        Container(color: Colors.amber,)
        // Avatar(
        //   photoUrl: user.photoURL,
        //   radius: 50,
        // ),
        // SizedBox(height: 18),
        // if (user.displayName != null)
        //   Text(
        //     user.displayName,
        //     style: TextStyle(color: Colors.indigo,fontSize: 24,),
        //   )else(
        //      Text(
        //     'No User Name yet',
        //     //user.displayName,
        //     style: TextStyle(color: Colors.indigo,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 24,),
        //      )
        //   ),
        // SizedBox(height: 8),
      ],
    );
 }
}
