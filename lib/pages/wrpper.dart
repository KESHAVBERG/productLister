import 'package:flutter/material.dart';
import 'package:messageapp/model/user.dart';
import 'package:messageapp/pages/home.dart';
import 'package:messageapp/pages/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user != null){
      return Home(id: user.uid,);
    }else{
      return Login();
    }
  }
}
