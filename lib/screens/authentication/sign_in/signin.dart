import 'package:Centralize/screens/MainScreen.dart';
import 'package:Centralize/screens/authentication/sign_in/social_sign_in_button.dart';
import 'package:Centralize/screens/authentication/signup.dart';
import 'package:Centralize/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Centralize/widgets/responsive_ui.dart';
import 'package:Centralize/screens/authentication/widgets/textformfield.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.auth});
  final AuthBase auth;


  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _signInContent(),
    );
  }


Widget _signInContent() {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
       clipShape(),
       SizedBox(height: 150.0),
        /*OutlineButton(
          splashColor: Colors.grey,
          onPressed: _signInWithGoogle,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage('assets/images/auth/googlelogo.png'),
                    height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
       */ SocialSignInButton(
            assetName: 'assets/images/auth/googlelogo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: _signInWithGoogle,
          ),
          SizedBox(height: 15.0),
          SocialSignInButton(
            assetName: 'assets/images/auth/fblogo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () {},
          ),
          SizedBox(height: 15.0),
        SocialSignInButton(
           assetName: 'assets/images/auth/fblogo.png',
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.orange[300],
            onPressed: _signInAnonymously,
          ),
          SizedBox(height: 15.0),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),

       
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
                  fontSize:  20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

}
/*
class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return SafeArea(
      child: Material(
        child: Container(
          height: _height,
          width: _width,
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                clipShape(),
                //welcomeTextRow(),
                // signInTextRow(),
                form(),
                forgetPassTextRow(),
                SizedBox(height: _height / 30),
                button(),
                SizedBox(height: _height / 20),
                infoTextRow(),
                socialIconsRow(),
                SizedBox(height: _height / 12),
                signUpTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        /*Opacity(
          opacity: 0.8,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[100], Colors.deepPurple],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.8,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[100], Colors.deepPurple],
                ),
              ),
            ),
          ),
        ),
       */
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
                    fontSize: _large ? 40 : (_medium ? 30 : 25),
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
                  fontSize: _large ? 20 : (_medium ? 18 : 16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: emailController,
      icon: Icons.email,
      hint: "Email",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.visiblePassword,
      textEditingController: passwordController,
      icon: IconData(
        0xe0e6,
        fontFamily: 'MaterialIcons',
      ),
      hint: "Password",
    );
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.deepPurple),
            ),
          )
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        print("Routing to your account");
        /* Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Login Successful')));*/
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: [Colors.deepPurple[100], Colors.deepPurple],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN IN',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.deepPurple,
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Sign in using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 13 : 12)),
          ),
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 60.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            elevation: 3.0,
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: Ink.image(
              image: AssetImage('assets/images/auth/googlelogo.png'),
              fit: BoxFit.fill,
              width: 50.0,
              height: 50.0,
              child: InkWell(
                onTap: () {
                  /*signInWithGoogle().whenComplete(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MainScreen();
                        },
                      ),
                    );
                  });*/
                },
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Material(
            elevation: 3.0,
            shape: CircleBorder(side: BorderSide(width: 0)),
            clipBehavior: Clip.hardEdge,
            color: Colors.white,
            child: Ink.image(
              image: AssetImage('assets/images/auth/fblogo.jpg'),
              fit: BoxFit.scaleDown,
              width: 50.0,
              height: 50.0,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Material(
            elevation: 3.0,
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.white,
            child: Ink.image(
              image: AssetImage('assets/images/auth/twitterlogo.jpg'),
              fit: BoxFit.cover,
              width: 50.0,
              height: 50.0,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
-*/