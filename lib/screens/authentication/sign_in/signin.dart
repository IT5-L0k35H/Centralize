import 'package:Centralize/screens/authentication/createAccount.dart';
import 'package:Centralize/screens/authentication/widgets/social_sign_in_button.dart';
import 'package:Centralize/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Centralize/screens/authentication/sign_in/sign_in_with_email.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Centralize/widgets/platform_exception_alert_dialog.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  bool _isLoading = false;

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      
      await auth.signInWithGoogle(context);


      
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    } finally {
     setState(() => _isLoading = false);
    }
  }

// Future<void> _signInWithFacebook(BuildContext context) async {
//     try {
//       setState(() => _isLoading = true);
//       final auth = Provider.of<AuthBase>(context,listen:false);
//       await auth.signInWithFacebook();
//     } on PlatformException catch (e) {
//       if (e.code != 'ERROR_ABORTED_BY_USER') {
//         _showSignInError(context, e);
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  void _registerWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => CreateAccount(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _signInContent(context),
    );
  }

  Widget _signInContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            clipShape(),
            SizedBox(
              height: 50.0,
              child: _buildHeader(),
            ),
            SizedBox(height: 150.0),
            SocialSignInButton(
              assetName: 'assets/images/auth/google.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: _isLoading ? null : () => _signInWithGoogle(context),
            ),
            SizedBox(height: 15.0),
            SocialSignInButton(
              assetName: 'assets/images/auth/facebook.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xFF3b5998),
              onPressed: () {},
            ),
            SizedBox(height: 15.0),
            SocialSignInButton(
              assetName: 'assets/images/auth/mail.png',
              text: 'Sign in with email',
              textColor: Colors.white,
              color: Colors.orange[400],
              onPressed: _isLoading ? null : () => _signInWithEmail(context),
            ),
            SizedBox(height: 15.0),
            Text(
              'or',
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            //signUpTextRow(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () => _registerWithEmail(context),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.deepPurple,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(top: 40, left: 16),
              child: Text(
                "Welcome",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 40,
                    color: Colors.deepPurple[600]),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(left: 16),
              child: Text(
                "Sign in to your account",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.deepPurple[300],
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return null;
  }
}
