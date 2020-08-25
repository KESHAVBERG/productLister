import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messageapp/helper/authprovider.dart';
import 'package:messageapp/model/profileModel.dart';
import 'package:messageapp/pages/update.dart';

class Profile extends StatefulWidget {
  final String id;

  const Profile({Key key, this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  rowofNames(String title, word) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          word,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.update),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Update(
                          id: widget.id,
                        )));
          },
          label: Text(
            "update Product List",
            style: TextStyle(color: Colors.black),
          )),
      body: Container(
        child: StreamBuilder<ProfileModel>(
          stream: Firestore.instance
              .collection("user")
              .document(widget.id)
              .get()
              .asStream()
              .map((doc) => ProfileModel.fromDocument(doc)),
          builder: (context, snapshot) {
            var userData = snapshot.data;
            return snapshot.data != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
//                        margin: 200,
                          height: 200,
                          width: 200,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(userData.image),
                          ),
                        ),
//                        name and shop name
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Wrap(
                            direction: Axis.vertical,
                            children: [
                              rowofNames("name", userData.name),
                              rowofNames("ShopName", userData.sn),
//                        email and address
                              Container(
                                  child: rowofNames("address", userData.add)),
                              rowofNames("email", userData.email),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
