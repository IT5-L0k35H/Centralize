import 'package:Centralize/screens/authentication/registerForm.dart';
import 'package:Centralize/service/createUserDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

CreateUserDatabase user;
// class User {
//   User(
//       {@required this.uid,
//       @required this.photoUrl,
//       this.userName,
//       @required this.displayName});
//   final String uid;
//   String userName;
//   final String photoUrl;
//   final String displayName;
// }

abstract class AuthBase {
  Stream<CreateUserDatabase> get onAuthStateChanged;
  Future<CreateUserDatabase> currentUser();
  Future<void> updateUserName(CreateUserDatabase user,String username);
  Future<CreateUserDatabase> signInAnonymously();
  Future<CreateUserDatabase> signInWithEmailAndPassword(
      String email, String password);
  Future<CreateUserDatabase> createUserWithEmailAndPassword(
      BuildContext context, String email, String password);
  Future<CreateUserDatabase> signInWithGoogle(BuildContext context);
  // Future<User> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final DateTime timestamp = DateTime.now();
  final usersRef = Firestore.instance.collection('users');
  final _firebaseAuth = FirebaseAuth.instance;

  CreateUserDatabase _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return CreateUserDatabase(
      uid: user.uid,
      // displayName: user.displayName,
      // photoURL: user.photoUrl,
    );
  }

  @override
  Future updateUserName(CreateUserDatabase user, String userName) async{

      usersRef.document(user.uid).updateData({"userName" : userName});
  //return _userFromFirebase(authResult.user);

//  FirebaseUser checkuser = 
//     await CreateUserDatabase(uid: checkuser.uid).updateUserData(
//         checkuser.displayName,
//         checkuser.providerId,
//         checkuser.email,
//         checkuser.photoUrl,
//         checkuser.uid,
//         " ",
//         //timestamp
//         );
  }

  @override
  Stream<CreateUserDatabase> get onAuthStateChanged {
    print("here");
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<CreateUserDatabase> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<CreateUserDatabase> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<CreateUserDatabase> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    // FirebaseUser checkuser = authResult.user;
    // await CreateUserDatabase(uid: checkuser.uid).updateUserData(
    //   checkuser.displayName,
    //   checkuser.providerId,
    //   checkuser.email,
    //   checkuser.photoUrl,
    //   checkuser.uid,
    //   " ",
    //   timestamp,
    // );

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<CreateUserDatabase> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser checkuser = authResult.user;
    DocumentSnapshot doc = await usersRef.document(checkuser.uid).get();
    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterForm()));
          
      await CreateUserDatabase(uid: checkuser.uid).updateUserData(
        checkuser.displayName,
        username, //checkuser.providerId"",
        checkuser.email,
        checkuser.photoUrl,
        checkuser.uid,
        " ",
        timestamp,
      );
    }
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<CreateUserDatabase> signInWithGoogle(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        FirebaseUser checkuser = authResult.user;
        DocumentSnapshot doc = await usersRef.document(checkuser.uid).get();
        if (!doc.exists) {
          print("Creating new google user");
          final username = null;
          await CreateUserDatabase(uid: checkuser.uid).updateUserData(
            checkuser.displayName,
            username, //checkuser.providerId"",
            checkuser.email,
            checkuser.photoUrl,
            checkuser.uid,
            " ",
            timestamp,
          );
        }
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  _getUserName(BuildContext context) async {
    print('Inside this');
    final username = null; //await Navigator.of(context).pushNamed(REGISTER);
    return username;
    //  return Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => RegisterForm()));
  }

  // @override
  // Future<User> signInWithFacebook() async {
  //   final facebookLogin = FacebookLogin();
  //   final result = await facebookLogin.logInWithReadPermissions(
  //     ['public_profile'],
  //   );
  //   if (result.accessToken != null) {
  //     final authResult = await _firebaseAuth.signInWithCredential(
  //       FacebookAuthProvider.getCredential(
  //         accessToken: result.accessToken.token,
  //       ),
  //     );
  //     return _userFromFirebase(authResult.user);
  //   } else {
  //     throw PlatformException(
  //       code: 'ERROR_ABORTED_BY_USER',
  //       message: 'Sign in aborted by user',
  //     );
  //   }
  // }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    // final facebookLogin = FacebookLogin();
    // await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
