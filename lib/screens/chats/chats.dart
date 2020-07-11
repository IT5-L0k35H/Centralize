import 'package:Centralize/screens/profile/userProfile.dart';
import 'package:flutter/material.dart';
class Chats extends StatefulWidget {
  Chats({Key key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
   String otheruserID='uNscO5AO9oSvsGAL8sQQcTZ0Ixa2';
  @override
  Widget build(BuildContext context) {
 
    print(otheruserID);
  //final user = Provider.of<CreateUserDatabase>(context);
    return SafeArea(
      child: Scaffold(
        //  key: _scaffoldKey,
          appBar: AppBar(
                      title: Text(
      "Check other user profile",
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
          color: Colors.black87),
            ),
            centerTitle: true,
            
          ),
     
       
        
       body: Center(
         child: RaisedButton(
           child: Text('See Profile'),
           color: Colors.amber,
           
           onPressed:  () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserProfile(otheruserID)),),),
       ),
        ),
        
     
       
    );

}}