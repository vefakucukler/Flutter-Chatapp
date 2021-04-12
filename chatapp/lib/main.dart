import 'package:chatapp/chatapp_main.dart';
import 'package:chatapp/core/locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocators();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: ThemeData(
        primaryColor: Color(0xff252939),
        accentColor: Color(0xff252939),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatappMain(),
    );
  }
}