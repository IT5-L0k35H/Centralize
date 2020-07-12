import 'package:Centralize/screens/authentication/widgets/textformfield.dart';
import 'package:Centralize/screens/profile/userProfile.dart';
import 'package:Centralize/service/auth.dart';
import 'package:Centralize/service/createUserDatabase.dart';
import 'package:Centralize/widgets/customTextField.dart';
import 'package:Centralize/widgets/responsive_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileForm extends StatefulWidget {
  EditProfileForm(this.userID);
  final String userID;

  @override
  _EditProfileFormState createState() => _EditProfileFormState(userID);
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final userRef = Firestore.instance.collection('users');

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  CreateUserDatabase user;
  String displayName;
  String userName;
  String profession;
  String bio;
  String initialdisplayName = 'Add display name';
  String initialuserName = 'Update user name';
  String initialprofession = 'Add a profession';
  String initialbio = 'Add bio';
  //String mobile = 'Add phone number';
  bool _displaynameValid= true;
  bool _userNameValid= true;
  bool _professionValid= true;
  bool _bioValid= true;

  _EditProfileFormState(this.userID);
  String userID;

  Color color;

  _updateProfile() async {
    _formKey.currentState.save();

    final auth = Provider.of<AuthBase>(context, listen: false);
    CreateUserDatabase user = await auth.currentUser();

    await auth.updateProfile(user, displayName, userName, profession, bio);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => UserProfile(user.uid)));
  }

  _editProfileBuilder() {
    return FutureBuilder(
        future: userRef.document(userID).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          user = CreateUserDatabase.fromDocument(snapshot.data);
          initialuserName = user.userName;
          if (user.displayName != null) {
            initialdisplayName = user.displayName;
          }

          if (user.profession != null) {
            initialprofession = user.profession;
          }
          if (user.bio != null) {
            initialbio = user.bio;
          }

          return Container(
            height: _height,
            width: _width,
          
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  coverImage(),

                  SizedBox(
                    height: _height / 50,
                  ),
                  buttonsRow(),
                  SizedBox(
                    height: _height / 30,
                  ),
                  editInfoText(),
                  SizedBox(
                    height: _height / 50,
                  ),
                  form(),

                  SizedBox(
                    height: _height / 35,
                  ),
                  saveButton(),
                  SizedBox(
                    height: _height / 20,
                  ),
                  // signInTextRow(),
                ],
              ),
            ),
          );
        });
  }

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
          appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: _height / 17,
              leading: CloseButton(color: Colors.black),
              title: Text(
                'Edit profile',
                style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 17, color: Colors.black87),
              ),
              centerTitle: true,
              elevation: 2.0,
              actions: <Widget>[
                ButtonTheme(
                  buttonColor: Colors.white,
                  //minWidth: 120.0,
                  splashColor: Colors.deepOrange[150],

                  child: FlatButton(
                    onPressed: () {},
                    //elevation: 5.0,
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.deepOrange[400],
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ]),
          body: _editProfileBuilder(),
        ),
      ),
    );
  }

  Widget saveButton() {
    return RaisedButton(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      onPressed: () {
        _updateProfile();
      }, //submitEnabled ? _submit : null,
     
      padding: EdgeInsets.all(0.0),
      child: Container(
        width: _width / 2,
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          gradient: LinearGradient(
            colors: [Colors.deepPurple[300], Colors.deepPurple],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget editInfoText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 16.0),
          child: SizedBox(
            child: Container(
              color: Colors.black87,
            ),
            width: _width / 3.5,
            height: 0.75,
          ),
        ),
        Text(
          'Edit Information',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: SizedBox(
            child: Container(
              color: Colors.black87,
            ),
            width: _width / 3.5,
            height: 0.75,
          ),
        ),
      ],
    );
  }

  Widget buttonsRow() {
    return Container(
      margin: EdgeInsets.only(
          top: _height / 80.0, left: _height / 20, right: _height / 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ButtonTheme(
            splashColor: Colors.white,
            minWidth: _width / 3,
            child: RaisedButton(
              color: Colors.deepPurple,
              splashColor: Colors.white30,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              highlightElevation: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Update profile photo',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          ButtonTheme(
            splashColor: Colors.white,
            minWidth: _width / 3,
            child: RaisedButton(
           color: Colors.deepPurple,
              splashColor: Colors.white30,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              highlightElevation: 0,
             
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget coverImage() {
    return Material(
      child: Container(
        height: _height / 4,
        // margin: EdgeInsets.only(top: _height/20),
        width: double.infinity,
        child: Stack(children: <Widget>[
          Container(
            //Cover pic
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Ink.image(
              image: AssetImage('assets/images/profile/cm0.jpeg'),
              fit: BoxFit.fitWidth,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              child: Material(
                shadowColor: Colors.white,
                elevation: 4.0,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: user.photoURL != null
                      ? NetworkImage(user.photoURL)
                      : Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.indigo[500],
                        ), //AssetImage('assets/images/profile/cm7.jpeg'),
                  fit: BoxFit.cover,
                  width: 80.0,
                  height: 80.0,
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 4,
              right: 8,
              child: ButtonTheme(
                buttonColor: Colors.white38,
                //minWidth: 120.0,
                height: 30.0,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Change cover photo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        ]),
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
        left: _width / 12.0,
        right: _width / 12.0,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: initialdisplayName,
              decoration: InputDecoration(
                labelText: 'Display Name',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple[800],
                ),
                hintText: 'Add display name',
              ),
              onSaved: (newValue) => displayName = newValue,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: initialuserName,
              decoration: InputDecoration(
                labelText: 'User Name',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple[800],
                ),
                hintText: 'Add user name',
              ),
              onSaved: (newValue) => userName = newValue,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: initialprofession,
              decoration: InputDecoration(
                labelText: 'Profession',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple[800],
                ),
                hintText: 'Add Profession',
              ),
              onSaved: (newValue) => profession = newValue, // autofocus: false,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              initialValue: initialbio,
              decoration: InputDecoration(
                labelText: 'About Me',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.deepPurple[800]),
                hintText: 'Add bio',
              ),
              onSaved: (newValue) => bio = newValue,
            ),
            SizedBox(
              height: 10,
            ),
            // TextFormField(

            //   initialValue: mobile,
            //   decoration: InputDecoration(
            //     labelText: 'Phone',
            //     labelStyle: TextStyle(
            //       fontWeight: FontWeight.w600,
            //       color: Colors.deepPurple[800],
            //     ),
            //     hintText: 'Phone number',
            //   ),

            // ),
          ],
        ),
      ),
    );
  }
}
