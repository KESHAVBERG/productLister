import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messageapp/helper/authprovider.dart';
import 'package:messageapp/pages/home.dart';
import 'package:messageapp/pages/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthProvider _authProvider = AuthProvider();
  File image;
  final picker = ImagePicker();

  Future getImg() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage.path);
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Text(
                  "Register!",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
//Image Shower
              image == null
                  ? GestureDetector(
                      onTap: getImg,
                      child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 30,
                            color: Colors.white,
                          )),
                    )
                  : Container(
                      width: 150,
                      height: 100,
                      child: Center(
                        child: CircleAvatar(
                          radius: 90,
                          backgroundImage: FileImage(image),
                        ),
                      ),
                    ),

//for Name
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "this field is important";
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "name",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),

                child: TextFormField(
                  controller: shopController,
                  decoration: InputDecoration(
                      hintText: 'enter your shop name'
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),

                child: TextFormField(

//              maxLength: 10,
                  controller: addressController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'address'
                  ),
                ),
              ),
//              email********************
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
              //              password********************

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
                    if (_formKey.currentState.validate() && image != null ) {
                      dynamic result = _authProvider.register(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                          image,
                      shopController.text,
                      addressController.text);
                      if (result != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: FlatButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
