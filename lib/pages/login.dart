import 'package:flutter/material.dart';
import 'package:messageapp/helper/authprovider.dart';
import 'package:messageapp/pages/home.dart';
import 'package:messageapp/pages/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthProvider _authProvider = AuthProvider();

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Text(
                  "Login!",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "this field is important";
                    } else if (!val.contains("@")) {
                      return "enter a vaild email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "email",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  obscureText: true,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "this field is important";
                    } else if (val.length > 12) {
                      return "Too Long";
                    } else if (val.length < 2) {
                      return "Too Short";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "password",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: FlatButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      dynamic result = _authProvider.signIn(
                          emailController.text,
                          passwordController.text,
                          );
                      if (result != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                    }
                  },
                  child: Text("Login",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: FlatButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>Register()
                    ));
                  },
                  child: Text("Register",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
