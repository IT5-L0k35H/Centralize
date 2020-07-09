import 'package:Centralize/screens/MainScreen.dart';
import 'package:Centralize/screens/authentication/createAccount.dart';
import 'package:Centralize/screens/authentication/registerForm.dart';
import 'package:Centralize/screens/authentication/sign_in/signin.dart';
import 'package:Centralize/service/createUserDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service/auth.dart';
import 'package:Centralize/service/database.dart';
import 'package:Centralize/service/firestore_service.dart';

class CheckUserPage extends StatelessWidget {
  CheckUserPage(this.users);
  final CreateUserDatabase users;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final String userID = users.uid;
    String usName;
    final userRef = Firestore.instance.collection('users');
    // users = auth.currentUser();

    return StreamBuilder(
        stream: userRef.snapshots(), // auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) //connectionState == ConnectionState.active)
          {
            // CreateUserDatabase user = snapshot.data;
            userRef.document(userID).get().then((DocumentSnapshot doc) {
              print(doc.data);
              usName = doc.data['userName'];
              if (usName == null) {
                print("Not yet created");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RegisterForm())); // RegisterForm();
              }
              if (usName != null) {
                //  Navigator.of(context).pushReplacement((context), Ma) MainScreen();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              }
              //  usName = doc.data["userName"];
            });

            // if (usName == null) {
            //   print("Not yet created");
            //   return RegisterForm(); // RegisterForm();
            // }
            // if (usName != null) {
            //   return MainScreen();
            // }
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
