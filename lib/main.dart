import 'package:flutter/material.dart';
import 'package:messageapp/helper/authprovider.dart';
import 'package:messageapp/model/user.dart';
import 'package:messageapp/pages/wrpper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthProvider().usere,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       theme: ThemeData(
         primaryColor: Colors.black,
         accentColor: Colors.greenAccent,
         brightness: Brightness.dark,


       ),
        home: Wrapper(),
      ),
    );
  }
}

