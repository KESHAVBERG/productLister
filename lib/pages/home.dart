import 'package:flutter/material.dart';
import 'package:messageapp/helper/authprovider.dart';
import 'package:messageapp/pages/profile.dart';
import 'package:messageapp/pages/search.dart';

class Home extends StatefulWidget {
  final String id;

  const Home({Key key, this.id}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin {
  TabController controller;

  _HomeState(){
    controller = TabController(length: 2,vsync: this );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: FlatButton(
//          onPressed: () {
//            AuthProvider().logout();
//          },
//          color: Colors.red,
//          child: Text("LogOut"),
//        ),
      actions: [
        FlatButton(
          onPressed: () {
            AuthProvider().logout();
          },
          color: Colors.transparent,
          child: Text("LogOut"),
        )
      ],

        bottom: TabBar(
          indicatorColor:Colors.greenAccent ,
          controller: controller,
          tabs: [
            Icon(Icons.person),
            Icon(Icons.search),

          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          Profile(id: widget.id,),
          Search(id: widget.id,),

        ],
      ),
    );
  }
}
