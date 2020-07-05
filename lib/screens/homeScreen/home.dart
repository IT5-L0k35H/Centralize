import 'package:Centralize/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({@required this.auth});
  final AuthBase auth;


  
  Future<void> _signOut() async {
    try {
//FirebaseUser user = (await FirebaseAuth.instance.signInAnonymously()) as FirebaseUser;
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Homepage',
        style: TextStyle(color: Colors.blue[400], fontSize: 24),
      )),
      body: Center(
        child: Container(
          color: Colors.white,
          child: RaisedButton(
            color: Colors.blue[400],
            child: Text('Log Out',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            onPressed: widget._signOut,
          ),
        ),
      ),
    );
  }
}
