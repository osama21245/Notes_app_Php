import 'package:flutter/material.dart';
import 'package:notes_php_app/notes/add.dart';
import 'package:notes_php_app/screens/homescreen.dart';
import 'package:notes_php_app/screens/loginscreen.dart';
import 'package:notes_php_app/screens/signinscreen.dart';
import 'package:notes_php_app/screens/succes.dart';
import 'package:notes_php_app/screens/welcomescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: pref.getString("id") == null ? "./" : "Home",
      routes: {
        "./": (context) => Loginscreen(),
        "signup": (context) => Signupscreen(),
        "Home": (context) => Homescreen(),
        "Succes": (context) => Sucess(),
        "Add": (context) => AddScreen(),
      },
    );
  }
}
