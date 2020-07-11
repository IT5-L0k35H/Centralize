import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUserDatabase {
  CreateUserDatabase({
    this.uid,
    this.bio,
    this.userName,
    this.createdOn,
    this.displayName,
    this.email,
    this.profession,
    this.followers,
    this.following,
    this.photoURL,
  });
  final String uid;
  String displayName;
  String userName;
  String email;
  String photoURL;
  String bio;
   String profession;
    String followers;
    String following;
  DateTime createdOn;

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  //get userName => null;

  Future updateUserData(
    String displayName,
    String userName,
    String email,
    String photoURL,
    String userId,
    String bio,
    String profession,
    String followers,
    String following,
    DateTime createdOn,
  ) async {
    return await userCollection.document(uid).setData({
      'displayName': displayName,
      'userName': userName,
      'userID': userId,
      'email': email,
      'photoURL': photoURL,
      'followers': followers,
      'following': following,
      'profession': profession,
      'bio': bio,
      'createdON': createdOn,
    });
  }


   factory CreateUserDatabase.fromDocument(DocumentSnapshot doc) {
    return CreateUserDatabase(
      uid: doc['uid'],
      email: doc['email'],
      userName: doc['userName'],
      photoURL: doc['photoURL'],
      displayName: doc['displayName'],
      followers: doc['followers'],
      following: doc['following'],
      profession: doc['profession'],
      bio: doc['bio'],
      createdOn: doc['createtdOn'],
    );
  }
}
