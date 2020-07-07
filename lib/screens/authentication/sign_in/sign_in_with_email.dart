import 'package:flutter/material.dart';
import 'package:Centralize/screens/authentication/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in',style: TextStyle(fontSize: 24),),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child:EmailSignInForm(),
      ),
      backgroundColor: Colors.white,
    );
  }
}
