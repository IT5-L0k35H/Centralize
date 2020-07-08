import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUserDatabase {
  CreateUserDatabase({this.uid});
  final String uid;

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  get userName => null;

  Future updateUserData(
    String displayName,
    String userName,
    String email,
    String photoURL,
    String userId,
    String bio,
    DateTime createdOn,
  ) async {
    return await userCollection.document(uid).setData({
      'displayName': displayName,
      'userName': userName,
      'userID': userId,
      'email': email,
      'photoURL': photoURL,
      'bio': bio,
      'createdON': createdOn,
    });
  }
}
