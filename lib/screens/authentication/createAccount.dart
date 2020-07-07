import 'package:Centralize/screens/authentication/registerForm.dart';
import 'package:Centralize/screens/authentication/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:Centralize/widgets/responsive_ui.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
   
  void _registerForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => RegisterForm(),
      ),
    );
  }

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Account',
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 18, color: Colors.black87),
          ),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
               // welcomeImage(),

                SizedBox(
                  height: _height / 8,
                ),

                //orsignUPText(),
                
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    children: <Widget>[
                       enterEmailTextRow(),
                       SizedBox(
                  height: 10,
                ),
                      emailTextFormField(),
                    ],
                  ),
                ),
                SizedBox(
                  height: _height / 40,
                ),
                registerButton(),
                SizedBox(
                  height: _height / 8,
                ),
                // acceptTermsTextRow(),
                infoTextRow(),
                socialIconsRow(),
                SizedBox(
                  height: _height / 30,
                ),
                // button(),
                signInTextRow(),
                SizedBox(
                  height: _height / 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget welcomeImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        color: Colors.red,
        width: _width,
        child: Image(
          image: AssetImage('assets/images/auth/hey.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

Widget enterEmailTextRow(){
  return Container(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.only(left:10.0),
      child: Text(
        
              "Enter Email to continue ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                  fontSize: _large ? 14 : (_medium ? 13 : 12)),
            ),
    ),
  );
}

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email ID",
    );
  }

  Widget infoTextRow() {
    return Container(
      //s margin: EdgeInsets.only(top: _height / 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Sign up using",
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
      margin: EdgeInsets.only(top: _height / 68.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonTheme(
            minWidth: _width / 3,
            child: OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        image: AssetImage('assets/images/auth/google.png'),
                        height: 22.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Google',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ButtonTheme(
            minWidth: _width / 3,
            child: OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        image: AssetImage('assets/images/auth/facebook.png'),
                        height: 22.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Facebook',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerButton() {
    return Center(
      child: RaisedButton(
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        onPressed:()=>_registerForm(context),
        textColor: Colors.blue,
        color: Colors.white,
        padding: EdgeInsets.all(0.0),
        child: Container(
         // color: Colors.deepPurple[200],
          alignment: Alignment.center,
//        height: _height / 20,
          width:
              _large ? _width / 1.5 : (_medium ? _width / 1.25 : _width / 1.20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(
              width: 0,
             // color: Colors.deepPurple,
            ),
             gradient:  LinearGradient(
                    colors: [Colors.deepPurple[100], Colors.deepPurple],
                  ),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Register',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _large ? 16 : (_medium ? 15 : 14)),
          ),
        ),
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 45.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.deepPurple,
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
