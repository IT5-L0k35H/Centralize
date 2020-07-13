import 'package:Centralize/screens/profile/editProfileForm.dart';
import 'package:Centralize/service/auth.dart';
import 'package:Centralize/service/createUserDatabase.dart';
import 'package:Centralize/widgets/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.userID);
  final String userID;

  @override
  _UserProfile createState() => _UserProfile(userID);
}

class _UserProfile extends State<UserProfile> {
  final userRef = Firestore.instance.collection('users');
  // final String userID = user.uid;

  _UserProfile(this.userID);
  String userID;
  String currentUserID;
  bool isOwner;
    CreateUserDatabase user;

  List socialAcc = [
    "Facebook",
    "Instagram",
    "Twitter",
    "LinkedIn",
    "Dribble",
    "Youtube",
    "Github",
    "Behance",
  ];

  _getCurrentUser(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    CreateUserDatabase currentUser = await auth.currentUser();
    print(currentUser.uid);
    print(' Above is current user id');
    isOwner = userID == currentUserID;
    print(isOwner);
    currentUserID = currentUser.uid;
    // return user.uid;
  }

  profilePageBuilder() {
    _getCurrentUser(context);
    print('$userID is active profile user');
    // isOwner = userID == currentUserID;
    // print(isOwner);
    return FutureBuilder(
      future: userRef.document(userID).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(child: CircularProgressIndicator()));
        }
        user =
            CreateUserDatabase.fromDocument(snapshot.data);
print(user.displayName);
        return Padding(
          padding: EdgeInsets.all(0.0),
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 540.0,
                    width: double.infinity,
                    child: Stack(children: <Widget>[
                      Positioned(
                        ////Cover pic container
                        child: Container(
                            //Cover pic
                            height: 240.0,
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                // topLeft: Radius.circular(8),
                                //topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              image: new DecorationImage(
                                image: ExactAssetImage(
                                    'assets/images/profile/cm0.jpeg'),
                                fit: BoxFit.fitWidth,
                              ),
                            )
                            //color: Color(0xFFFA624F),
                            ),
                      ),
                      Align(
                        //back arrow
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        //menu
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                          top: 95,
                          left: 23,
                          right: 23,
                          child: Container(
                            height: 420,
                            color: Colors.transparent,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                    //UP background position
                                    top: 50,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        //UP background container

                                        height: 370,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    45, 48, 58, 0.12),
                                                offset: Offset(0, 3),
                                                blurRadius: 20)
                                          ],
                                          color:
                                              Color.fromRGBO(255, 255, 255, 5),
                                        ))),
                                Positioned(
                                    //Naame container
                                    top: 68,
                                    left: 22,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              user.displayName,
                                              //'Kristin Watson',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 19,
                                                  letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1),
                                            ),
                                            SizedBox(width: 17.0),
                                            Image.asset(
                                                'assets/images/profile/verified.jpeg')
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '@', //'Professional Dancer',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontFamily: 'MuseoModerno',
                                                  fontSize: 15,
                                                  letterSpacing:
                                                      1.20 /*percentages not used in flutter. defaulting to zero*/,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1),
                                            ),
                                            Text(
                                              user.userName, //'Professional Dancer',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontFamily: 'MuseoModerno',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        _checkprofession(user),
                                      ],
                                    )),
                                Positioned(
                                  //about container
                                  top: 185,
                                  left: 22,
                                  right: 35,
                                  child: _checkbio(user),
                                ),
                                Positioned(
                                  top: 295,
                                  right: 22,
                                  left: 22,
                                  // child: buttonMenu(),
                                  child: Container(
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Followers',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1),
                                              ),
                                              SizedBox(height: 2.0),
                                              Text(
                                                user.followers,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        236, 113, 0, 1),
                                                    fontFamily: 'Poiret One',
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 35,
                                                width: 1,
                                                child: Container(
                                                  color: Colors.black26,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                                width: 37,
                                              )
                                              // SizedBox(width: 35.0),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Following',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1),
                                              ),
                                              SizedBox(height: 2.0),
                                              Text(
                                                user.following, //'453',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        236, 113, 0, 1),
                                                    fontFamily: 'Poiret One',
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1),
                                              ),
                                              SizedBox(height: 5.0),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                                Positioned(
                                  //about container
                                  top: 360,
                                  left: 22,
                                  right: 22,
                                  child: buttonMenu(),
                                ),
                                Positioned(
                                    //rating and review position
                                    top: 95,
                                    right: 36,
                                    child: Container(
                                      //rating and review container

                                      width: 90,
                                      height: 32,

                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            size: 24,
                                            color: Colors.yellow,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            '4.5',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'PoiretOne',
                                                fontSize: 23,
                                                fontWeight: FontWeight.w600,
                                                height: 1),
                                          ),
                                          SizedBox(width: 8.0),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 20,
                                            color: Colors.black45,
                                          )
                                        ],
                                      ),
                                    )),
                                Positioned(
                                    //Dp
                                    //dp
                                    top: 0,
                                    right: 40,
                                    child: Container(
                                      width: 85,
                                      height: 85,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(92, 92, 92,
                                                  0.4000000059604645),
                                              offset: Offset(3, 4),
                                              blurRadius: 10)
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(85, 85)),
                                        color: Color.fromRGBO(196, 196, 196, 1),
                                      ),
                                      child: CircleAvatar(
                                        radius: 85,
                                        backgroundColor: Colors.deepOrange[100],
                                        backgroundImage: user.photoURL != null
                                            ? NetworkImage(user.photoURL)
                                            : null,
                                        child: user.photoURL == null
                                            ? Icon(
                                                Icons.person,
                                                size: 60,
                                                color: Colors.indigo[500],
                                              )
                                            : null,
                                      ),
                                    )),
                              ],
                            ),
                          ))
                    ]),
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Follow me on',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'see all',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15.0,
                          color: Color.fromRGBO(99, 103, 255, 1),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 5.0),
                child: Container(
                  height: 100.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                       ButtonTheme(
           minWidth: 90,
           height: 100,
            child: OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              highlightElevation: 5,
     
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text('Add New', style:  TextStyle(
            color: Colors.black54,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            height: 1),)
                    // Image(
                    //     image: AssetImage('assets/images/auth/google.png'),
                    //     height: 22.0),
                   
                  ],
                ),
              ),
            ),
          ),
                      // getWorks('assets/images/profile/cm0.jpeg', socialAcc[2]),
                      // getWorks('assets/images/profile/cm0.jpeg', socialAcc[1]),
                      // getWorks('assets/images/profile/cm0.jpeg', socialAcc[3]),
                      // getWorks('assets/images/profile/cm0.jpeg', socialAcc[4]),
                      // getWorks('assets/images/profile/cm0.jpeg', socialAcc[5]),
                      // getWorks('assets/images/profile/cm0.jpeg', socialAcc[0]),
                      // getWorks('assets/images/profile/cm0.jpeg', socialAcc[6]),
                      // getWorks('assets/images/profile/cm0.jpeg', socialAcc[7]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentUser(context);
    return SafeArea(
      child: Scaffold(
        //   body: ListView(
        // children: <Widget>[
        body: profilePageBuilder(),
        // ],
        // )
      ),
    );
  }

  buttonMenu() {
    if (isOwner) {
      return Container(
        alignment: Alignment.center,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          gradient: LinearGradient(
              end: Alignment(-0.9999999403953552, -1.4791428526450545e-8),
              begin: Alignment(1.4200713494005868e-8, -0.0855286493897438),
              colors: [
                Color.fromRGBO(97, 100, 227, 1),
                Color.fromRGBO(132, 135, 254, 1)
              ]),
        ),
        child: FlatButton(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),

          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                fullscreenDialog: true,
                builder: (context) => EditProfileForm(userID),
              ),
            );
          },
          child: Center(
            child: Text(
              'Edit Profile',
              style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }

    return Container(
      child: Row(
        children: [
          FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color.fromRGBO(98, 101, 228, 0.8),
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Text(
                    'Follow',
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ],
              )),
          SizedBox(width: 30),
          FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color.fromRGBO(98, 101, 228, 0.8),
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Text(
                    'Message',
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _checkbio(CreateUserDatabase user) {
    if (user.bio != null) {
      return Text(
        user.bio,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Alef',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            height: 1),
      );
    }
    return Text(
      'Add bio',
      textAlign: TextAlign.left,
      style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Alef',
          fontSize: 16,
          fontWeight: FontWeight.normal,
          height: 1),
    );
  }

  Widget _checkprofession(CreateUserDatabase user) {
    if (user.profession != null) {
      return Text(
        user.profession,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.black54,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            height: 1),
      );
    }
    return Text(
      'Add Profession',
      textAlign: TextAlign.left,
      style: TextStyle(
          color: Colors.black54,
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.normal,
          height: 1),
    );
  }

  Widget getWorks(String imgPath, String name) {
    return Padding(
      padding: EdgeInsets.only(right: 13.0, bottom: 30),
      child: RaisedButton(
        onPressed: () {},
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0.0),
        child: ClipRect(
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(1, 2),
                    spreadRadius: 5.0,
                    blurRadius: 30)
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  constraints: const BoxConstraints(
                      minWidth: 89.0,
                      minHeight: 36.0), // min sizes for Material buttons
                  alignment: Alignment.bottomCenter,

                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Align(
                  //menu
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 18,
                    ),
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSocialmedia(String imgPath, String name) {
    return Padding(
        padding: EdgeInsets.only(right: 13.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(92, 92, 92, 0.4000000059604645),
                      offset: Offset(3, 4),
                      blurRadius: 10)
                ],
                color: Color.fromRGBO(196, 196, 196, 1),
                image: DecorationImage(
                    image: AssetImage(imgPath), fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.elliptical(85, 85)),
              )),
          SizedBox(
            height: 3,
          ),
          Container(
            height: 20,
            child: Text(
              name,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]));
  }

  Widget menuCard(String title, String imgPath, String type, int rating,
      double views, double likes) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(7.0),
        elevation: 4.0,
        child: Container(
          height: 125.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0), color: Colors.white),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10.0),
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imgPath), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(7.0)),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    type,
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 7.0),
                  Row(
                    children: <Widget>[
                      getStar(rating, 1),
                      getStar(rating, 2),
                      getStar(rating, 3),
                      getStar(rating, 4),
                      getStar(rating, 5)
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: <Widget>[
                      Icon(Icons.remove_red_eye,
                          color: Colors.grey.withOpacity(0.4)),
                      SizedBox(width: 3.0),
                      Text(views.toString()),
                      SizedBox(width: 10.0),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      SizedBox(width: 3.0),
                      Text(likes.toString())
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getStar(rating, index) {
    if (rating >= index) {
      return Icon(Icons.star, color: Colors.yellow);
    } else {
      return Icon(Icons.star, color: Colors.grey.withOpacity(0.5));
    }
  }
}
