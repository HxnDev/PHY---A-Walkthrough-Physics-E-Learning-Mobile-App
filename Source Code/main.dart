import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/login_signup.dart';
import 'package:mobile_app/database/storage.dart';
import 'package:mobile_app/utilities/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Map<int, Color> color =
  {
    50 :Color.fromRGBO(45, 30, 64, .1),
    100:Color.fromRGBO(45, 30, 64, .2),
    200:Color.fromRGBO(45, 30, 64, .3),
    300:Color.fromRGBO(45, 30, 64, .4),
    400:Color.fromRGBO(45, 30, 64, .5),
    500:Color.fromRGBO(45, 30, 64, .6),
    600:Color.fromRGBO(45, 30, 64, .7),
    700:Color.fromRGBO(45, 30, 64, .8),
    800:Color.fromRGBO(45, 30, 64, .9),
    900:Color.fromRGBO(45, 30, 64, 1),

  };
  //MaterialColor colorCustom = MaterialColor(0xFF880E4F, MyApp().color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phy',
      theme: ThemeData(

      /*cursorColor: Colors.red,
              cupertinoOverrideTheme: CupertinoThemeData(
                primaryColor: Colors.red,
              ),*/
       //DON'T REMOVE I AM KEEPING THIS FOR LATER

        primarySwatch: Colors.deepPurple,
        // bottomAppBarColor: colorCustom,
      ),
      home: LoginSignUpPage(title: 'Login and Signup'),
    );
  }
}
