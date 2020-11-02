// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'register.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple listing',
      home: Register(),
    );
  }
}
