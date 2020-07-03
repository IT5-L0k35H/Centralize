import 'package:Centralize/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Centralize/utils/const.dart';
import 'package:Centralize/ui/splashscreen.dart';
import 'package:Centralize/ui/signin.dart';
import 'package:Centralize/ui/signup.dart';
import 'package:Centralize/constants/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
        SIGN_IN: (BuildContext context) => SignInPage(),
        SIGN_UP: (BuildContext context) => SignUpScreen(),
      },
      initialRoute: SPLASH_SCREEN,
      home: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: MainScreen(),
        )
    );
  }
}
