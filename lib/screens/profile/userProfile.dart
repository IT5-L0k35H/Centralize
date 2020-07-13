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
          child: Stack(
            children: <Widget>[
              Container(
                height: 500.0,
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
                        height: 380,
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

                                    height: 330,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(45, 48, 58,
                                                0.12),
                                            offset: Offset(0, 3),
                                            blurRadius: 20)
                                      ],
                                      color: Color.fromRGBO(255, 255, 255, 5),
                                    ))),
                            Positioned(
                                //Naame container
                                top: 68,
                                left: 22,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          user.displayName,
                                          //'Kristin Watson',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Poppins',
                                              fontSize: 19,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.bold,
                                              height: 1),
                                        ),
                                        SizedBox(width: 17.0),
                                        // Image.asset('assets/verified.jpeg')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                         Text(
                                          '@',//'Professional Dancer',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color:
                                                  Colors.deepPurple,
                                              fontFamily: 'Poppins',
                                              fontSize: 14,

                                              letterSpacing:
                                                  1.20 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.w600,
                                              height: 1),
                                        ),
                                        Text(
                                          user.userName, //'Professional Dancer',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color:
                                                  Colors.deepPurple,
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              letterSpacing:
                                                  1.20 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.w600,
                                              height: 1),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                     _checkprofession(user),
                                   
                                  ],
                                )),
                            Positioned(
                              top: 230,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Followers',
                                            style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontFamily: 'Poppins',
                                                fontSize: 17,
                                                letterSpacing:
                                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                                fontWeight: FontWeight.normal,
                                                height: 1),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            user.followers,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    236, 113, 0, 1),
                                                fontFamily: 'Poiret One',
                                                fontSize: 25,
                                                fontWeight: FontWeight.normal,
                                                height: 1),
                                          ),
                                          SizedBox(height: 5.0),
                                          // FlatButton(
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(10.0),
                                          //     ),
                                          //     color: Colors.grey[200],
                                          //     onPressed: () {},
                                          //     child: Row(
                                          //       children: <Widget>[
                                          //         Text(
                                          //           'Following',
                                          //           style: TextStyle(
                                          //             fontFamily: 'Comfortaa',
                                          //             fontWeight:
                                          //                 FontWeight.bold,
                                          //             fontSize: 15.0,
                                          //             color: Color.fromRGBO(
                                          //                 98, 101, 228, 0.9),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 7,
                                          //         ),
                                          //         Icon(
                                          //           Icons.person_add,
                                          //           color: Color.fromRGBO(
                                          //               98, 101, 228, 0.9),
                                          //           size: 24,
                                          //         )
                                          //       ],
                                          //     ))
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 26,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Following',
                                            style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontFamily: 'Poppins',
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal,
                                                height: 1),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            user.following, //'453',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    236, 113, 0, 1),
                                                fontFamily: 'Poiret One',
                                                fontSize: 25,
                                                fontWeight: FontWeight.normal,
                                                height: 1),
                                          ),
                                          SizedBox(height: 5.0),
                                          // FlatButton(
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(10.0),
                                          //     ),
                                          //     color: Color.fromRGBO(
                                          //         98, 101, 228, 0.8),
                                          //     onPressed: () {},
                                          //     child: Row(
                                          //       children: <Widget>[
                                          //         Text(
                                          //           'Message',
                                          //           style: TextStyle(
                                          //               fontFamily: 'Comfortaa',
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //               fontSize: 15.0,
                                          //               color: Colors.white),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 7,
                                          //         ),
                                          //         Icon(
                                          //           Icons.mail_outline,
                                          //           color: Colors.white,
                                          //           size: 24.0,
                                          //         ),
                                          //       ],
                                          //     )),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            Positioned(
                              //about container
                              top: 320,
                              left: 22,
                              right: 35,
                              child: buttonMenu(),
                            ),
                            Positioned(
                              //about container
                              top: 162,
                              left: 22,
                              right: 35,
                              child: _checkbio(user),
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
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
                                          color: Color.fromRGBO(
                                              92, 92, 92, 0.4000000059604645),
                                          offset: Offset(3, 4),
                                          blurRadius: 10)
                                    ],
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(85, 85)),
                                    color: Color.fromRGBO(196, 196, 196, 1),
                                  ),
                                  // child: Avatar(
                                  //   photoUrl: user.photoURL,
                                  //   radius: 85,
                                  // ),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentUser(context);
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: <Widget>[
          profilePageBuilder(),
        ],
      )),
    );
  }

  buttonMenu() {
    if (isOwner) {
      return FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.deepOrange[400],
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
            fontSize: 14,
            fontWeight: FontWeight.normal,
            height: 1),
      );
    } else {
      return Text(
        'Add bio',
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Alef',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            height: 1),
      );
    }
  }
  Widget _checkprofession(CreateUserDatabase user) {
    if (user.profession != null) {
      return Text(
        user.profession,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Alef',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            height: 1),
      );
    } else {
      return Text(
        'Add Profession',
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Alef',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            height: 1),
      );
    }
  }

  Widget getWorks(String imgPath, String name) {
    return Padding(
      padding: EdgeInsets.only(right: 13.0),
      child: Container(
        height: 100.0,
        width: 90.0,
        child: RaisedButton(
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          padding: const EdgeInsets.all(0.0),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.grey[0],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        constraints: const BoxConstraints(
                            minWidth: 89.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.bottomCenter,

                        child: Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.justify,
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
                  )),
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
