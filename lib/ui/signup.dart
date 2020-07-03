import 'package:flutter/material.dart';
import 'package:Centralize/constants/constants.dart';
import 'package:Centralize/ui/widgets/custom_shape.dart';
import 'package:Centralize/ui/widgets/responsive_ui.dart';
import 'package:Centralize/ui/widgets/textformfield.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: _height,
            width: _width,
            margin: EdgeInsets.only(bottom: 5),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                
                   
                  clipShape(),
                  infoTextRow(),
                  socialIconsRow(),
                  
                  orsignUPText(),
                 
                  //usingEmail(),
                  form(),
                    acceptTermsTextRow(),
                  SizedBox(
                    height: _height / 35,
                  ),
                   button(),
                   signInTextRow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.8,
          child: ClipPath(
            clipper: CustomShapeClipper3(),
            child: Container(
              height: _large
                  ? _height / 7.0
                  : (_medium ? _height / 6.5 : _height / 6),
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
            clipper: CustomShapeClipper4(),
            child: Container(
              height: _large
                  ? _height / 6.5
                  : (_medium ? _height / 6.0 : _height / 5.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[100], Colors.deepPurple],
                ),
              ),
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Row(
              
              children: <Widget>[
                GestureDetector(
                  onTap: () =>  Navigator.pop(context),
                            child: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
                  ),
                ),

                   Container(
            margin: EdgeInsets.only( left: 16),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: _large ? 40 : (_medium ? 30 : 25),
                  color: Colors.white),
            ),
        ),
              ],
            ),
          ),
     

       
//        Positioned(
//          top: _height/8,
//          left: _width/1.75,
//          child: Container(
//            alignment: Alignment.center,
//            height: _height/23,
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color:  Colors.orange[100],
//            ),
//            child: GestureDetector(
//                onTap: (){
//                  print('Adding photo');
//                },
//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
//          ),
//        ),
      
      ],
    );
  }

  Widget usingEmail() {
    return Center(
      child: RaisedButton(
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        onPressed: () {
          print("Routing to your account");
        },
        textColor: Colors.blue,
        color: Colors.white,
        padding: EdgeInsets.all(0.0),
        child: Container(
          alignment: Alignment.center,
//        height: _height / 20,
          width: _large ? _width / 1.5 : (_medium ? _width / 1.25 : _width / 1.20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(
              width: 1,
              color: Colors.blue,
            ),
            /* gradient:  LinearGradient(
                    colors: [Colors.blue[100], Colors.blue],
                  ),*/
          ),
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Sign up using Email',
            style: TextStyle(fontSize: _large ? 16 : (_medium ? 15 : 14)),
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 40.0),
      child: Form(
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 90.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 90.0),
            emailTextFormField(),
            SizedBox(height: _height / 90.0),
            phoneTextFormField(),
            SizedBox(height: _height / 90.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "First Name",
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Last Name",
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email ID",
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Mobile Number",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      icon: Icons.lock,
      hint: "Password",
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.orange[200],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
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
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: [Colors.deepPurple[100], Colors.deepPurple],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
     //s margin: EdgeInsets.only(top: _height / 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Create account using social media",
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
          Material(
            elevation: 3.0,
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: Ink.image(
              image: AssetImage('assets/images/googlelogo.png'),
              fit: BoxFit.fill,
              width: 45.0,
              height: 45.0,
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
            shape: CircleBorder(side: BorderSide(width: 0)),
            clipBehavior: Clip.hardEdge,
            color: Colors.white,
            child: Ink.image(
              image: AssetImage('assets/images/fblogo.jpg'),
              fit: BoxFit.scaleDown,
              width: 45.0,
              height: 45.0,
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
              image: AssetImage('assets/images/twitterlogo.jpg'),
              fit: BoxFit.cover,
              width: 45.0,
              height: 45.0,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ),
        ],
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
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(SIGN_IN);
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
  Widget orsignUPText() {
    return Container(
      margin: EdgeInsets.only(top: _height / 45.0),
      child: Text(
        "Or sign Up using email",
        style: TextStyle(
         
          fontWeight: FontWeight.w400),
      ),
    );
  }
}
