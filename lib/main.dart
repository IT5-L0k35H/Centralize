import 'package:Centralize/screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Centralize/utils/const.dart';
import 'package:Centralize/screens/authentication/signin.dart';
import 'package:Centralize/screens/splashscreen.dart';
import 'package:Centralize/screens/authentication/signup.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: Constants.lightTheme,
        darkTheme: Constants.darkTheme,
        routes: <String, WidgetBuilder>{
          SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
          //MAIN_SCREEN: (BuildContext context) => MainScreen(),
         // SIGN_IN: (BuildContext context) => SignInPage(),
          //SIGN_UP: (BuildContext context) => SignUpScreen(),
        },
        initialRoute: SPLASH_SCREEN,
        home: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SplashScreen(),
        ));
  }
}
