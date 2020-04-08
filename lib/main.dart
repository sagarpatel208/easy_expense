import 'package:easyexpense/Screen/AddCustomer.dart';
import 'package:easyexpense/Screen/Home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Expence',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        '/Home': (context) => Home(),
        '/AddCustomer': (context) => AddCustomer(),
      },
    );
  }
}
