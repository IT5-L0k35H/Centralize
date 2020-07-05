import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

 final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
 String name;
String email;
String imageUrl;



Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';


}


void signOutGoogle() async{
  await _googleSignIn.signOut();

  print("User Sign Out");
}


/*
class AuthService{
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //final Firestore _firestore= Firestore.instance;

  //Observable<FirebaseUser> user;
}
final AuthService authService = AuthService();*/