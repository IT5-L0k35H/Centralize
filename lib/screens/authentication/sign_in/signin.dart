import 'package:Centralize/screens/authentication/widgets/social_sign_in_button.dart';
import 'package:Centralize/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:Centralize/screens/authentication/sign_in/sign_in_with_email.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Centralize/screens/authentication/models/sign_in_bloc.dart';
import 'package:Centralize/widgets/platform_exception_alert_dialog.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context,listen:false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, _) => SignInPage(bloc: bloc),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  // Future<void> _signInAnonymously(BuildContext context) async {
  //   try {
  //     await bloc.signInAnonymously();
  //   } on PlatformException catch (e) {
  //     _showSignInError(context, e);
  //   }
  // }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  // Future<void> _signInWithFacebook(BuildContext context) async {
  //   try {
  //     await bloc.signInWithFacebook();
  //   } on PlatformException catch (e) {
  //     if (e.code != 'ERROR_ABORTED_BY_USER') {
  //       _showSignInError(context, e);
  //     }
  //   }
  // }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          clipShape(),
          SizedBox(height: 150.0),
          SocialSignInButton(
            assetName: 'assets/images/auth/google.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () => _signInWithGoogle(context),
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
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(height: 15.0),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          signUpTextRow(),
        ],
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

  Widget signUpTextRow() {
    return Container(
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
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SignUpScreen()));
              print("Routing to Sign up screen");
            },
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
    );
  }
}
