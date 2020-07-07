import 'package:Centralize/screens/homeScreen/widget/drawer.dart';
import 'package:Centralize/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:Centralize/widgets/avatar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

final GlobalKey _scaffoldKey = new GlobalKey();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
 final user = Provider.of<User>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          iconSize: 30.0,
          icon: const Icon(
            //CustomIcons.menu,
            Icons.short_text,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
            ),
            title: Text(
      "Centralize",
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
          color: Colors.black87),
            ),
            centerTitle: true,
            actions: <Widget>[
      IconButton(
        iconSize: 24.0,
        icon: Icon(
          Icons.search,
        ),
        onPressed: () => {},
      ), //Navigator.push(context,
      //MaterialPageRoute(builder: (context) => UserProfile()))),
      IconButton(
        iconSize: 35.0,
        icon: Icon(
          Icons.account_circle,
        ),
        onPressed: () => {},
      ) //Navigator.push(context,
      //  MaterialPageRoute(builder: (context) => UserProfile()))),
            ],
          ),
     
        drawer: Drawar(),
        
       body: Center(
         child: Container(
             color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top:80.0),
              child: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: _buildUserInfo(user),
              ),
            ),
          ),
       ),
        
     
        ),
    );
  }


   Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photoUrl: user.photoUrl,
          radius: 50,
        ),
        SizedBox(height: 18),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(color: Colors.indigo,fontSize: 24,),
          )else(
             Text(
            'No User Name yet',
            //user.displayName,
            style: TextStyle(color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 24,),
             )
          ),
        SizedBox(height: 8),
      ],
    );
  }
}
