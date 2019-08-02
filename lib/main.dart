import 'package:flutter/material.dart';
import 'UI/homepage.dart';
import 'UI/loginpage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginPage(),
      routes:<String,WidgetBuilder>{
        '/home':(BuildContext context)=>HomePage(),
        '/login':(BuildContext context)=>LoginPage(),
      },
    );
  }
}